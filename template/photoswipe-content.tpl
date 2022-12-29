<link rel="stylesheet" href="plugins/Fotorama/node_modules/photoswipe/dist/photoswipe.css">
{* FIXME: using combine_css gives a different rendering than <link ...>
   (zoom and close buttons are hidden), but combine_css would be better.
{combine_css path="plugins/Fotorama/node_modules/photoswipe/dist/photoswipe.css"} *}
{combine_css path="plugins/Fotorama/template/photoswipe_style.css"}

<script type="module">
{* FIXME: using combine_script does not work, I guess because combine_script
   doesn't support ES modules. Using JS's import instead, but it would be more
   efficient to find a way to use combine_script. *}
import PhotoSwipe from './plugins/Fotorama/node_modules/photoswipe/dist/photoswipe.esm.min.js';

const options = {
  dataSource: [
    {foreach from=$items item=thumbnail}
      {assign var=thumb_size value=$thumbnail.derivative->get_size()}
      {
      src: '{str_replace('&amp;', '&', $thumbnail.derivative->get_url())}',
      width: {$thumb_size[0]},
      height: {$thumb_size[1]},
      alt: 'Image',
      url: "{$thumbnail.url}",
      },
    {/foreach}
  ],
  index: {$current_rank},
  showHideAnimationType: 'none',
};

window.onload = () => {
  const pswp = new PhotoSwipe(options);
  pswp.on('close', () => {
    // The PhotoSwipe slideshow uses its own HTML page. When closing
    // PhotoSwipe, we shouldn't show that page (which isn't really an
    // interesting one :-(), but return to the page we came from.
    location.replace("{$U_SLIDESHOW_STOP}");
  });

  pswp.on('uiRegister', function() {
    {if $Fotorama.photoswipe_info_button}
    // Add the 'info' button that adds &slidestop= to the current URL, to
    // stop the slideshow and show the image's details page.
    pswp.ui.registerElement({
      name: 'info',
      ariaLabel: 'Info',
      order: 9,
      isButton: true,
      onClick: () => {
        const url = pswp.currSlide.data.url;
        const stopURL = url + (url.indexOf('?')==-1 ? '?' : '&') + 'slidestop=';
        location.replace(stopURL);
      }
    });
    {/if}

    {if $Fotorama.photoswipe_allowfullscreen}
    // No native support for full screen in PhotoSwipe, and it's simple enough
    // to add it ourselves to avoid an extra dependency such as
    // https://github.com/arnowelzel/photoswipe-fullscreen
    pswp.ui.registerElement({
      name: 'fullscreen',
      ariaLabel: 'Full Screen',
      order: 8,
      isButton: true,
      onClick: (event, el) => {
        if (!document.fullscreenElement) {
          document.documentElement.requestFullscreen();
          el.style.setProperty('background-image', 'url(plugins/Fotorama/template/contract.svg)', 'important');
        } else {
          document.exitFullscreen();
          el.style.setProperty('background-image', 'url(plugins/Fotorama/template/expand.svg)', 'important');
        }
      }
    });
    {/if}
  });

  // Update the URL when the image changes
  pswp.on('change', () => {
    const url = pswp.currSlide.data.url;
    {if isset($replace_picture)}
      if (history.replaceState)
        history.replaceState(null, null, url);
    {else}
      if (history.replaceState)
        history.replaceState(null, null, url+(url.indexOf('?')==-1 ?
          '?' : '&')+'slideshow=');
    {/if}
  });

  // initializing PhotoSwipe core adds it to DOM
  pswp.init();
};
</script>

</div>
