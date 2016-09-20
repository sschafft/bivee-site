// import $ from 'jquery';
import Clipboard from 'clipboard';

// Copy-to-clipboard script
// -----------------------------------------------------------------------------
const emailButton = document.getElementById('email_to_clipboard');
const clipboard = new Clipboard(emailButton);

clipboard.on('success', e => {
    console.info('Action:', e.action);
    console.info('Text:', e.text);
    console.info('Trigger:', e.trigger);

    e.clearSelection();
});

clipboard.on('error', e => {
    console.error('Action:', e.action);
    console.error('Trigger:', e.trigger);
});
