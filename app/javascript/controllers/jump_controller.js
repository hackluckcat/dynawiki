import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { title: String, lang: String };
  static targets = ["menu", "jump", "dig"]

  currentSelection = ""

  hideMenu() {
    this.menuTarget.style.visibility = "hidden";
  }

  select(e) {
    const selection = window.getSelection();

    if (selection.toString().length === 0 || selection.toString() === this.currentSelection) {
      this.menuTarget.style.visibility = "hidden";
      return;
    }
    this.currentSelection = selection.toString()

    this.menuTarget.style.visibility = "visible";
    this.menuTarget.style.left = e.pageX + 10 + "px";
    this.menuTarget.style.top = e.pageY + 10 + "px";

    this.jumpTarget.href = `/${this.langValue}/wiki/${encodeURIComponent(
      selection.toString(),
    )}`;

    this.digTarget.href = `/${this.langValue}/wiki/${encodeURIComponent(
      `${this.titleValue} ${selection.toString()}`,
    )}`;
  }
}
