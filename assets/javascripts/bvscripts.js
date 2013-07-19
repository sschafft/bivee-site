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



$(window).scroll(function(){

	var scroll = $(window).scrollTop();
	var width = $(window).width();
	var height = $(window).height();

	if (width > 768 && scroll > 200) {
		$("nav#main").css({
		  "padding-top": "10px", 
		  "padding-bottom": "10px",
		  "background": "rgba(255,255,255,0.9)"
		});
	} else if (width > 768 && scroll < 200) {
		$("nav#main").css({
		  "padding-top": "30px", 
		  "padding-bottom": "30px",
		  "background": "rgba(255,255,255,1)"
		});
	} else if (width > 768 && scroll > 200) {
		$("nav#main").css({
  		"padding-top": "10px", 
		  "padding-bottom": "10px",
		  "background": "rgba(255,255,255,0.9)"
		});
	}
});