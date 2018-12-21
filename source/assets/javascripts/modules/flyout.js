export default function flyout (attribute, toggleAttribute = 'active') {
  const triggers = document.querySelectorAll(`[${attribute}]`)
  console.log(triggers)

  triggers.forEach(trigger => {
    const targetName = trigger.getAttribute(attribute)
    const target = document.getElementById(targetName)
    console.log(targetName)

    if (!target) {
      return
    }

    trigger.addEventListener('click', (event) => {
      event.target.classList.toggle(toggleAttribute)
      target.classList.toggle(toggleAttribute)
    })
  })
}
