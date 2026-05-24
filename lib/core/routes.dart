import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/landing/landing_page.dart';
import '../features/admin/dashboard.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );
}