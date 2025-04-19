import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {
    this.scrollToBottom()
  }

  scrollToBottom() {
    const chatroomId = this.element.dataset.chatroomId
    const container = document.getElementById(`messages_${this.element.dataset.chatroomId}`);
    if (container) {
      container.scrollTop = container.scrollHeight;
    }
  }
}

// Faz o scroll funcionar após mensagens Turbo serem renderizadas
document.addEventListener("turbo:before-stream-render", (event) => {
  const scrollContainer = document.querySelector('[data-controller="scroll"]')
  if (scrollContainer && scrollContainer.dataset.chatroomId) {
    const chatroomId = scrollContainer.dataset.chatroomId
    const container = document.getElementById(`messages_${chatroomId}`)
    if (container) {
      requestAnimationFrame(() => {
        container.scrollTop = container.scrollHeight
      })
    }
  }
})
