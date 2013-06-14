var bvform = new BVForm( document.getElementById( 'bv-form' ) );

$('#bv-form').submit(function() {
    $.ajax({
        data: $(this).serialize(), // get the form data
        success: function(response) { // on success..
            $('#created').html(response);
            $('#bv-form').fadeOut(300);
            $('.bv-result').delay(300).fadeIn(700);
        }
    });
    return false; // cancel original event to prevent form submitting
});