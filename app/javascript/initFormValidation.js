const initFormValidation = () => {
  const form = document.querySelector(".ai-annotation-form")
  if (!form) return

  const { text, prompt, commit } = form.elements
  const enableSubmitButton = () => commit.disabled = !form.checkValidity()

  if (text) {
    form.elements.text.addEventListener("input", enableSubmitButton)
  }

  if (prompt) {
    prompt.addEventListener("input", enableSubmitButton)
  }
}

document.addEventListener("turbo:load", initFormValidation)
document.addEventListener("turbo:render", initFormValidation)
