{combine_css path="plugins/Fotorama/fotorama/fotorama.css"}
{combine_script id='fotorama' require='jquery' load='header' path='plugins/Fotorama/fotorama/fotorama.js'}

{if $Fotorama.close_button}
{combine_css path="plugins/Fotorama/template/close_button.css"}
{/if}

<div class="fotorama" data-startindex="{$current_rank}" data-ratio="16/9" data-auto="false"
  data-width="100%" data-maxheight="100%" data-minheight="200" data-height="{$item_height}"
  data-shadows="{if $Fotorama.shadows}true{else}false{/if}" data-nav="{$Fotorama.nav}" data-fit="{$Fotorama.fit}"
  data-allowfullscreen="{$Fotorama.allowfullscreen}" data-autoplay="{if $Fotorama.autoplay}true{else}false{/if}"
  data-transition="{$Fotorama.transition}" data-stopautoplayontouch="{if $Fotorama.stopautoplayontouch}true{else}false{/if}"
  data-loop="{if $Fotorama.loop}true{else}false{/if}" data-captions="false" data-thumbheight="{$Fotorama.thumbheight}"
  data-thumbwidth="{$Fotorama.thumbheight}"{if $Fotorama.clicktransition_crossfade} data-clicktransition="crossfade"{/if}
  data-keyboard="true">
{foreach from=$items item=thumbnail}
  <a href="{$thumbnail.derivative->get_url()}"
    data-full="{$thumbnail.derivative_big->get_url()}" data-url="{$thumbnail.url}" data-caption="{$thumbnail.TITLE}"
    {if $Fotorama.nav == 'thumbs' || $Fotorama.fullscreen_nav == 'thumbs'}data-thumb="{$thumbnail.derivative_thumb->get_url()}"{/if}>
  </a>
{/foreach}
</div>

{if isset($U_SLIDESHOW_STOP)}
<a href="{$U_SLIDESHOW_STOP}" class="fotorama__close-icon"></a>
{/if}

{footer_script require='jquery'}
  var fullscreen = false;
  jQuery().ready(function() {
    jQuery('.fotorama')
        // Listen to the events
        .on('fotorama:showend ',
            function (e, fotorama, extra) {
              if (!fullscreen) {
                {if isset($replace_picture)}
                history.replaceState(null, null, fotorama.activeFrame['url']);
                {else}
                history.replaceState(null, null, fotorama.activeFrame['url']+'&slideshow=');
                jQuery('#slideshow .browsePath a').attr('href', fotorama.activeFrame['url']);
                {/if}

                jQuery('#slideshow .showtitle').text(fotorama.activeFrame['caption']);
                jQuery('#slideshow .imageNumber').text((fotorama.activeFrame['i'])+'/{count($items)}');
                document.title = fotorama.activeFrame['caption'] + ' | {$GALLERY_TITLE|escape:javascript}';
              }
            }
        )
        .on('fotorama:fullscreenenter',
            function (e, fotorama, extra) {
              fotorama.setOptions({
                nav: "{$Fotorama.fullscreen_nav}",
                {if $Fotorama.enable_caption}
                captions: "true",
                {/if}
              });
              fotorama.startAutoplay();

              if (jQuery('.fotorama').attr('data-allowfullscreen') == 'native')
                fullscreen = true;
            }
        )
        .on('fotorama:fullscreenexit',
            function (e, fotorama, extra) {
              {if $Fotorama.only_fullscreen}
              {if isset($replace_picture)}
              window.location.replace('{$U_SLIDESHOW_STOP}');
              {else}
              window.location.replace(fotorama.activeFrame['url']);
              {/if}
              {else}

              fotorama.setOptions({
                nav: "{$Fotorama.nav}",
                {if $Fotorama.enable_caption}
                captions: "false",
                {/if}
              });

              {if isset($replace_picture)}
              history.replaceState(null, null, fotorama.activeFrame['url']);
              {else}
              history.replaceState(null, null, fotorama.activeFrame['url']+'&slideshow=');
              jQuery('#slideshow .browsePath a').attr('href', fotorama.activeFrame['url']);
              {/if}

              jQuery('#slideshow .showtitle').text(fotorama.activeFrame['caption']);
              jQuery('#slideshow .imageNumber').text((fotorama.activeFrame['i'])+'/{count($items)}');
              document.title = fotorama.activeFrame['caption'] + ' | {$GALLERY_TITLE|escape:javascript}';

              fullscreen = false;
              {/if}
            }
        )
        // Initialize fotorama manually
        .fotorama();

    {if $Fotorama.only_fullscreen}
    jQuery('.fotorama').data('fotorama').requestFullScreen();
    {else}
      {if $Fotorama.resize}
      jQuery('.fotorama').data('fotorama').resize({
        height: jQuery(window).height()
      });
      jQuery('html,body').animate({ scrollTop: jQuery('.fotorama').offset().top }, 'slow');
      {/if}
    {/if}
  
  });

  {if $Fotorama.close_button}
  jQuery('.fotorama').on('fotorama:ready', function (e, fotorama) {
    jQuery('.fotorama__close-icon').detach().insertAfter('.fotorama__fullscreen-icon');
  });
  {/if}
{/footer_script}
