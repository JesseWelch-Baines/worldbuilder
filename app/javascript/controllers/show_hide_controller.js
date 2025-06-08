import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "subject"]

  connect() {
    this.triggerTarget.addEventListener("click", () => {
      this.toggleVisibility()
    })
  }

  toggleVisibility() {
    if (this.subjectTarget.hidden) {
      this.subjectTarget.hidden = false
    } else {
      this.subjectTarget.hidden = true
    }
  }

}
