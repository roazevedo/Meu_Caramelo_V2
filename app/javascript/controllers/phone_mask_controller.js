import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="phone-mask"
export default class extends Controller {
  static targets = ["input"]

  connect() {
    console.log("Phone mask controller conectado!")

    // Se não houver target definido, procura automaticamente
    if (this.hasInputTarget) {
      this.setupMask(this.inputTarget)
    } else {
      this.findAndSetupInput()
    }
  }

  findAndSetupInput() {
    // Múltiplos seletores para encontrar o campo
    const selectors = [
      'input[name="user[phone]"]',
      'input[name*="phone"]',
      'input[type="tel"]'
    ]

    let phoneInput = null

    for (const selector of selectors) {
      phoneInput = this.element.querySelector(selector)
      if (phoneInput) {
        console.log(`Campo encontrado com seletor: ${selector}`)
        break
      }
    }

    if (phoneInput) {
      this.setupMask(phoneInput)
    } else {
      console.log("Campo de telefone não encontrado!")
    }
  }

  setupMask(input) {
    console.log("Configurando máscara para:", input)

    // Remove listeners existentes para evitar duplicação
    input.removeEventListener('input', this.handleInput)
    input.removeEventListener('paste', this.handlePaste)
    input.removeEventListener('keydown', this.handleKeydown)

    // Adiciona os listeners
    input.addEventListener('input', this.handleInput.bind(this))
    input.addEventListener('paste', this.handlePaste.bind(this))
    input.addEventListener('keydown', this.handleKeydown.bind(this))
  }

  handleKeydown(event) {
    // Tratamento especial para Backspace
    if (event.key === 'Backspace') {
      const cursorPosition = event.target.selectionStart
      const value = event.target.value

      // Se está tentando apagar quando o cursor está logo após )
      if (cursorPosition > 0 && value[cursorPosition - 1] === ')') {
        // Se o valor é algo como "(11)" e está tentando apagar
        const numbers = value.replace(/\D/g, '')
        if (numbers.length <= 2) {
          event.preventDefault()
          event.target.value = ''
          return
        }
      }

      // Se está tentando apagar quando só tem "("
      if (value === '(' || (value.length <= 3 && value.includes('('))) {
        event.preventDefault()
        event.target.value = ''
        return
      }
    }
  }

  handleInput(event) {
    console.log("Evento input disparado!")
    console.log("Valor atual:", event.target.value)

    // Salva a posição atual do cursor
    const cursorPosition = event.target.selectionStart
    const oldValue = event.target.value

    const formatted = this.formatPhone(event.target.value)
    console.log("Valor formatado:", formatted)

    // Define o valor formatado no campo
    event.target.value = formatted

    // Lógica inteligente para posicionar o cursor
    setTimeout(() => {
      let newCursorPosition = formatted.length

      // Se o usuário estava apagando e o valor ficou menor
      if (formatted.length < oldValue.length) {
        // Se só restou o parêntese inicial, limpa tudo
        if (formatted === '(' || formatted === '') {
          event.target.value = ''
          newCursorPosition = 0
        } else if (formatted.endsWith(')') && formatted.length <= 4) {
          // Se termina com ) e tem poucos caracteres, posiciona antes do )
          newCursorPosition = formatted.length - 1
        } else {
          // Posiciona no final normalmente
          newCursorPosition = formatted.length
        }
      }

      event.target.setSelectionRange(newCursorPosition, newCursorPosition)
    }, 0)
  }

  handlePaste(event) {
    setTimeout(() => {
      // Reaplica a formatação após colar
      const inputEvent = new Event('input', { bubbles: true })
      event.target.dispatchEvent(inputEvent)
    }, 10)
  }

  formatPhone(value) {
    // Remove todos os caracteres não numéricos
    let numbers = value.replace(/\D/g, '')
    console.log("Apenas números:", numbers)

    // Limita a 11 dígitos
    if (numbers.length > 11) {
      numbers = numbers.substring(0, 11)
    }

    let formatted = ''

    // Formatação melhorada
    if (numbers.length === 0) {
      formatted = ''
    } else if (numbers.length === 1) {
      formatted = `(${numbers}`
    } else if (numbers.length === 2) {
      formatted = `(${numbers})`
    } else if (numbers.length <= 6) {
      formatted = `(${numbers.substring(0, 2)})${numbers.substring(2)}`
    } else if (numbers.length <= 10) {
      // Telefone fixo: (11)1234-5678
      formatted = `(${numbers.substring(0, 2)})${numbers.substring(2, 6)}-${numbers.substring(6)}`
    } else {
      // Celular: (11)91234-5678
      formatted = `(${numbers.substring(0, 2)})${numbers.substring(2, 7)}-${numbers.substring(7)}`
    }

    return formatted
  }

  // Método público para formatar programaticamente
  format(value) {
    return this.formatPhone(value)
  }

  // Método para obter apenas os números
  getNumbers(value = null) {
    const val = value || (this.hasInputTarget ? this.inputTarget.value : '')
    return val.replace(/\D/g, '')
  }

  // Método para validar
  isValid(value = null) {
    const numbers = this.getNumbers(value)
    return numbers.length === 10 || numbers.length === 11
  }
}
