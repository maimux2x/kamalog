import { Controller } from "@hotwired/stimulus"

export default class AttachImagesController extends Controller {
  static targets = ['template', 'container', 'item']

  preview(e) {
    for (const file of e.target.files) {
      const photo = this.templateTarget.content.cloneNode(true);

      const img = photo.querySelector('img');
      this.containerTarget.appendChild(photo);

      const reader = new FileReader();

      reader.onload = e => {
        img.src = e.target.result;
      };

      reader.readAsDataURL(file);
    }
  }

  remove(e) {
    const item = e.target.closest('div[data-attach-images-target="item"]');

    item.remove();
  }
}
