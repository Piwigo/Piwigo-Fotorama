<script>
var image_w = {$item_height};
var image_h = {$item_height};
</script>

<div id="slideshow">
  <div id="imageHeaderBar">
	<div class="browsePath">
	  {if isset($U_SLIDESHOW_STOP) }
		[ <a href="{$U_SLIDESHOW_STOP}">{'stop the slideshow'|translate}</a> ]
	  {/if}
	  <h2 class="showtitle">{$current.TITLE}</h2>
	</div>
  </div>

  <div id="imageToolBar">
	<div class="imageNumber">{$PHOTO}</div>
  </div>

  <div id="content">
	<div id="theImage">
      {include file=$FOTORAMA_CONTENT_PATH}
	</div>
  </div>
</div>
