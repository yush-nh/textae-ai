// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Initialize TextAE in turbo environments.
document.addEventListener("turbo:load", () => {
  if (document.querySelector('.textae-editor')) {
    window.initializeTextAEEditor()
  }
})
