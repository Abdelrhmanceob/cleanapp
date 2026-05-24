import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/routes.dart';
import 'core/theme.dart';

class NazavlyApp extends StatelessWidget {
  const NazavlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nazavly — The Golden Standard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRoutes.router,
    );
  }
}