// import $ from 'jquery';
import clipboard from 'clipboard';

clipboard = new Clipboard('#email_to_clipboard');

clipboard.on('success', e => {
    console.info('Action:', e.action);
    console.info('Text:', e.text);
    console.info('Trigger:', e.trigger);

    e.clearSelection();
});
