import { Controller } from '@hotwired/stimulus'

export default class SubmitFormController extends Controller {
  submit() {
    this.element.submit();
  }
}
