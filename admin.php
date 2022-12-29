<?php

defined('FOTORAMA_PATH') or die('Hacking attempt!');

global $conf, $template, $page;
load_language('plugin.lang', FOTORAMA_PATH);

if (isset($_POST['submit']))
{
  $old_conf = $conf;

  $conf['Fotorama'] = array(
    'shadows' => isset($_POST['shadows']),
    'only_fullscreen' => isset($_POST['only_fullscreen']),
    'autoplay' => isset($_POST['autoplay']),
    'stopautoplayontouch' => isset($_POST['stopautoplayontouch']),
    'loop' => isset($_POST['loop']),
    'enable_caption' => isset($_POST['enable_caption']),
    'enable_caption_with' => isset($_POST['enable_caption_with']) ? $_POST['enable_caption_with'] : 'title',
    'replace_picture' => isset($_POST['replace_picture']),
    'replace_picture_only_users' => isset($_POST['replace_picture_only_users']),
    'clicktransition_crossfade' => isset($_POST['clicktransition_crossfade']),
    'close_button' => isset($_POST['close_button']),
    'resize' => isset($_POST['resize']),
    'info_button' => isset($_POST['info_button']),
    'square_thumb' => isset($_POST['square_thumb']),
    );
  if (isset($_POST['mobile_backend']))
    $conf['Fotorama']['mobile_backend'] = $_POST['mobile_backend'];
  else
    $conf['Fotorama']['mobile_backend'] = $old_conf['Fotorama']['mobile_backend'];
  if (isset($_POST['desktop_backend']))
    $conf['Fotorama']['desktop_backend'] = $_POST['desktop_backend'];
  else
    $conf['Fotorama']['desktop_backend'] = $old_conf['Fotorama']['desktop_backend'];
  if (isset($_POST['allowfullscreen']))
    $conf['Fotorama']['allowfullscreen'] = $_POST['allowfullscreen'];
  else
    $conf['Fotorama']['allowfullscreen'] = $old_conf['Fotorama']['allowfullscreen'];
  if (isset($_POST['fit']))
    $conf['Fotorama']['fit'] = $_POST['fit'];
  else
    $conf['Fotorama']['fit'] = $old_conf['Fotorama']['fit'];
  if (isset($_POST['transition']))
    $conf['Fotorama']['transition'] = $_POST['transition'];
  else
    $conf['Fotorama']['transition'] = $old_conf['Fotorama']['transition'];
  if (isset($_POST['nav']))
    $conf['Fotorama']['nav'] = $_POST['nav'];
  else
    $conf['Fotorama']['nav'] = $old_conf['Fotorama']['nav'];
  if (isset($_POST['fullscreen_nav']))
    $conf['Fotorama']['fullscreen_nav'] = $_POST['fullscreen_nav'];
  else
    $conf['Fotorama']['fullscreen_nav'] = $old_conf['Fotorama']['fullscreen_nav'];
  if (isset($_POST['thumbheight']))
    $conf['Fotorama']['thumbheight'] = $_POST['thumbheight'];
  else
    $conf['Fotorama']['thumbheight'] = $old_conf['Fotorama']['thumbheight'];
  if (isset($_POST['period']))
    $conf['Fotorama']['period'] = $_POST['period'];
  else
    $conf['Fotorama']['period'] = $old_conf['Fotorama']['period'];

  conf_update_param('Fotorama', serialize($conf['Fotorama']));
  $page['infos'][] = l10n('Information data registered in database');
}

$template->assign(array(
  'Fotorama' => $conf['Fotorama'],
  ));

$template->set_filename('plugin_admin_content', realpath(FOTORAMA_PATH . 'template/admin.tpl'));
$template->assign_var_from_handle('ADMIN_CONTENT', 'plugin_admin_content');

?>
