/*
 * Replace all SVG images with inline SVG
*/
  jQuery('img.svg').each(function(){
    var $img = jQuery(this);
    var imgID = $img.attr('id');
    var imgClass = $img.attr('class');
    var imgURL = $img.attr('src');
    
    jQuery.get(imgURL, function(data) {
      // Get the SVG tag, ignore the rest
      var $svg = jQuery(data).find('svg');
    
      // Add replaced image's ID to the new SVG
      if(typeof imgID !== 'undefined') {
        $svg = $svg.attr('id', imgID);
      }
      // Add replaced image's classes to the new SVG
      if(typeof imgClass !== 'undefined') {
        $svg = $svg.attr('class', imgClass+' replaced-svg');
      }
      
      // Remove any invalid XML tags as per http://validator.w3.org
      $svg = $svg.removeAttr('xmlns:a');
      
      // Replace image with new SVG
      $img.replaceWith($svg);
    });
  });

/*
 * Replace all SVG images with inline SVG
*/
  $(window).scroll(function(){
    var windowScroll = $(window).scrollTop();
    
    if ($(window).width() > 768 && windowScroll > ($(window).height() - 100)) {
      $("nav#primary").fadeIn(500);
    } else if ($(window).width() > 768 && windowScroll < ($(window).height() - 100)) {
      $("nav#primary").fadeOut(500);
    } else {
      $("nav#primary").fadeIn(500);
    }
  });

/*
 * Slidetoggle to show mobile menu
 */
  $('#showmenu').click(function() {
    $('ul#menu').slideToggle('fast', function() {
    });
  });