// app/javascript/controllers/tab_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "adopter", "preferencias" ]

  connect() {
    this.checkAdopter()
  }

  checkAdopter() {
    if(this.adopterTarget.checked) {
      this.preferenciasTarget.style.display = "block"
    } else {
      this.preferenciasTarget.style.display = "none"
    }
  }
}
