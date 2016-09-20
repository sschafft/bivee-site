// import $ from 'jquery';
import Clipboard from 'clipboard';

const emailButton = document.getElementById('email_to_clipboard');
const clipboard = new Clipboard(emailButton);

clipboard.on('success', function(e) {
    console.info('Action:', e.action);
    console.info('Text:', e.text);
    console.info('Trigger:', e.trigger);

    e.clearSelection();
});

clipboard.on('error', function(e) {
    console.error('Action:', e.action);
    console.error('Trigger:', e.trigger);
});

sayhi@bivee.co
