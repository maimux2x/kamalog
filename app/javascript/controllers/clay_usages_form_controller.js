import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "usages", "addedUsage"]

  add(event) {
    const template = this.templateTarget;
    const usages = this.usagesTarget;

    const clone = template.content.cloneNode(true);

    usages.appendChild(clone);
  }

  remove() {
    const added = this.addedUsageTarget;
    const usages = this.usagesTarget;

    usages.removeChild(added);
  }
}
