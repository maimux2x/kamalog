import { Controller } from "@hotwired/stimulus"

export default class AttachImagesController extends Controller {
  static targets = ['template', 'container', 'item']

  preview(e) {
    for (const file of e.target.files) {
      const photo = this.templateTarget.content.cloneNode(true);

      const img = photo.querySelector('img');
      img.src   = URL.createObjectURL(file);

      this.containerTarget.appendChild(photo);
    }
  }

  remove(e) {
    const item = e.target.closest('[data-attach-images-target="item"]');
    const maybeIdInput = item.nextElementSibling;

    if (maybeIdInput instanceof HTMLInputElement && maybeIdInput.name.endsWith('[id]')) {
      item.hidden = true;

      const destroyInput = document.createElement('input');

      destroyInput.type  = 'hidden';
      destroyInput.name  = maybeIdInput.name.replace('[id]', '[_destroy]');
      destroyInput.value = 'true';

      item.appendChild(destroyInput);
    } else {
      item.remove();
    }
  }
}
