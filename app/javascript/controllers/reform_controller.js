import { Controller } from '@hotwired/stimulus';

export default class ReformController extends Controller {
  static values = {
    visitOptions: Object
  };

  visit() {
    const data = new FormData(this.element);
    const url  = new URL(location.href);

    url.search = new URLSearchParams(data).toString();

    Turbo.visit(url.toString(), this.visitOptionsValue);
  }
}
