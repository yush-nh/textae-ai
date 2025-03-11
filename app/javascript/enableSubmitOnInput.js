const enableSubmitOnInput = () => {
  const form = document.querySelector(".ai-annotation-form")
  if (!form) return

  const { text, prompt, commit } = form.elements
  const enableSubmitButton = () => commit.disabled = !form.checkValidity()

  text.addEventListener("input", () => enableSubmitButton())
  prompt.addEventListener("input", () => enableSubmitButton())
}

document.addEventListener("turbo:load", () => enableSubmitOnInput())
document.addEventListener("turbo:render", () => enableSubmitOnInput())
