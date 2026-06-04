import 'dart:html' as html;

void goToLandingSite() {
  html.window.location.hash = '';
  html.window.location.reload();
}
