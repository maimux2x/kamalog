import { Controller } from '@hotwired/stimulus';

export default class TooltipController extends Controller {
  connect() {
  }

  finish() {
    new bootstrap.Tooltip(this.element);
  }
}

