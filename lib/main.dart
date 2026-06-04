import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'app.dart';
import 'core/booking_init.dart';
import 'core/landing_init.dart';

void main() {
  setUrlStrategy(const HashUrlStrategy());
  initBookingBridge();
  initLandingBridge();
  runApp(const NazavlyApp());
}
