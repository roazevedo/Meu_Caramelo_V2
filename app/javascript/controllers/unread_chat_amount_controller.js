import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="unread-chat-amount"
export default class extends Controller {
  static targets = ["badge"];
  
}
