import 'package:flutter/material.dart';
import 'admin_store.dart';

class AdminScope extends InheritedNotifier<AdminStore> {
  const AdminScope({
    super.key,
    required AdminStore store,
    required super.child,
  }) : super(notifier: store);

  static AdminStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AdminScope>();
    assert(scope != null, 'AdminScope not found');
    return scope!.notifier!;
  }
}
