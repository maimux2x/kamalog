import { Controller } from '@hotwired/stimulus';

export default class TooltipController extends Controller {
  static values = {
    title: String
  };

  connect() {
    this.tooltip = new bootstrap.Tooltip(this.element, {
      trigger: 'manual',
      title: this.titleValue
    });

    this.element.addEventListener('shown.bs.tooltip', () => {
      if (this.timer) {
        clearTimeout(this.timer);
      }

      this.timer = setTimeout(() => {
        this.tooltip.hide();
      }, 1000);
    });
  }

  disconnect() {
    this.tooltip.dispose();
  }

  show() {
    this.tooltip.show();
  }
}

