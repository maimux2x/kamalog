import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['target'];

  show() {
    this.targetTarget.hidden = false;
  }

  hide() {
    this.targetTarget.hidden = true;
  }
}
