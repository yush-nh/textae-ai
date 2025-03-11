const initFormValidation = () => {
  const form = document.querySelector(".ai-annotation-form")
  if (!form) return

  const commit = form.elements.commit
  const enableSubmitButton = () => commit.disabled = !form.checkValidity()

  if (form.elements.text) {
    form.elements.text.addEventListener("input", enableSubmitButton)
  }

  if (form.elements.prompt) {
    form.elements.prompt.addEventListener("input", enableSubmitButton)
  }
}

document.addEventListener("turbo:load", initFormValidation)
document.addEventListener("turbo:render", initFormValidation)
