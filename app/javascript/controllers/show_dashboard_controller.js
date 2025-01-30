import { Controller } from "@hotwired/stimulus"


export default class extends Controller {

    static targets = ["animalElement", "adoptionElement", "profileElement"]

    connect() {
        console.log("hello from stimulus controller")
    }

    profile() {
        this.adoptionElementTarget.classList.add("d-none")
        this.animalElementTarget.classList.add("d-none")
        this.profileElementTarget.classList.remove("d-none")
    }

    animals() {
        this.adoptionElementTarget.classList.add("d-none")
        this.profileElementTarget.classList.add("d-none")
        this.animalElementTarget.classList.remove("d-none")
        console.log("hello from animals")
    }

    adoptions() {
        this.animalElementTarget.classList.add("d-none")
        this.profileElementTarget.classList.add("d-none")
        this.adoptionElementTarget.classList.remove("d-none")
        console.log("hello from adoptions")
    }

}
