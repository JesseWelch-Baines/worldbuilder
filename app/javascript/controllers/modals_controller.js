import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "submitButton", "closeButton"]

  connect() {
    this.submitButtonTarget.addEventListener("click", this.submit.bind(this))
    this.closeButtonTarget.addEventListener("click", this.close.bind(this))
  }

  submit(event) {
    event.preventDefault()
    const form = this.modalTarget.querySelector("form")
    if (form) {
      form.requestSubmit()
    }
    this.modalTarget.remove()
  }

  close(event) {
    event.preventDefault()
    this.modalTarget.remove()
  }
}
