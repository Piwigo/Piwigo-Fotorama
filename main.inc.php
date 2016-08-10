<?php
/*
Plugin Name: Fotorama
Version: 2.7.r
Description: Fotorama based full-screen slideshow
Plugin URI: http://piwigo.org/ext/extension_view.php?eid=727
Author: JanisV
*/

global $conf;

if (!defined('PHPWG_ROOT_PATH')) die('Hacking attempt!');

if (mobile_theme()) return;

define('FOTORAMA_ID',       basename(dirname(__FILE__)));
define('FOTORAMA_PATH' ,    PHPWG_PLUGINS_PATH . FOTORAMA_ID . '/');

add_event_handler('init', 'Fotorama_init');
if (defined('IN_ADMIN'))
{
  add_event_handler('get_admin_plugin_menu_links', 'Fotorama_admin_menu');
}
elseif ($conf['light_slideshow'])
{
  add_event_handler('render_element_content', 'Fotorama_element_content', EVENT_HANDLER_PRIORITY_NEUTRAL-10);
  add_event_handler('loc_end_picture', 'Fotorama_end_picture');
}

function Fotorama_is_replace_picture()
{
  global $conf;

  return ($conf['Fotorama']['replace_picture'] and (!$conf['Fotorama']['replace_picture_only_users'] or !is_admin()) and (!isset($_GET['slidestop'])));
}

function Fotorama_init()
{
  global $conf, $user;

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

function Fotorama_element_content($content)
{
  global $page;

  if (Fotorama_is_replace_picture())
  {
    $page['slideshow'] = true;
  }
  if ($page['slideshow'])
    add_event_handler('loc_end_page_header', 'Fotorama_end_page_header');

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

  if (!$page['slideshow'])
    return;

  load_language('plugin.lang', FOTORAMA_PATH);


  $split_limit = 400;
  if ('mobile' == get_device())
    $split_limit /= 2;

  $view_offset = null;
  if (count($page['items']) >= 1.2*$split_limit)
  {
    $first = $split_limit * 0.2;
    $last = $split_limit - $first;

    $first = $page['current_rank'] - $first;
    if ($first < 0)
      $first += count($page['items']);

    $last = $page['current_rank'] + $last;
    if ($last >= count($page['items']))
      $last -= count($page['items']);

    if ($first < $last)
    {
      $selection = array_slice($page['items'], $first, $last-$first);
      $view_borders = array( 0, count($selection)-1);
      $view_offset = array('from'=>0, 'offset'=>$first);
    }
    else
    {
      $selection = array_slice($page['items'], 0, $last);
      $view_borders = array( count($selection), count($selection)-1);
      $view_offset = array('from'=>count($selection), 'offset'=>$first-count($selection));

      $selection = array_merge($selection, array_slice($page['items'], $first));
    }
  }
  else
  {
    $selection = $page['items'];
    $view_borders = null;
  }

  $query = '
  SELECT *
    FROM '.IMAGES_TABLE.'
    WHERE id IN ('.implode(',', $selection).')
    ORDER BY FIELD(id, '.implode(',', $selection).')
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
    // VJS integration, is plugin VJS install and it is a supported video file by the plugin
    if (function_exists('vjs_valid_extension') and function_exists('vjs_get_mimetype_from_ext')) {
        if (vjs_valid_extension(get_extension($row['path'])) === true) {
            $row['video'] = $row['path'];
            $row['video_type'] = vjs_get_mimetype_from_ext(get_extension($row['path']));
	}
    }
    $picture[] = $row;
  }
  $picture = trigger_change('fotorama_items', $picture, $selection);
  $template->assign(array(
      'TOTAL_ITEMS' => count($page['items']),
      'view_borders' => $view_borders,
      'view_offset' => $view_offset,
      'current_rank' => array_search($page['image_id'],$selection),
    ));
  $template->assign('item_height', ImageStdParams::get_by_type($type)->max_height());
  $template->assign('items', $picture);
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

function Fotorama_end_page_header()
{
  global $template;

  $template->clear_assign( array('page_refresh',
    'first',
    'previous',
    'next',
    'last',
    ));
}

function Fotorama_admin_menu($menu)
{
  $menu[] = array(
    'NAME' => 'Fotorama',
    'URL'  => get_root_url() . 'admin.php?page=plugin-' . FOTORAMA_ID,
  );

  return $menu;
}

?>
