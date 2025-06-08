import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["flashNotice"]

  flashNoticeTargetConnected(element) {
    setTimeout(() => {
      element.classList.add('transform', 'opacity-0', 'transition', 'duration-1000');
    }, 3000);
  }
}
