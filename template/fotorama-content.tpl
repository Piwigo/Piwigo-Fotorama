{combine_css path="plugins/Fotorama/fotorama/fotorama.css"}
{combine_script id='fotorama' require='jquery' load='header' path='plugins/Fotorama/fotorama/fotorama.js'}

{if $Fotorama.close_button}
{combine_css path="plugins/Fotorama/template/close_button.css"}
{/if}
{if $Fotorama.info_button}
{combine_css path="plugins/Fotorama/template/info_button.css"}
{/if}

<div class="fotorama" data-startindex="{$current_rank}" data-ratio="16/9"
  data-width="100%" data-maxheight="100%" data-minheight="200" data-height="{$item_height}"
  data-shadows="{if $Fotorama.shadows}true{else}false{/if}" data-nav="{$Fotorama.nav}" data-fit="{$Fotorama.fit}"
  data-allowfullscreen="{$Fotorama.allowfullscreen}" data-autoplay="{if $Fotorama.autoplay}{$Fotorama.period}{else}false{/if}"
  data-transition="{$Fotorama.transition}" data-stopautoplayontouch="{if $Fotorama.stopautoplayontouch}true{else}false{/if}"
  data-loop="{if $Fotorama.loop}true{else}false{/if}" data-captions:"{if $Fotorama.enable_caption}true{else}false{/if}" data-thumbheight="{$Fotorama.thumbheight}"
  data-thumbwidth="{$Fotorama.thumbheight}"{if $Fotorama.clicktransition_crossfade} data-clicktransition="crossfade"{/if}
  data-keyboard="true"
  data-click="false">

{foreach from=$items item=thumbnail}
  <div 
data-caption="{if $Fotorama.enable_caption_with == 'comment' }{$thumbnail.DESCRIPTION|escape:html}{else}{$thumbnail.TITLE|escape:html}{/if}"
data-url="{$thumbnail.url}"
data-id="{$thumbnail.id}"
{if $Fotorama_has_thumbs}
data-thumb="{$thumbnail.derivative_thumb->get_url()}"
{assign var=thumb_size value=$thumbnail.derivative_thumb->get_size()}
data-thumbratio="{$thumb_size[0]/$thumb_size[1]}"
{/if}
{if !empty($thumbnail.video) and !empty($thumbnail.video_type)}
data-isvideo="true">
        <video poster="{str_replace('&amp;', '&', $thumbnail.derivative->get_url())}"
                id="my_video_{$thumbnail.id}" controls preload="auto" width="100%" height="{$item_height}">
                <source src="{$thumbnail.video}" type='{$thumbnail.video_type}'>
        </video>
{else}
data-img="{str_replace('&amp;', '&', $thumbnail.derivative->get_url())}"
data-full="{str_replace('&amp;', '&', $thumbnail.derivative_big->get_url())}">
{/if}
</div>
{/foreach}

</div>

{if isset($U_SLIDESHOW_STOP)}
<a href="{$U_SLIDESHOW_STOP}" class="fotorama__close-icon"></a>
{/if}
<a class="fotorama__info-icon"></a>

{footer_script require='jquery'}
  window.blockFotoramaData = true;

  function update_picture(fotorama) {
    {if isset($replace_picture)}
    if (history.replaceState)
      history.replaceState(null, null, fotorama.activeFrame['url']);
    {else}
    if (history.replaceState)
      history.replaceState(null, null, fotorama.activeFrame['url']+(fotorama.activeFrame['url'].indexOf('?')==-1 ? '?' : '&')+'slideshow=');
    jQuery('#slideshow .browsePath a,a.fotorama__close-icon').attr('href', fotorama.activeFrame['url']);
    {/if}

    if (fotorama.activeFrame['isvideo']) {
        var player;
        player = document.getElementById("my_video_"+fotorama.activeFrame['id']);
        if (player.networkState == 3) {
            // Next on error
            fotorama.show('>');
        }
        if (!isNaN(player.duration)) {
            var runtime;
            runtime = Math.round(player.duration*1000); // in millsecond
            {if $Fotorama.autoplay}
            //fotorama.setOptions({literal}{autoplay:runtime}{/literal}); // update fotorama options
            {/if}
        }
        // Stop fotorama
        fotorama.stopAutoplay();
        // Rewind the begining
        player.currentTime = 0;
        player.seeking = false;
        // Start video
        {if $Fotorama.autoplay}
        player.play();
        {/if}
        //player.autoplay=true;
        // Set video player events
        player.onended = function(e) {
            {if $Fotorama.autoplay}
            // Next on end
            fotorama.show('>');
            {/if}
        }
        player.onerror = function(e) {
            // Next on error
            fotorama.show('>');
        }
        player.onplay = function(e) {
            fotorama.stopAutoplay();
        }
    } else {
	// Revert the settings if image
	fotorama.setOptions({literal}{autoplay:{/literal}{if $Fotorama.autoplay}{$Fotorama.period}{else}false{/if}{literal}}{/literal});
    }

    jQuery('a.fotorama__info-icon').attr('href', fotorama.activeFrame['url']+(fotorama.activeFrame['url'].indexOf('?')==-1 ? '?' : '&')+'slidestop=');

    jQuery('#slideshow .showtitle').text(fotorama.activeFrame['caption']);
		var idx = fotorama.activeIndex;
{if isset($view_offset)}
		if (idx >= {$view_offset.from})
			idx += {$view_offset.offset};
{/if}
    jQuery('#slideshow .imageNumber').text((idx+1)+'/{$TOTAL_ITEMS}');
    document.title = fotorama.activeFrame['caption'] + ' | {$GALLERY_TITLE|escape:javascript}';

    jQuery.ajax({
      type: "POST",
      url: 'ws.php?format=json&method=fotorama.images.logHistory',
      data: {
        image_id:fotorama.activeFrame['id'],
        {if !empty($fotorama_log_history.cat_id)}cat_id:{$fotorama_log_history.cat_id},{/if}
        {if !empty($fotorama_log_history.section)}section:"{$fotorama_log_history.section}",{/if}
        {if !empty($fotorama_log_history.tags_string)}tags_string:"{$fotorama_log_history.tags_string}",{/if}
      }
    });
  }

  var fullscreen = false;
  jQuery().ready(function() {
    jQuery('.fotorama')
        // Listen to the events
        .on('fotorama:showend',
            function (e, fotorama, extra) {
                update_picture(fotorama);
							{if !empty($view_borders)}
{if $view_borders[0] < $view_borders[1]}
								if (fotorama.activeIndex <= {$view_borders[0]}{if $Fotorama_has_thumbs}+5{/if} ||
									fotorama.activeIndex >= {$view_borders[1]}{if $Fotorama_has_thumbs}-5{/if} )
{else}
								if (fotorama.activeIndex <= {$view_borders[0]}{if $Fotorama_has_thumbs}+5{/if} &&
									fotorama.activeIndex >= {$view_borders[1]}{if $Fotorama_has_thumbs}-5{/if} )
{/if}
								{
									fotorama.stopAutoplay();
									var url = fotorama.activeFrame.url + (fotorama.activeFrame.url.indexOf('?')==-1 ? '?' : '&')+'slideshow=';
{if !$Fotorama.only_fullscreen}
									if (fullscreen) url += "&fullscreen";
{/if}
									window.location = url;
								}
							{/if}
            }
        )
        .on('fotorama:fullscreenenter',
            function (e, fotorama, extra) {
              fotorama.setOptions({
                nav: "{$Fotorama.fullscreen_nav}",
              });
              {if $Fotorama.autoplay}
              fotorama.startAutoplay();
              {/if}

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
              });

              update_picture(fotorama);

              fullscreen = false;
              {/if}
            }
        )
        // Initialize fotorama manually
        .fotorama({
          data: [
{foreach from=$items item=thumbnail}
{
image_id:{$thumbnail.id},
caption: "{if $Fotorama.enable_caption_with == 'comment' }{$thumbnail.DESCRIPTION|escape:javascript}{else}{$thumbnail.TITLE|escape:javascript}{/if}",
full: "{str_replace('&amp;', '&', $thumbnail.derivative_big->get_url())}",
img: "{str_replace('&amp;', '&', $thumbnail.derivative->get_url())}",
{if $Fotorama_has_thumbs}
thumb: "{$thumbnail.derivative_thumb->get_url()}",
{assign var=thumb_size value=$thumbnail.derivative_thumb->get_size()}
thumbratio: {$thumb_size[0]/$thumb_size[1]},
{/if}
url: "{$thumbnail.url}"
{if !empty($thumbnail.video)}
,video:"{$thumbnail.video}"{if !empty($thumbnail.video_id)},id:"{$thumbnail.video_id}"{/if}
{/if}
},{/foreach}
          ]
        });

    {if $Fotorama.only_fullscreen}
    jQuery('.fotorama').data('fotorama').requestFullScreen();
    {else}
      {if $Fotorama.resize}
      jQuery('.fotorama').data('fotorama').resize({
        height: jQuery(window).height()
      });
      jQuery('html,body').animate({ scrollTop: jQuery('.fotorama').offset().top }, 'slow');
      {/if}
			{if isset($smarty.get.fullscreen)}
			jQuery('.fotorama').data('fotorama').requestFullScreen();
			{/if}
    {/if}
  
  });

  {if $Fotorama.close_button}
  jQuery('.fotorama').on('fotorama:ready', function (e, fotorama) {
    jQuery('.fotorama__close-icon').detach().insertAfter('.fotorama__fullscreen-icon');
  });
  {/if}
  {if $Fotorama.info_button}
  jQuery('.fotorama').on('fotorama:ready', function (e, fotorama) {
    jQuery('.fotorama__info-icon').detach().insertAfter('.fotorama__fullscreen-icon');
  });
  {/if}
{/footer_script}
