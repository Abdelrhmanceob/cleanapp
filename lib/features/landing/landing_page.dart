import 'package:flutter/material.dart';
import 'widgets/service_journey_section.dart';

/// Embedded in [#flutter-host] via web/flutter_bootstrap.js (hostElement).
/// Static landing (hero, pricing, etc.) lives in web/index.html from stitch/.
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF111214),
      body: SingleChildScrollView(
        child: ServiceJourneySection(),
      ),
    );
  }
}
