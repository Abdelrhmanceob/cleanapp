import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/landing/landing_page.dart';
import '../features/admin/admin_shell.dart';
import '../features/admin/dashboard_page.dart';
import '../features/admin/orders_page.dart';
import '../features/admin/workers_page.dart';
import '../features/admin/analytics_page.dart';
import '../features/admin/settings_page.dart';
import '../features/admin/landing_content_page.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          final path = state.uri.path;
          var index = 0;
          if (path.contains('/orders')) {
            index = 1;
          } else if (path.contains('/workers')) {
            index = 2;
          } else if (path.contains('/analytics')) {
            index = 3;
          } else if (path.contains('/landing')) {
            index = 4;
          } else if (path.contains('/settings')) {
            index = 5;
          }
          return AdminShell(selectedIndex: index, child: child);
        },
        routes: [
          GoRoute(
            path: '/admin',
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: '/admin/orders',
            builder: (context, state) => const OrdersPage(),
          ),
          GoRoute(
            path: '/admin/workers',
            builder: (context, state) => const WorkersPage(),
          ),
          GoRoute(
            path: '/admin/analytics',
            builder: (context, state) => const AnalyticsPage(),
          ),
          GoRoute(
            path: '/admin/landing',
            builder: (context, state) => const LandingContentPage(),
          ),
          GoRoute(
            path: '/admin/settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );
}
