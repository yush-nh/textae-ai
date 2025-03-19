document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector(".ai-annotation-form")
  if (!form) return

  const { ai_annotation_text, ai_annotation_prompt, commit } = form.elements
  const enableSubmitButton = () => commit.disabled = !form.checkValidity()

  if (ai_annotation_text) {
    ai_annotation_text.addEventListener("input", enableSubmitButton)
  }

  if (ai_annotation_prompt) {
    ai_annotation_prompt.addEventListener("input", enableSubmitButton)
  }

  // Run form check once at loading to handle situations
  // where values are assigned from the time of loading, such as in the case of validation errors.
  enableSubmitButton()
})
