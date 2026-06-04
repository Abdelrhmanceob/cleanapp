import 'dart:convert';
import 'dart:html' as html;
import 'booking_bridge.dart';

void initBookingBridge() {
  registerBookingReader(() {
    final raw = html.window.localStorage['dr_cleaner_booking'];
    if (raw == null || raw.isEmpty) return null;
    html.window.localStorage.remove('dr_cleaner_booking');
    return parseBookingJson(raw);
  });
}

void saveBookingToStorage(Map<String, String> data) {
  html.window.localStorage['dr_cleaner_booking'] = jsonEncode(data);
}
