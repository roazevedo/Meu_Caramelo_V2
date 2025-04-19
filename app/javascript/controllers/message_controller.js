import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    sender: String
  }

  connect() {
    const currentUser = document.body.dataset.currentUser
    if (!currentUser) return

    if (this.senderValue === currentUser) {
      this.element.classList.add("sent")
      this.element.classList.remove("received")
    } else {
      this.element.classList.add("received")
      this.element.classList.remove("sent")
    }
  }
}
