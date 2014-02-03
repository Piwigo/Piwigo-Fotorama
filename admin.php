<?php

defined('FOTORAMA_PATH') or die('Hacking attempt!');

global $conf, $template, $page;

if (isset($_POST['submit']))
{
  $conf['Fotorama'] = array(
    'shadows' => isset($_POST['shadows']),
    'autoplay' => isset($_POST['autoplay']),
    'stopautoplayontouch' => isset($_POST['stopautoplayontouch']),
    'loop' => isset($_POST['loop']),
    );
  if (isset($_POST['allowfullscreen']))
    $conf['Fotorama']['allowfullscreen'] = $_POST['allowfullscreen'];
  if (isset($_POST['fit']))
    $conf['Fotorama']['fit'] = $_POST['fit'];
  if (isset($_POST['transition']))
    $conf['Fotorama']['transition'] = $_POST['transition'];

  conf_update_param('Fotorama', serialize($conf['Fotorama']));
  $page['infos'][] = l10n('Information data registered in database');
}

$template->assign(array(
  'Fotorama' => $conf['Fotorama'],
  ));

$template->set_filename('admintools_content', realpath(FOTORAMA_PATH . 'template/admin.tpl'));
$template->assign_var_from_handle('ADMIN_CONTENT', 'admintools_content');

?>
