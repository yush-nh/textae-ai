document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector(".ai-annotation-form")
  if (!form) return

  const text = document.querySelector(".text-input")
  const prompt = document.querySelector(".prompt-input")
  const commit = form.elements.commit
  const enableSubmitButton = () => commit.disabled = !form.checkValidity()

  if (text) {
    text.addEventListener("input", enableSubmitButton)
  }

  if (prompt) {
    prompt.addEventListener("input", enableSubmitButton)
  }
})
