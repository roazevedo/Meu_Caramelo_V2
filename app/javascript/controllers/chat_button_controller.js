import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat-button"
export default class extends Controller {
  static targets = ["button"]

  focus() {
    this.buttonTarget.classList.add("chat-focus");
  }

  blur() {
    this.buttonTarget.classList.remove("chat-focus");
  }
}
