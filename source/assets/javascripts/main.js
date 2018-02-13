import $ from 'jquery';
import Clipboard from 'clipboard';


// Copy-to-clipboard script
// -----------------------------------------------------------------------------
if($('#email_to_clipboard').length > 0) {
    const clipboard = new Clipboard(document.getElementById('email_to_clipboard'));

    clipboard.on('success', e => {
        console.info('Action:', e.action);
        console.info('Text:', e.text);
        console.info('Trigger:', e.trigger.getAttribute('id'));

        showClipboardMessage($(`#${e.trigger.getAttribute('id')}`), 'Copied to clipboard!');

        e.clearSelection();
    });

    clipboard.on('error', e => {
        console.error('Action:', e.action);
        console.error('Trigger:', e.trigger);

        showClipboardMessage($(`#${e.trigger.getAttribute('id')}`), 'Press CMD/CTRL + C to copy.');

        e.clearSelection();
    });

    function showClipboardMessage($el, message) {
        const activeClass = 'is-active'; // the class to show the tooltip
        const oldMessage = $el.attr('title'); // grab a reference to the title attr

        $el.attr('title', message).addClass(activeClass);

        // keep the tooltip up for a few seconds, then hide it
        setTimeout(_ => {
            $el.removeClass(activeClass);

            // reset the title attr back to it's original message
            setTimeout(_ => {
                $el.attr('title', oldMessage);
            }, 1000);
        }, 2000);
    }
}


// Netlify Identity
// -----------------------------------------------------------------------------
if (window.netlifyIdentity) {
  window.netlifyIdentity.on("init", user => {
    if (!user) {
      window.netlifyIdentity.on("login", () => {
        document.location.href = "/admin/";
      });
    }
  });
}
