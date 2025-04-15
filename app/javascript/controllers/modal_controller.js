import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    this.modal = new bootstrap.Modal(this.element, {
      keyboard: false
    });

    // Verifica se o modal deve ser exibido
    // if (this.shouldShowModal()) {
    //   this.element.removeAttribute("inert");
    this.modal.show();
    // }

    // Adiciona evento para salvar o estado quando o modal é fechado
    // this.element.addEventListener('hidden.bs.modal', () => this.saveModalState(false));
  }

  disconnect() {
    this.modal.hide(); // Esconde o modal
    // this.element.setAttribute("inert", "");
    // this.element.removeAttribute("aria-hidden"); // Garante que o atributo seja removido

    // // Move o foco para o botão que abriu o modal
    // const triggerButton = document.querySelector(`[data-bs-target="#${this.element.id}"]`);
    // if (triggerButton) triggerButton.focus();
  }

  // shouldShowModal() {
  //   // Verifica se o modal deve ser exibido
  //   return sessionStorage.getItem('showModal') === 'true';
  // }

  // saveModalState(isOpen) {
  //   // Salva o estado do modal no sessionStorage
  //   sessionStorage.setItem('showModal', isOpen ? 'true' : 'false');
  // }
}
