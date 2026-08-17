import { Controller } from "@hotwired/stimulus"
import Sortable from "@stimulus-components/sortable"

export default class PositionSortableController extends Sortable {
  static targets = ['item'];

  onUpdate(event) {
    event.preventDefault();

    let i = 1;
    for (const item of this.itemTargets) {
      const input = item.querySelector("input[id$='_position']");
      input.value = i++;
    }
  }
}
