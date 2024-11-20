import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["field"]
  static values = { locale: String }

  submit (e) {
    e.preventDefault()
    window.location.assign(`/${this.localeValue}/${this.fieldTarget.value}`)
  }
}
