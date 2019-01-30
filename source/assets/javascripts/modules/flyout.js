// Flyout module: queries an element by data attribute and toggles a class on it
// Params:
// attribute: (string, required) the name of the data attribute of the trigger element (e.g. a button with 'data-js-toggle')
// toggleAttribute: (string, optional) the 'active' class name for both the trigger and the target element
export default function flyout (attribute, toggleAttribute = 'is-active') {
  const triggers = document.querySelectorAll(`[${attribute}]`)

  triggers.forEach(trigger => {
    const targetName = trigger.getAttribute(attribute)
    const target = document.getElementById(targetName)

    if (!target) {
      return
    }

    trigger.addEventListener('click', event => {
      trigger.classList.toggle(toggleAttribute)
      target.classList.toggle(toggleAttribute)
    })

    // detect clicks outside the target element and reset both
    // -> be sure to set all children of the tigger el to `pointer-events: none` to keep Safari from getting event.target events from them
    document.addEventListener('click', event => {
      console.log(event.target)
      if (event.target !== trigger && target.classList.contains(toggleAttribute)) {
        trigger.classList.remove(toggleAttribute)
        target.classList.remove(toggleAttribute)
      }
    })
  })
}
