import 'dart:html' as html;
import 'dart:js' as js;

import 'landing_bridge.dart';

void initLandingBridge() {
  registerLandingReader(() {
    final raw = html.window.localStorage[landingStorageKey];
    if (raw == null || raw.isEmpty) return null;
    return raw;
  });
}

void persistLanding(String json) {
  html.window.localStorage[landingStorageKey] = json;
}

void syncLandingToDom(String json) {
  persistLanding(json);
  final fn = js.context['applyLandingContent'];
  if (fn != null) {
    (fn as js.JsFunction).apply([json]);
  }
}
