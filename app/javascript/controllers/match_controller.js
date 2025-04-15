import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="match"
export default class extends Controller {
  connect() {
    console.log("Match controller connected");
  }

  showMatch(event) {
    // Impedir que o evento execute antes do submit ser concluído
    event.preventDefault();

    // Espera um pequeno atraso antes de chamar a requisição
    setTimeout(() => {
      this.url = "/match";
      fetch(this.url, {
        headers: {
          Accept: "text/vnd.turbo-stream.html",
        }
      })
      .then(response => response.text())
      .then(html => {
        Turbo.renderStreamMessage(html);
      });
    }, 500); // Ajuste o tempo conforme necessário
  }
}
