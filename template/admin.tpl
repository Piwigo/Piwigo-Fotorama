<div class="titrePage">
<h2>Fotorama</h2>
</div>

<form action="" method="post" class="properties">

<fieldset id="Fotorama">
<legend>{'Configuration'|@translate}</legend>
<ul>
  <li>
    <label for="allowfullscreen">
      <b>{'allowfullscreen'|@translate}</b> 
    </label>
    <select class="categoryDropDown" id="allowfullscreen" name="allowfullscreen">
      <option value="false"{if $Fotorama.allowfullscreen == 'false'} selected{/if}>{'false'|@translate}</option>
      <option value="true"{if $Fotorama.allowfullscreen == 'true'} selected{/if}>{'true'|@translate}</option>
      <option value="native"{if $Fotorama.allowfullscreen == 'native'} selected{/if}>{'native'|@translate}</option>
    </select>
  </li>
  <li>
    <label for="fit">
      <b>{'fit'|@translate}</b> 
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
      <b>{'transition'|@translate}</b> 
    </label>
    <select class="categoryDropDown" id="transition" name="transition">
      <option value="slide"{if $Fotorama.transition == 'slide'} selected{/if}>{'slide'|@translate}</option>
      <option value="crossfade"{if $Fotorama.transition == 'crossfade'} selected{/if}>{'crossfade'|@translate}</option>
      <option value="dissolve"{if $Fotorama.transition == 'dissolve'} selected{/if}>{'dissolve'|@translate}</option>
    </select>
  </li>
  <li>
    <input type="checkbox" id="shadows" name="shadows"{if $Fotorama.shadows} checked="checked"{/if}>
    <label for="shadows">
      <b>{'shadows'|@translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="autoplay" name="autoplay"{if $Fotorama.autoplay} checked="checked"{/if}>
    <label for="autoplay">
      <b>{'autoplay'|@translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="stopautoplayontouch" name="stopautoplayontouch"{if $Fotorama.stopautoplayontouch} checked="checked"{/if}>
    <label for="stopautoplayontouch">
      <b>{'stopautoplayontouch'|@translate}</b>
    </label>
  </li>
  <li>
    <input type="checkbox" id="loop" name="loop"{if $Fotorama.loop} checked="checked"{/if}>
    <label for="loop">
      <b>{'loop'|@translate}</b>
    </label>
  </li>
</ul>
</fieldset>

<p class="formButtons">
  <input type="hidden" name="pwg_token" value="{$PWG_TOKEN}">
  <input type="submit" name="submit" value="{'Save Settings'|@translate}">
</p>
</form>
