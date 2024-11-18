import { Controller } from "@hotwired/stimulus"
import Tribute from 'tribute'
import Trix from 'trix'

export default class extends Controller {
  static targets = ["field"]

  connect() {
    this.editor = this.fieldTarget.editor
    this.initializeTribute()
  }

  disconnect() {
    this.tribute.detach(this.fieldTarget)
  }

  initializeTribute() {
    this.tribute = new Tribute({
      allowSpaces: true,
      lookup: 'name',
      values: this.fetchWritables
    })
    this.tribute.attach(this.fieldTarget)

    // consider removing this line and accessing tribute instance directly from field
    this.fieldTarget.tribute = this.tribute

    this.tribute.range.pasteHtml = this._pasteHtml.bind(this)
    this.fieldTarget.addEventListener('tribute-replaced', this.replaced)
  }

  fetchWritables(text, callback) {
    fetch(`/mentions.json?query=${text}`)
      .then(response => response.json())
      .then(writables => callback(writables))
      .catch(error => callback([]))
  }

  replaced(e) {
    let mention = e.detail.item.original
    let attachment = new Trix.Attachment({
      sgid: mention.sgid,
      content: mention.content
    })
    this.editor.insertAttachment(attachment)
    this.editor.insertString(' ')
  }

  _pasteHtml(html, startPos, endPos) {
    let position = this.editor.getPosition()
    this.editor.setSelectedRange([position - (endPos - startPos), position])
    this.editor.deleteInDirection('backward')
  }
}
