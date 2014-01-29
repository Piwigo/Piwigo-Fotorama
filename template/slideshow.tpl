{combine_css path="plugins/Fotorama/fotorama/fotorama.css"}
{combine_script id='fotorama' require='jquery' load='header' path='plugins/Fotorama/fotorama/fotorama.js'}

<div id="slideshow">
	<div id="imageHeaderBar">
	  <div class="browsePath">
		{if isset($U_SLIDESHOW_STOP) }
		[ <a href="{$U_SLIDESHOW_STOP}">{'stop the slideshow'|@translate}</a> ]
		{/if}
			<h2 class="showtitle">{$current.TITLE}</h2>
	  </div>
	</div>

	<div id="imageToolBar">
	  <div class="imageNumber">{$PHOTO}</div>
	</div>

	<div id="content">
	<div id="theImage">
      <div class="fotorama" data-startindex="{$current_rank}" data-ratio="16/9" data-fit="scaledown"
        data-width="100%" data-maxheight="100%" data-minheight="200" data-height="{$item_height}" data-allowfullscreen="native" data-autoplay=true data-stopautoplayontouch=false data-loop=true data-nav=false>
      {foreach from=$items item=thumbnail}
        <a href="{$thumbnail['derivative']->get_url()}" data-full="{$thumbnail['derivative_big']->get_url()}"></a>
      {/foreach}
      </div>
	</div>
	</div>
<div>
