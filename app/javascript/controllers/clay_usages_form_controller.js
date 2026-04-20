import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['template', 'usages', 'item']

  connect() {
    this.#manageButtonDisplay();
  }

  add() {
    const template = this.templateTarget;
    const usages = this.usagesTarget;

    const clone = template.content.cloneNode(true);

    const index = Date.now();

    clone.querySelectorAll('input, select').forEach((el) => {
      el.id = el.id.replace('NEW_INDEX', index);
      el.name = el.name.replace('NEW_INDEX', index);
    })

    usages.appendChild(clone);
    this.#manageButtonDisplay();
  }

  remove(event) {
    const usages = this.usagesTarget;
    const item = event.target.closest("div[class='hstack gap-3 mb-3']");

    if (item.querySelector("input[name*='_destroy']")) {
      item.querySelector("input[name*='_destroy']").value = 1;
      item.classList.replace('hstack', 'd-none');
    } else {
      usages.removeChild(item);
    }

    this.#manageButtonDisplay();
  }

  #manageButtonDisplay() {
    let hideItemsCount = 0;

    this.itemTargets.forEach((item) => {
      if (item.className === 'd-none gap-3 mb-3') {
        hideItemsCount++;
      }
    })

    if (this.itemTargets.length - hideItemsCount === 1) {
      this.itemTargets.forEach((item) => {
        item.querySelector('button').style.display = 'none';
      })
    } else {
      this.itemTargets.forEach((item) => {
        item.querySelector('div button').removeAttribute('style');
      })
    }
  }
}
