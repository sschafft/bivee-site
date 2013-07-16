/*
 * Misc jqueries - Slidetoggle to show mobile menu
 */
  $('#showmenu').click(function() {
    $('nav#main ul').slideToggle('fast', function() {
    });
  });

/*
 * Slider Function
 */
$(function() {
	var Page = (function() {
    var $navArrows = $('#nav-arrows'),
		$nav = $('#nav-dots > span'),
			slitslider = $('#slider').slitslider({
				onBeforeChange : function(slide, pos){
					$nav.removeClass( 'nav-dot-current');
					$nav.eq(pos).addClass('nav-dot-current');
				}
			}),
			init = function() {
				initEvents();
			},
			initEvents = function(){
          $navArrows.children(':last').on('click', function(){
					slitslider.next();
					return false;
				});
				$navArrows.children(':first').on('click', function() {
					slitslider.previous();
					return false;
				});
				$nav.each( function(i){
					$(this).on('click', function(event){
						var $dot = $(this);
						if(!slitslider.isActive()){
							$nav.removeClass('nav-dot-current');
							$dot.addClass('nav-dot-current');
						}
						slitslider.jump( i + 1 );
						return false;
					});
				});
			};
			return { init : init };
	})();
	Page.init();
});


/*
 * Header resize function
 */
$('nav#main').affix()

$(window).scroll(function(){
  var screenW = $(window).width();
  if(screenW > 768) {
    n = Math.ceil($("body").scrollTop() / 3);
    $("#banner").css("-webkit-transform", "translateY(-" + n + "px)");
  	$("#banner").css("-moz-transform", "translateY(-" + n + "px)");
  	m = Math.ceil($("body").scrollTop() / 5);
  	$("header").css("-webkit-transform", "translateY(" + n + "px)");
  	$("header").css("-moz-transform", "translateY(" + n + "px)");
  	o = Math.ceil($("body").scrollTop() / 3);
  	$("footer").css("-webkit-transform", "translateY(" + n + "px)");
  	$("footer").css("-moz-transform", "translateY(" + n + "px)");
  }
});

$(window).scroll(function(){
  var windowScroll = $(window).scrollTop();
    if($(window).width() > 768 && windowScroll > ($(window).height() - 50)){
    $("nav#main").animate({
      "padding-top": "20px",
      "padding-bottom": "20px"
    });
  } else if ($(window).width() > 768 && windowScroll < ($(window).height() - 50)) {
		$("nav#main").animate({
      "padding-top": "0px",
      "padding-bottom": "0px"
    });
	} else if($(window).width() > 768 && windowScroll > ($(window).height() - 50)){
		$("nav#main").css({
      "padding-top": "20px",
      "padding-bottom": "20px"
    });
	}
});

