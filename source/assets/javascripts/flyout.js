export default {
  flyout: trigger => {
    // need to  get data-js-open-toggle="[ID]"
    const targetName = trigger.getAttribute('href').replace('#', '')
    const target = document.getElementById(targetName)

    !target && return

    // need to toggle data-js-open attr
    trigger.classList.toggle('active')
    target.classList.toggle('active')
  }
}

// // Open things (usually dropdowns and menus) on click
// $('.js-open-toggle').removeAttr('href').unbind('click').click(function(event) {
//   // get the data-target attr for this element or the closest ancestor if we clicked a child
//   var targetID = $(event.target).closest('[data-target]').data('target');
//   $('#' + targetID).toggleClass('is-open');
//   event.preventDefault();
// });
