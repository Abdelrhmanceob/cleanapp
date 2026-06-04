import 'package:flutter/material.dart';

/// Shared breakpoints and spacing for the admin panel.
class AdminLayout {
  AdminLayout._();

  static const double mobileBreakpoint = 768;
  static const double tabletBreakpoint = 1100;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= mobileBreakpoint && w < tabletBreakpoint;
  }

  static EdgeInsets pagePadding(BuildContext context) =>
      EdgeInsets.all(isMobile(context) ? 16 : 32);

  static int gridColumns(
    BuildContext context, {
    int desktop = 4,
    int tablet = 2,
  }) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static double gridChildAspectRatio(BuildContext context) {
    if (isMobile(context)) return 2.2;
    if (isTablet(context)) return 1.9;
    return 1.8;
  }
}
