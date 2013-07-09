/*
 * Misc jqueries - Slidetoggle to show mobile menu
 */
  $('#showmenu').click(function() {
    $('ul#menu').slideToggle('fast', function() {
    });
  });
/*
 * Misc jqueries - Pin nav
 */
  $("div#main").pin({
      containerSelector: ".content",
      minWidth: 768
  });