import { Controller } from "@hotwired/stimulus"

export default class AttachImagesController extends Controller {
  static targets = ['template', 'container', 'item']

  preview(e) {
    this.fileInput = e.target;

    for (const file of e.target.files) {
      const photo = this.templateTarget.content.cloneNode(true);
      const item = photo.querySelector('[data-attach-images-target="item"]')

      const img = photo.querySelector('img');
      this.containerTarget.appendChild(photo);
      item._file = file;

      const reader = new FileReader();

      reader.onload = e => {
        img.src = e.target.result;
      };

      reader.readAsDataURL(file);
    }
  }

  remove(e) {
    e.target.closest('div[data-attach-images-target="item"]').remove();
    this.rebulidFileList();
  }

  rebulidFileList() {
    if (!this.fileInput) return;

    const dt = new DataTransfer();

    this.itemTargets.forEach(item => {
      if (item._file) dt.items.add(item._file);
    });

    this.fileInput.files = dt.files;
  }
}
