<div class="titrePage">
<h2>Fotorama</h2>
</div>

<form action="" method="post" class="properties">

<fieldset id="Fotorama">
<legend>{'Configuration'|@translate}</legend>
<ul>
  <li>
    <label for="allowfullscreen">
      <b>{'Allows fullscreen'|@translate}</b> 
    </label>
    <select class="categoryDropDown" id="allowfullscreen" name="allowfullscreen">
      <option value="false"{if $Fotorama.allowfullscreen == 'false'} selected{/if}>{'false'|@translate}</option>
      <option value="true"{if $Fotorama.allowfullscreen == 'true'} selected{/if}>{'true'|@translate}</option>
      <option value="native"{if $Fotorama.allowfullscreen == 'native'} selected{/if}>{'native'|@translate}</option>
    </select>
  </li>
  <li>
    <input type="checkbox" id="only_fullscreen" name="only_fullscreen"{if $Fotorama.only_fullscreen} checked="checked"{/if}>
    <label for="only_fullscreen">
      <b>{'Only fullscreen mode'|@translate}</b>
    </label>
  </li>
  <li>
    <label for="fit">
      <b>{'How to fit an image'|@translate}</b> 
    </label>
    <select class="categoryDropDown" id="fit" name="fit">
      <option value="contain"{if $Fotorama.fit == 'contain'} selected{/if}>{'contain'|@translate}</option>
      <option value="cover"{if $Fotorama.fit == 'cover'} selected{/if}>{'cover'|@translate}</option>
      <option value="scaledown"{if $Fotorama.fit == 'scaledown'} selected{/if}>{'scaledown'|@translate}</option>
      <option value="none"{if $Fotorama.fit == 'none'} selected{/if}>{'none'|@translate}</option>
    </select>
  </li>
  <li>
    <label for="transition">
      <b>{'What transition to use'|@translate}</b> 
    </label>
    <select class="categoryDropDown" id="transition" name="transition">
      <option value="slide"{if $Fotorama.transition == 'slide'} selected{/if}>{'slide'|@translate}</option>
      <option value="crossfade"{if $Fotorama.transition == 'crossfade'} selected{/if}>{'crossfade'|@translate}</option>
      <option value="dissolve"{if $Fotorama.transition == 'dissolve'} selected{/if}>{'dissolve'|@translate}</option>
    </select>
  </li>
  <li>
    <label for="nav">
      <b>{'Navigation style'|@translate}</b> 
    </label>
    <select class="categoryDropDown" id="nav" name="nav">
      <option value="false"{if $Fotorama.nav == 'false'} selected{/if}>{'false'|@translate}</option>
      <option value="dots"{if $Fotorama.nav == 'dots'} selected{/if}>{'dots'|@translate}</option>
      <option value="thumbs"{if $Fotorama.nav == 'thumbs'} selected{/if}>{'thumbs'|@translate}</option>
    </select>
  </li>
  <li>
    <label for="fullscreen_nav">
      <b>{'Fullscreen navigation style'|@translate}</b> 
    </label>
    <select class="categoryDropDown" id="fullscreen_nav" name="fullscreen_nav">
      <option value="false"{if $Fotorama.fullscreen_nav == 'false'} selected{/if}>{'false'|@translate}</option>
      <option value="dots"{if $Fotorama.fullscreen_nav == 'dots'} selected{/if}>{'dots'|@translate}</option>
      <option value="thumbs"{if $Fotorama.fullscreen_nav == 'thumbs'} selected{/if}>{'thumbs'|@translate}</option>
    </select>
  </li>
  <li>
    <input type="checkbox" id="shadows" name="shadows"{if $Fotorama.shadows} checked="checked"{/if}>
    <label for="shadows">
      <b>{'Enables shadows'|@translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="autoplay" name="autoplay"{if $Fotorama.autoplay} checked="checked"{/if}>
    <label for="autoplay">
      <b>{'Enables autoplay'|@translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="stopautoplayontouch" name="stopautoplayontouch"{if $Fotorama.stopautoplayontouch} checked="checked"{/if}>
    <label for="stopautoplayontouch">
      <b>{'Stops slideshow at any user action with the fotorama'|@translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="loop" name="loop"{if $Fotorama.loop} checked="checked"{/if}>
    <label for="loop">
      <b>{'Enables loop'|@translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="enable_caption" name="enable_caption"{if $Fotorama.enable_caption} checked="checked"{/if}>
    <label for="enable_caption">
      <b>{'Show caption with image title'|@translate}</b>
    </label>
  </li>
</ul>
</fieldset>

<p class="formButtons">
  <input type="hidden" name="pwg_token" value="{$PWG_TOKEN}">
  <input type="submit" name="submit" value="{'Save Settings'|@translate}">
</p>
</form>

{footer_script require='jquery'}{literal}
  function update_Fotorama_state() {
    if (jQuery('#allowfullscreen').val() == "false") {
      jQuery('#only_fullscreen').prop('disabled', true);
      jQuery('#only_fullscreen').removeAttr('checked');
      jQuery('#nav').prop('disabled', false);
      jQuery('#fullscreen_nav').prop('disabled', true);
    }
    else if {
      jQuery('#only_fullscreen').prop('disabled', true);
      jQuery('#only_fullscreen').removeAttr('checked');
    }
    else {
      jQuery('#only_fullscreen').prop('disabled', false);
      jQuery('#fullscreen_nav').prop('disabled', false);
    }

    if(jQuery('#only_fullscreen').is(":checked")) {
      jQuery('#nav').prop('disabled', true);
    }
    else {
      jQuery('#nav').prop('disabled', false);
    }
  }
  jQuery().ready(function() {
    update_Fotorama_state();
  });
  jQuery('#allowfullscreen').change(function() {
    update_Fotorama_state();
  });
  jQuery('#only_fullscreen').change(function() {
    update_Fotorama_state();
  });
  
{/literal}{/footer_script}
