import 'package:flutter/material.dart';

import 'landing_store.dart';

class LandingScope extends InheritedNotifier<LandingStore> {
  const LandingScope({
    super.key,
    required LandingStore store,
    required super.child,
  }) : super(notifier: store);

  static LandingStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LandingScope>();
    assert(scope != null, 'LandingScope not found');
    return scope!.notifier!;
  }
}
