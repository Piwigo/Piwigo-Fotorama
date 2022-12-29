<?php

defined('PHPWG_ROOT_PATH') or die('Hacking attempt!');

class Fotorama_maintain extends PluginMaintain
{
  private $installed = false;

  private $default_conf = array(
    'mobile_backend' => 'fotorama',
    'desktop_backend' => 'fotorama',
    'allowfullscreen' => 'native',
    'fit' => 'scaledown',
    'transition' => 'slide',
    'shadows' => false,
    'autoplay' => true,
    'stopautoplayontouch' => false,
    'loop' => true,
    'nav' => 'false',
    'fullscreen_nav' => 'false',
    'only_fullscreen' => false,
    'enable_caption' => false,
    'enable_caption_with' => 'title',
    'thumbheight' => 64,
    'replace_picture' => false,
    'replace_picture_only_users' => false,
    'clicktransition_crossfade' => true,
    'close_button' => false,
    'resize' => false,
    'period' => 4000,
    'info_button' => false,
    'square_thumb' => true,
  );

  function __construct($plugin_id)
  {
    parent::__construct($plugin_id);
  }

  function install($plugin_version, &$errors=array())
  {
    global $conf;

    if (empty($conf['Fotorama']))
    {
      $conf['Fotorama'] = serialize($this->default_conf);
      conf_update_param('Fotorama', $conf['Fotorama']);
    }
    else
    {
      $new_conf = is_string($conf['Fotorama']) ? unserialize($conf['Fotorama']) : $conf['Fotorama'];

      $conf['Fotorama'] = serialize($new_conf);
      conf_update_param('Fotorama', $conf['Fotorama']);
    }

    // add a new column to existing table
    $result = pwg_query('SHOW COLUMNS FROM `'.HISTORY_TABLE.'` LIKE "is_slideshow";');
    if (!pwg_db_num_rows($result))
    {
      pwg_query('ALTER TABLE `' . HISTORY_TABLE . '` ADD `is_slideshow` enum(\'true\',\'false\') NOT NULL DEFAULT \'false\';');
    }
    
    $this->installed = true;
  }

  function activate($plugin_version, &$errors=array())
  {
    if (!$this->installed)
    {
      $this->install($plugin_version, $errors);
    }
  }

  function deactivate()
  {
  }

  function update($old_version, $new_version, &$errors=array())
  {
    $this->install($new_version, $errors);
  }

  function uninstall()
  {
    conf_delete_param('Fotorama');

    pwg_query('ALTER TABLE `'. HISTORY_TABLE .'` DROP `is_slideshow`;');
  }
}

?>
