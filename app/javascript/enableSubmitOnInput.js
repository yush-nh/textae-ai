const enableSubmitOnInput = () => {
  const form = document.querySelector(".ai-annotation-form")
  if (!form) return

  const textInput = document.querySelector(".text-input")
  const promptInput = document.querySelector(".prompt-input")
  const submitButton = document.querySelector(".submit-button")

  const toggleSubmitButton = () => {
    if (form.checkValidity()) {
      submitButton.disabled = false
    } else {
      submitButton.disabled = true
    }
  }

  textInput.addEventListener("input", () => toggleSubmitButton())
  promptInput.addEventListener("input", () => toggleSubmitButton())
}

document.addEventListener("turbo:load", () => enableSubmitOnInput())
document.addEventListener("turbo:render", () => enableSubmitOnInput())
