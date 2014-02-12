{combine_css path="plugins/Fotorama/fotorama/fotorama.css"}
{combine_script id='fotorama' require='jquery' load='header' path='plugins/Fotorama/fotorama/fotorama.js'}

{literal}
<script type="text/javascript">
var image_w = {/literal}{$item_height}{literal}
var image_h = {/literal}{$item_height}{literal}
</script>
{/literal}

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
      <div class="fotorama" data-startindex="{$current_rank}" data-ratio="16/9" data-auto="false"
        data-width="100%" data-maxheight="100%" data-minheight="200" data-height="{$item_height}"
        data-shadows="{$Fotorama['shadows']}" data-nav="{$Fotorama['nav']}" data-fit="{$Fotorama['fit']}"
        data-allowfullscreen="{$Fotorama['allowfullscreen']}" data-autoplay="{if $Fotorama['autoplay']}true{else}false{/if}"
        data-transition="{$Fotorama['transition']}" data-stopautoplayontouch="{$Fotorama['stopautoplayontouch']}"
        data-loop="{$Fotorama['stopautoplayontouch']}">
      {foreach from=$items item=thumbnail}
        <a href="{$thumbnail['derivative']->get_url()}"
          data-full="{$thumbnail['derivative_big']->get_url()}" data-url="{$thumbnail['url']}" data-title="{$thumbnail['TITLE']}">
          {if $Fotorama['nav'] == 'thumbs' || $Fotorama['fullscreen_nav'] == 'thumbs'}<img src="{$thumbnail['derivative_thumb']->get_url()}">{/if}
        </a>
      {/foreach}
      </div>
	</div>
  </div>
</div>

{footer_script require='jquery'}{literal}
  var fullscreen = false;
  jQuery().ready(function() { 
    jQuery('.fotorama')
        // Listen to the events
        .on('fotorama:showend ',
            function (e, fotorama, extra) {
              if (!fullscreen) {
                history.replaceState(null, null, fotorama.activeFrame['url']+'&slideshow=');
                jQuery('#slideshow .browsePath a').attr('href', fotorama.activeFrame['url']);
                jQuery('#slideshow .showtitle').text(fotorama.activeFrame['title']);
                jQuery('#slideshow .imageNumber').text((fotorama.activeFrame['i'])+'/'+{/literal}{count($items)}{literal});
                document.title = fotorama.activeFrame['title'] + ' | {/literal}{$GALLERY_TITLE}{literal}';
              }
            }
        )
        .on('fotorama:fullscreenenter',
            function (e, fotorama, extra) {
              fotorama.setOptions({
                nav: "{/literal}{$Fotorama['fullscreen_nav']}{literal}"
              });
              fotorama.startAutoplay();

              if (jQuery('.fotorama').attr('data-allowfullscreen') == 'native')
                fullscreen = true;
            }
        )
        .on('fotorama:fullscreenexit',
            function (e, fotorama, extra) {
              fotorama.setOptions({
                nav: "{/literal}{$Fotorama['nav']}{literal}"
              });

              history.replaceState(null, null, fotorama.activeFrame['url']+'&slideshow=');
              jQuery('#slideshow .browsePath a').attr('href', fotorama.activeFrame['url']);
              jQuery('#slideshow .showtitle').text(fotorama.activeFrame['title']);
              jQuery('#slideshow .imageNumber').text((fotorama.activeFrame['i'])+'/'+{/literal}{count($items)}{literal});
              document.title = fotorama.activeFrame['title'] + ' | {/literal}{$GALLERY_TITLE}{literal}';

              fullscreen = false;
            }
        )
        // Initialize fotorama manually
        .fotorama();
  });
{/literal}{/footer_script}
