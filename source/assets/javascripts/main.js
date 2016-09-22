import $ from 'jquery';
import Clipboard from 'clipboard';

// Copy-to-clipboard script
// -----------------------------------------------------------------------------
const clipboard = new Clipboard(document.getElementById('email_to_clipboard'));

clipboard.on('success', e => {
    // console.info('Action:', e.action);
    // console.info('Text:', e.text);
    // console.info('Trigger:', e.trigger.getAttribute('id'));

    showClipboardMessage($(`#${e.trigger.getAttribute('id')}`), 'Copied to clipboard!');

    e.clearSelection();
});

clipboard.on('error', e => {
    // console.error('Action:', e.action);
    // console.error('Trigger:', e.trigger);

    showClipboardMessage($(`#${e.trigger.getAttribute('id')}`), 'Press CMD/CTRL + C to copy.');

    e.clearSelection();
});

function showClipboardMessage($el, message) {
    const activeClass = 'is-active';
    const oldMessage = $el.attr('title');

    $el.attr('title', message).addClass(activeClass);

    setTimeout(_ => {
        $el.removeClass(activeClass);

        setTimeout(_ => {
            $el.attr('title', oldMessage);
        }, 1000);
    }, 3000);
}
