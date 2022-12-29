<div class="titrePage">
<h2>Fotorama</h2>
</div>

<form action="" method="post" class="properties">

<fieldset id="Global">
<legend>{'Global configuration'|translate}</legend>
  {'The Fotorama plugin can use two different options (called "backend") to render the slide show:
  <ul>
  <li><a href="https://fotorama.io/">Fotorama</a>, originally the only available with this plugin, has many advanced features like the ability to display thumbnails at the bottom of the slideshow. Its main disadvantage is that it does not support zooming in full screen mode. It is unsupported since 2019, hence new features should not be expected in the future.
  </li>
  <li><a href="https://photoswipe.com/">PhotoSwipe</a>, a similar tool with better support for mobile devices, which allows in particular zooming (pinch-to-zoom on mobile devices, as most users expect). The plugin currently does not support video using this backend.
  </li>
  </ul>
  A nice configuration is to pick Fotorama for desktop devices and PhotoSwipe for mobile devices, but the choice is yours.'|translate}
  <div style="height: 1ex"></div>
  <ul>
  <li>
    <label for="desktop_backend">
      <b>{'Backend for desktop:'|translate}</b>
    </label>
    <select class="categoryDropDown" id="desktop_backend" name="desktop_backend">
      <option value="fotorama" {if $Fotorama.desktop_backend == 'fotorama'} selected{/if}>{'Fotorama'|translate}
      </option>
      <option value="photoswipe" {if $Fotorama.desktop_backend == 'photoswipe'} selected{/if}>{'PhotoSwipe'|translate}
      </option>
    </select>
    </li>
    <li>
    <label for="mobile_backend">
      <b>{'Backend for mobile:'|translate}</b>
    </label>
    <select class="categoryDropDown" id="mobile_backend" name="mobile_backend">
      <option value="fotorama" {if $Fotorama.mobile_backend == 'fotorama'} selected{/if}>{'Fotorama'|translate}
      </option>
      <option value="photoswipe" {if $Fotorama.mobile_backend == 'photoswipe'} selected{/if}>{'PhotoSwipe'|translate}
      </option>
    </select>
  </li>
  <li>
      <input type="checkbox" id="replace_picture" name="replace_picture" {if $Fotorama.replace_picture}
        checked="checked" {/if}>
      <label for="replace_picture">
        <b>{'Replace picture page'|translate}</b>
      </label>
  </li>
</ul>
</fieldset>
<fieldset id="Fotorama">
<legend>{'Fotorama settings'|translate}</legend>
<ul>
  <li>
    <label for="allowfullscreen">
      <b>{'Allows fullscreen'|translate}</b> 
    </label>
    <select class="categoryDropDown" id="allowfullscreen" name="allowfullscreen">
      <option value="false"{if $Fotorama.allowfullscreen == 'false'} selected{/if}>{'false'|translate}</option>
      <option value="true"{if $Fotorama.allowfullscreen == 'true'} selected{/if}>{'true'|translate}</option>
      <option value="native"{if $Fotorama.allowfullscreen == 'native'} selected{/if}>{'native'|translate}</option>
    </select>
  </li>
  <li>
    <input type="checkbox" id="only_fullscreen" name="only_fullscreen"{if $Fotorama.only_fullscreen} checked="checked"{/if}>
    <label for="only_fullscreen">
      <b>{'Only fullscreen mode'|translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="resize" name="resize"{if $Fotorama.resize} checked="checked"{/if}>
    <label for="resize">
      <b>{'Resize to fit window'|translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="close_button" name="close_button"{if $Fotorama.close_button} checked="checked"{/if}>
    <label for="close_button">
      <b>{'Add close button'|translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="info_button" name="info_button"{if $Fotorama.info_button} checked="checked"{/if}>
    <label for="info_button">
      <b>{'Add image info button'|translate}</b>
    </label>
  </li>
  <li>
    <label for="fit">
      <b>{'How to fit an image'|translate}</b> 
    </label>
    <select class="categoryDropDown" id="fit" name="fit">
      <option value="contain"{if $Fotorama.fit == 'contain'} selected{/if}>{'contain'|translate}</option>
      <option value="cover"{if $Fotorama.fit == 'cover'} selected{/if}>{'cover'|translate}</option>
      <option value="scaledown"{if $Fotorama.fit == 'scaledown'} selected{/if}>{'scaledown'|translate}</option>
      <option value="none"{if $Fotorama.fit == 'none'} selected{/if}>{'none'|translate}</option>
    </select>
  </li>
  <li>
    <label for="transition">
      <b>{'What transition to use'|translate}</b> 
    </label>
    <select class="categoryDropDown" id="transition" name="transition">
      <option value="slide"{if $Fotorama.transition == 'slide'} selected{/if}>{'slide'|translate}</option>
      <option value="crossfade"{if $Fotorama.transition == 'crossfade'} selected{/if}>{'crossfade'|translate}</option>
      <option value="dissolve"{if $Fotorama.transition == 'dissolve'} selected{/if}>{'dissolve'|translate}</option>
    </select>
  </li>
  <li>
    &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="clicktransition_crossfade" name="clicktransition_crossfade"{if $Fotorama.clicktransition_crossfade} checked="checked"{/if}>
    <label for="clicktransition_crossfade">
      <b>{'Use crossfade transition on click'|translate}</b>
    </label>
  </li>
  <li>
    <label for="nav">
      <b>{'Navigation style'|translate}</b> 
    </label>
    <select class="categoryDropDown" id="nav" name="nav">
      <option value="false"{if $Fotorama.nav == 'false'} selected{/if}>{'false'|translate}</option>
      <option value="dots"{if $Fotorama.nav == 'dots'} selected{/if}>{'dots'|translate}</option>
      <option value="thumbs"{if $Fotorama.nav == 'thumbs'} selected{/if}>{'thumbs'|translate}</option>
    </select>
  </li>
  <li>
    <label for="fullscreen_nav">
      <b>{'Fullscreen navigation style'|translate}</b> 
    </label>
    <select class="categoryDropDown" id="fullscreen_nav" name="fullscreen_nav">
      <option value="false"{if $Fotorama.fullscreen_nav == 'false'} selected{/if}>{'false'|translate}</option>
      <option value="dots"{if $Fotorama.fullscreen_nav == 'dots'} selected{/if}>{'dots'|translate}</option>
      <option value="thumbs"{if $Fotorama.fullscreen_nav == 'thumbs'} selected{/if}>{'thumbs'|translate}</option>
    </select>
  </li>
  <li>
    <label for="thumbheight">
      <b>{'Thumbnail height (when present)'|translate}</b> 
    </label>
    <input type="number" size="2" maxlength="3" name="thumbheight" id="thumbheight" value="{$Fotorama.thumbheight}" min="5" max="300" style="width: 50px;">&nbsp;px
  </li>
  <li>
    <input type="checkbox" id="square_thumb" name="square_thumb"{if $Fotorama.square_thumb} checked="checked"{/if}>
    <label for="square_thumb">
      <b>{'Thumbnail is a square (when present)'|translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="shadows" name="shadows"{if $Fotorama.shadows} checked="checked"{/if}>
    <label for="shadows">
      <b>{'Enables shadows'|translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="autoplay" name="autoplay"{if $Fotorama.autoplay} checked="checked"{/if}>
    <label for="autoplay">
      <b>{'Enables autoplay'|translate}</b>
    </label>
  </li>
  <li>
    <label for="period">
      <b>{'Waiting time before loading a new image'|translate}</b> 
    </label>
    <input type="number" size="4" maxlength="5" name="period" id="period" value="{$Fotorama.period}" min="0" max="10000" style="width: 50px;">&nbsp;{'milliseconds'|translate}
  </li>
  <li>
    <input type="checkbox" id="stopautoplayontouch" name="stopautoplayontouch"{if $Fotorama.stopautoplayontouch} checked="checked"{/if}>
    <label for="stopautoplayontouch">
      <b>{'Stops slideshow at any user action with the fotorama'|translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="loop" name="loop"{if $Fotorama.loop} checked="checked"{/if}>
    <label for="loop">
      <b>{'Enables loop'|translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="enable_caption" name="enable_caption"{if $Fotorama.enable_caption} checked="checked"{/if}>
    <label for="enable_caption">
      <b>{'Show caption with '|translate}</b>
    </label>
    <select class="categoryDropDown" id="enable_caption_with" name="enable_caption_with">
      <option value="title"{if $Fotorama.enable_caption_with == 'title'} selected="selected"{/if}>{'title'|translate}</option>
      <option value="comment"{if $Fotorama.enable_caption_with == 'comment'} selected="selected"{/if}>{'description'|translate}</option>
    </select>
  </li>
  <li>
    &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="replace_picture_only_users" name="replace_picture_only_users"{if $Fotorama.replace_picture_only_users} checked="checked"{/if}>
    <label for="replace_picture_only_users">
      <b>{'except an administrator'|translate}</b>
    </label>
  </li>
</ul>
</fieldset>
<fieldset id="Photoswipe">
  <legend>{'PhotoSwipe settings'|translate}</legend>
  <ul>
    <li>
      <input type="checkbox" id="photoswipe_info_button" name="photoswipe_info_button" {if $Fotorama.photoswipe_info_button} checked="checked" {/if}>
      <label for="photoswipe_info_button">
        <b>{'Add image info button'|translate}</b>
      </label>
    </li>
    <li>
      <input type="checkbox" id="photoswipe_allowfullscreen" name="photoswipe_allowfullscreen" {if $Fotorama.photoswipe_allowfullscreen} checked="checked" {/if}>
      <label for="photoswipe_allowfullscreen">
        <b>{'Allows fullscreen'|translate}</b>
      </label>
    </li>
  </ul>
</fieldset>

<p class="formButtons">
  <input type="hidden" name="pwg_token" value="{$PWG_TOKEN}">
  <input type="submit" name="submit" value="{'Save Settings'|translate}">
</p>
</form>

{footer_script require='jquery'}{literal}
  function update_Fotorama_state() {
    jQuery('#Fotorama').prop('disabled',
      !(jQuery('#mobile_backend').val() == "fotorama" || jQuery('#desktop_backend').val() == "fotorama"));
    jQuery('#Photoswipe').prop('disabled',
      !(jQuery('#mobile_backend').val() == "photoswipe" || jQuery('#desktop_backend').val() == "photoswipe"));
    if (jQuery('#allowfullscreen').val() == "false") {
      jQuery('#only_fullscreen').prop('disabled', true);
      jQuery('#only_fullscreen').removeAttr('checked');
      jQuery('#nav').prop('disabled', false);
      jQuery('#fullscreen_nav').prop('disabled', true);
    }
    else if (jQuery('#allowfullscreen').val() == "native") {
      jQuery('#only_fullscreen').prop('disabled', true);
      jQuery('#only_fullscreen').removeAttr('checked');
    }
    else {
      jQuery('#only_fullscreen').prop('disabled', false);
      jQuery('#fullscreen_nav').prop('disabled', false);
    }

    if(jQuery('#only_fullscreen').is(":checked")) {
      jQuery('#nav').prop('disabled', true);
      jQuery('#resize').prop('disabled', true);
    }
    else {
      jQuery('#nav').prop('disabled', false);
      jQuery('#resize').prop('disabled', false);
    }

    if (jQuery('#transition').val() == "slide") {
      jQuery('#clicktransition_crossfade').prop('disabled', false);
    }
    else {
      jQuery('#clicktransition_crossfade').prop('disabled', true);
      jQuery('#clicktransition_crossfade').removeAttr('checked');
    }

    if(jQuery('#replace_picture').is(":checked")) {
      jQuery('#replace_picture_only_users').prop('disabled', false);
    }
    else {
      jQuery('#replace_picture_only_users').prop('disabled', true);
      jQuery('#replace_picture_only_users').removeAttr('checked');
    }

    if(jQuery('#autoplay').is(":checked")) {
      jQuery('#period').prop('disabled', false);
    }
    else {
      jQuery('#period').prop('disabled', true);
    }

    if(jQuery('#enable_caption').is(":checked")) {
      jQuery('#enable_caption_with').prop('disabled', false);
    }
    else {
      jQuery('#enable_caption_with').prop('disabled', true);
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
  jQuery('#transition').change(function() {
    update_Fotorama_state();
  });
  jQuery('#replace_picture').change(function() {
    update_Fotorama_state();
  });
  jQuery('#autoplay').change(function() {
    update_Fotorama_state();
  });
  jQuery('#enable_caption').change(function() {
    update_Fotorama_state();
  });
  jQuery('#mobile_backend').change(function() {
    update_Fotorama_state();
  });
  jQuery('#desktop_backend').change(function() {
    update_Fotorama_state();
  });
{/literal}{/footer_script}
