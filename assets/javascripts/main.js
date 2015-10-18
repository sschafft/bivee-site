$(document).ready(function( $ ){

    var width =  $(window).width();
    var height = $(window).height();

    if (width > 768 ) {
        $("#home nav").removeClass("fixed");
    }


    $(window).scroll(function(){

        var scroll = $(window).scrollTop();

        if (width > 768 && scroll > 200) {
            $("#home nav").addClass("fixed").slideDown(400);
        } else if (width > 768 && scroll < height) {
            $("#home nav").removeClass("fixed");
        } else if (width > 768 && scroll > height) {
            $("#home nav").addClass("fixed").slideDown(400);
        }
    });
    $('li#show-menu').click(function(){
        $('ul#menu').slideToggle( function() {
            $('li#show-menu').toggleClass('active');
        });
        return false;
    });
});


$(document).ready(function( $ ){
    
    $.localScroll.defaults.axis = 'y';

    $.localScroll({
        target: 'body',
        queue: true,
        duration:1000,
        hash:false,
        onBefore:function( e, anchor, $target ){
            // The 'this' is the settings object, can be modified
        },
        onAfter:function( anchor, settings ){
            // The 'this' contains the scrolled element (#content)
        }
    });

    $.localScroll.hash({
        target: 'body',
        queue:true,
        duration:1500,
    });


    $('#contact-form').submit(function(){

        var email = $('input[name="email"]').val();
        var name = $('input[name="name"]').val();
        var message = $('textarea[name="message"]').val();
        
        //Validation
        name ? $('.name-error').hide(): $('.name-error').show();
        email ? $('.email-error').hide(): $('.email-error').show();
        message ? $('.message-error').hide(): $('.message-error').show();

        if(!message || !name || !email){ return false; }

        //Submit
        $.ajax({
          dataType: 'jsonp',
          url: "http://getsimpleform.com/messages/ajax?form_api_token=4f0d1f7bdd7d6fdc63bc17e5c36e9359",
          data: $('#contact-form').serialize()
        }).done(function() {
        //Hide On Success
          $("#send-form h3").fadeOut(1000);
          $("#contact-form").fadeOut(1000);
          $("#send-form").append("<div class='success'><h3><strong>Thank you</strong> for getting in touch!</h3><p>We'll follow up with you shortly.</h3></div>")
        });

        return false;
    });

});






