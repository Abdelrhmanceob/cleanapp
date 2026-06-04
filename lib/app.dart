import 'package:flutter/material.dart';
import 'core/admin_scope.dart';
import 'core/admin_store.dart';
import 'core/booking_bridge.dart';
import 'core/landing_scope.dart';
import 'core/landing_store.dart';
import 'core/routes.dart';
import 'core/theme.dart';

class NazavlyApp extends StatefulWidget {
  const NazavlyApp({super.key});

  @override
  State<NazavlyApp> createState() => _NazavlyAppState();
}

class _NazavlyAppState extends State<NazavlyApp> {
  final AdminStore _adminStore = AdminStore();
  final LandingStore _landingStore = LandingStore();

  @override
  void initState() {
    super.initState();
    _landingStore.load();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      applyPendingBooking(_adminStore);
      _landingStore.syncToWeb();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LandingScope(
      store: _landingStore,
      child: AdminScope(
      store: _adminStore,
      child: MaterialApp.router(
        title: 'دكتور كلينر',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRoutes.router,
      ),
    ),
    );
  }
}
