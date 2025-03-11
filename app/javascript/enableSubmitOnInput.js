const enableSubmitOnInput = () => {
  const form = document.querySelector(".ai-annotation-form")
  if (!form) return

  const { text, prompt, commit } = form.elements

  const toggleSubmitButton = () => {
    if (form.checkValidity()) {
      commit.disabled = false
    } else {
      commit.disabled = true
    }
  }

  text.addEventListener("input", () => toggleSubmitButton())
  prompt.addEventListener("input", () => toggleSubmitButton())
}

document.addEventListener("turbo:load", () => enableSubmitOnInput())
document.addEventListener("turbo:render", () => enableSubmitOnInput())
