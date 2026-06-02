import { Controller } from "@hotwired/stimulus"

export default class UploadImageController extends Controller {
  static targets = ['form']

  upload() {
    const form = this.formTarget;
    form.submit();
  }
}
