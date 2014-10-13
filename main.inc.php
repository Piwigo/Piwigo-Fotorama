<?php
/*
Plugin Name: Fotorama
Version: auto
Description: Fotorama based full-screen slideshow
Plugin URI: auto
Author: JanisV
*/

global $conf;

if (!defined('PHPWG_ROOT_PATH')) die('Hacking attempt!');

if (mobile_theme()) return;

define('FOTORAMA_ID',       basename(dirname(__FILE__)));
define('FOTORAMA_PATH' ,    PHPWG_PLUGINS_PATH . FOTORAMA_ID . '/');
define('FOTORAMA_ADMIN',    get_root_url() . 'admin.php?page=plugin-' . FOTORAMA_ID);

add_event_handler('init', 'Fotorama_init');
if (defined('IN_ADMIN'))
{
  add_event_handler('get_admin_plugin_menu_links', 'Fotorama_admin_menu');
}
else
{
  if ($conf['light_slideshow'])
  {
    add_event_handler('render_element_content', 'Fotorama_element_content', EVENT_HANDLER_PRIORITY_NEUTRAL-10);
    add_event_handler('loc_end_picture', 'Fotorama_end_picture');
    add_event_handler('loc_end_page_header', 'Fotorama_end_page_header');
  }
}

function Fotorama_is_replace_picture()
{
  global $conf;

  return ($conf['Fotorama']['replace_picture'] and (!$conf['Fotorama']['replace_picture_only_users'] or !is_admin()) and (!isset($_GET['slidestop'])));
}

function Fotorama_init()
{
  global $conf, $user;

  load_language('plugin.lang', FOTORAMA_PATH);

  $conf['Fotorama'] = unserialize($conf['Fotorama']);

  // Upgrade params from 2.7.j
  if (!isset($conf['Fotorama']['thumbheight'])) {
	$conf['Fotorama']['thumbheight'] = 64;
  }
  // Upgrade params from 2.7.l
  if (!isset($conf['Fotorama']['replace_picture'])) {
	$conf['Fotorama']['replace_picture'] = false;
	$conf['Fotorama']['replace_picture_only_users'] = false;
	$conf['Fotorama']['clicktransition_crossfade'] = false;
  }
  // Upgrade params from 2.7.m
  if (!isset($conf['Fotorama']['close_button'])) {
	$conf['Fotorama']['close_button'] = false;
	$conf['Fotorama']['resize'] = false;
  }
  // Upgrade params from 2.7.n
  if (!isset($conf['Fotorama']['period'])) {
	$conf['Fotorama']['period'] = 4000;
    $conf['Fotorama']['info_button'] = false;
    $conf['Fotorama']['square_thumb'] = true;
  }

  if ($user['theme'] == 'modus' and Fotorama_is_replace_picture())
  {
    remove_event_handler('loc_begin_picture', 'modus_loc_begin_picture');
  }
}

function Fotorama_element_content($content, $picture)
{
  global $page;

  if (Fotorama_is_replace_picture())
  {
    $page['slideshow'] = true;
  }

  return $content;
}

function Fotorama_end_picture()
{
  global $template, $conf, $user, $page;

  if (Fotorama_is_replace_picture())
  {
    $url_up = duplicate_index_url(
      array(
        'start' =>
          floor($page['current_rank'] / $page['nb_image_page'])
          * $page['nb_image_page']
        ),
      array(
        'start',
        )
      );
    //slideshow end
    $template->assign(
      array(
        'U_SLIDESHOW_STOP' => $url_up,
        )
      );

    $template->assign('replace_picture', true);
  }
  
  if ($page['slideshow'])
  {
    $query = '
    SELECT *
      FROM '.IMAGES_TABLE.'
      WHERE id IN ('.implode(',', $page['items']).')
      ORDER BY FIELD(id, '.implode(',', $page['items']).')
    ;';

    $result = pwg_query($query);

    $current = $template->get_template_vars('current');
    if (isset($current['selected_derivative']))
    {
      $type = $current['selected_derivative']->get_type();
    }

    $defined = ImageStdParams::get_defined_type_map();
    if (!isset($type) or !isset($defined[$type]))
    {
      $type = pwg_get_session_var('picture_deriv', $conf['derivative_default_size']);
    }
    
    $skip = -1;
    $big_type = $type;
    $next_type = $type;
    foreach (ImageStdParams::get_defined_type_map() as $def_type => $params)
    {
      if ($def_type == $type)
        $skip = 2;
      if ($skip >= 0)
        $big_type = $def_type;
      if ($skip >= 1 and $conf['Fotorama']['resize'])
        $next_type = $def_type;
      if ($skip == 0)
        break;
      $skip = $skip - 1;
    }
    $type = $next_type; // +1 size for inpage slideshow
    if ($conf['Fotorama']['only_fullscreen'])
    {
      $type = $big_type;
    }
    $type_params = ImageStdParams::get_by_type($type);
    $big_type_params = ImageStdParams::get_by_type($big_type);

    if ($conf['Fotorama']['nav'] == 'thumbs' or $conf['Fotorama']['fullscreen_nav'] == 'thumbs')
    {
      $has_thumbs = true;
    }
    else
    {
      $has_thumbs = false;
    }
    
    if ($has_thumbs)
    {
      if ($conf['Fotorama']['square_thumb'])
      {
        $thumb_params = ImageStdParams::get_custom($conf['Fotorama']['thumbheight'], $conf['Fotorama']['thumbheight'], 1, $conf['Fotorama']['thumbheight'], $conf['Fotorama']['thumbheight']);
      }
      else
      {
        $thumb_params = ImageStdParams::get_custom(9999, $conf['Fotorama']['thumbheight']);
      }
    }

    $picture = array();
    while ($row = pwg_db_fetch_assoc($result))
    {
      $row['src_image'] = new SrcImage($row);
      $row['derivative'] = new DerivativeImage($type_params, $row['src_image']);
      $row['derivative_big'] = new DerivativeImage($big_type_params, $row['src_image']);

      if ($has_thumbs)
      {
        $row['derivative_thumb'] = new DerivativeImage($thumb_params, $row['src_image']);
      }

      $row['url'] = duplicate_picture_url(
        array(
          'image_id' => $row['id'],
          'image_file' => $row['file'],
          ),
        array(
          'start',
          )
        );

      $row['TITLE'] = render_element_name($row);
      $picture[] = $row;
    }
    
    $template->assign('item_height', ImageStdParams::get_by_type($type)->max_height());
    $template->assign('items', $picture);
    $template->assign('current_rank', $page['current_rank']);
    $template->assign(array('Fotorama' => $conf['Fotorama']));
    $template->assign('Fotorama_has_thumbs', $has_thumbs);
    if (is_file('./themes/'.$user['theme'].'/template/fotorama.tpl'))
    {
      $template->set_filenames( array('slideshow' => realpath('./themes/'.$user['theme'].'/template/fotorama.tpl')));
    }
    else
    {
      $template->set_filenames( array('slideshow' => realpath(FOTORAMA_PATH.'template/fotorama.tpl')));
    }
    $template->assign('FOTORAMA_CONTENT_PATH', realpath(FOTORAMA_PATH.'template/fotorama-content.tpl'));
  }
}

function Fotorama_end_page_header()
{
  global $template, $page;

  if (isset($page['slideshow']) and $page['slideshow'])
  {
    $template->clear_assign('page_refresh');
    $template->clear_assign('first');
    $template->clear_assign('previous');
    $template->clear_assign('next');
    $template->clear_assign('last');
  }
}

function Fotorama_admin_menu($menu)
{
  $menu[] = array(
    'NAME' => 'Fotorama',
    'URL'  => FOTORAMA_ADMIN,
  );

  return $menu;
}

?>