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
    const item = e.target.closest('div[data-attach-images-target="item"]');

    item.remove();
  }
}
