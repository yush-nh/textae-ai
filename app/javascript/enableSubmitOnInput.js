const enableSubmitOnInput = () => {
  const textInput = document.querySelector(".text-input")
  const promptInput = document.querySelector(".prompt-input")
  const submitButton = document.querySelector(".submit-button")

  if (!textInput || !promptInput || !submitButton) return

  const toggleSubmitButton = () => {
    if (textInput.value.trim() && promptInput.value.trim()) {
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
