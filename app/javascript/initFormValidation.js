document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector(".ai-annotation-form")
  if (!form) return

  const { text, prompt, commit } = form.elements
  const enableSubmitButton = () => commit.disabled = !form.checkValidity()

  if (text) {
    text.addEventListener("input", enableSubmitButton)
  }

  if (prompt) {
    prompt.addEventListener("input", enableSubmitButton)
  }
})
