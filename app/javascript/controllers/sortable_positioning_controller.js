import Sortable from '@stimulus-components/sortable';

export default class SortablePositioningController extends Sortable {
  static targets = ['position'];

  onUpdate() {
    this.positionTargets.forEach((input, i) => {
      input.value = i + 1;
    });
  }
}
