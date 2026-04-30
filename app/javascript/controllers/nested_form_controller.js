import { Controller } from "@hotwired/stimulus"

export default class NestedFormController extends Controller {
  static values = {
    minItems: { type: Number, default: 0 }
  };

  static targets = [
    'template',
    'container',
    'item',
    'removeButton'
  ];

  connect() {
    this.#arrangeRemoveButtons();
  }

  add() {
    const item  = this.templateTarget.content.cloneNode(true);
    const index = Date.now();

    for (const input of item.querySelectorAll('input, select, textarea')) {
      input.id   = input.id.replace('__INDEX__', index);
      input.name = input.name.replace('__INDEX__', index);
    }

    for (const label of item.querySelectorAll('label')) {
      label.htmlFor = label.htmlFor.replace('__INDEX__', index);
    }

    this.containerTarget.appendChild(item);
    this.#arrangeRemoveButtons();
  }

  remove(e) {
    const item         = e.target.closest('[data-nested-form-target="item"]');
    const maybeIdInput = item.nextElementSibling;

    if (maybeIdInput instanceof HTMLInputElement && maybeIdInput.name.endsWith('[id]')) {
      item.hidden = true;

      for (const input of item.querySelectorAll('input:not([type="hidden"]), select, textarea')) {
        input.disabled = true;
      }

      const destroyInput = document.createElement('input');

      destroyInput.type  = 'hidden';
      destroyInput.name  = maybeIdInput.name.replace('[id]', '[_destroy]');
      destroyInput.value = 'true';

      item.appendChild(destroyInput);
    } else {
      item.remove();
    }

    this.#arrangeRemoveButtons();
  }

  #arrangeRemoveButtons() {
    const visibleItems  = this.itemTargets.filter((item) => !item.hidden);
    const disabled      = visibleItems.length <= this.minItemsValue;

    for (const button of this.removeButtonTargets) {
      button.disabled = disabled;
    }
  }
}
