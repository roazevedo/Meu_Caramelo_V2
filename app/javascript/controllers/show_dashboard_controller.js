import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["animalElement", "adoptionElement", "profileElement"]

  profile() {
    this.adoptionElementTarget.classList.add("d-none")
    this.animalElementTarget.classList.add("d-none")
    this.profileElementTarget.classList.remove("d-none")
  }

  animals() {
    this.adoptionElementTarget.classList.add("d-none")
    this.profileElementTarget.classList.add("d-none")
    this.animalElementTarget.classList.remove("d-none")
  }

  adoptions() {
    this.animalElementTarget.classList.add("d-none")
    this.profileElementTarget.classList.add("d-none")
    this.adoptionElementTarget.classList.remove("d-none")
  }
}
