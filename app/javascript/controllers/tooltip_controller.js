import { Controller } from '@hotwired/stimulus';

export default class TooltipController extends Controller {
  static values = {
    title: String
  };

  isShown = false;

  connect() {
    this.tooltip = new bootstrap.Tooltip(this.element, {
      trigger: 'manual',
      title: this.titleValue
    });
  }

  disconnect() {
    if (this.timer) {
      clearTimeout(this.timer);
    }

    this.tooltip.dispose();
  }

  show() {
    if (!this.isShown) {
      this.tooltip.show();

      this.isShown = true;
    }

    if (this.timer) {
      clearTimeout(this.timer);
    }

    this.timer = setTimeout(() => {
      this.tooltip.hide();

      this.isShown = false;
    }, 1000);
  }
}

