import { Controller } from "@hotwired/stimulus"
import Tribute from "tributejs"
import Trix from "trix"

export default class extends Controller {
  static targets = ["field"]

  connect() {
    this.editor = this.fieldTarget.editor
    this.initializeTribute()
  }

  initializeTribute() {
    this.tribute = new Tribute({
      allowSpaces: true,
      lookup: "name",
      values: this.fetchArticles,
    })
    this.tribute.attach(this.fieldTarget)
    this.tribute.range.pasteHtml = this._pasteHtml.bind(this)
    this.fieldTarget.addEventListener("tribute-replaced", this.replaced)
  }

  fetchArticles(text, callback) {
    fetch(`/mentions.json?query=${text}`)
      .then(response => response.json())
      .then(articles => callback(articles))
      .catch(error => callback([]))
  }

  replaced(e) {
    let mention = e.detail.item.original

    let attachment = new Trix.Attachment({
      sgid: mention.sgid,
      content: mention.content,
    })
    this.editor.insertAttachment(attachment)
    this.editor.insertString(" ")
  }

  _pasteHtml(html, startPos, endPos) {
    let position = this.editor.getPosition()
    this.editor.setSelectedRange([position - (endPos - startPos), position])
    this.editor.deleteInDirection("backward")
  }
}
