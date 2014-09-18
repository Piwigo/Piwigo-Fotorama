<?php

defined('FOTORAMA_PATH') or die('Hacking attempt!');

global $conf, $template, $page;

if (isset($_POST['submit']))
{
  $conf['Fotorama'] = array(
    'shadows' => isset($_POST['shadows']),
    'only_fullscreen' => isset($_POST['only_fullscreen']),
    'autoplay' => isset($_POST['autoplay']),
    'stopautoplayontouch' => isset($_POST['stopautoplayontouch']),
    'loop' => isset($_POST['loop']),
    'enable_caption' => isset($_POST['enable_caption']),
    'replace_picture' => isset($_POST['replace_picture']),
    'replace_picture_only_users' => isset($_POST['replace_picture_only_users']),
    'clicktransition_crossfade' => isset($_POST['clicktransition_crossfade']),
    );
  if (isset($_POST['allowfullscreen']))
    $conf['Fotorama']['allowfullscreen'] = $_POST['allowfullscreen'];
  if (isset($_POST['fit']))
    $conf['Fotorama']['fit'] = $_POST['fit'];
  if (isset($_POST['transition']))
    $conf['Fotorama']['transition'] = $_POST['transition'];
  if (isset($_POST['nav']))
    $conf['Fotorama']['nav'] = $_POST['nav'];
  if (isset($_POST['fullscreen_nav']))
    $conf['Fotorama']['fullscreen_nav'] = $_POST['fullscreen_nav'];
  if (isset($_POST['thumbheight']))
    $conf['Fotorama']['thumbheight'] = $_POST['thumbheight'];

  conf_update_param('Fotorama', serialize($conf['Fotorama']));
  $page['infos'][] = l10n('Information data registered in database');
}

$template->assign(array(
  'Fotorama' => $conf['Fotorama'],
  ));

$template->set_filename('admintools_content', realpath(FOTORAMA_PATH . 'template/admin.tpl'));
$template->assign_var_from_handle('ADMIN_CONTENT', 'admintools_content');

?>
