document.addEventListener("DOMContentLoaded", () => {
  document.querySelector('#ai-textae-editor').classList.add('textae-editor')
  const editor = window.initializeTextAEEditor()
    .find((editor) => editor.id === 'ai-textae-editor')

  editor.inspectCallback = (annotation) => {
    document.querySelector('#textae-annotation').value = JSON.stringify(annotation)
  }
})
