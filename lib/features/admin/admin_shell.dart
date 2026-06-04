import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../core/web_nav.dart';

class AdminShell extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  const AdminShell({super.key, required this.child, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    String title = 'لوحة التحكم';
    String? subtitle = 'مرحباً بك في دكتور كلينر';
    if (path.contains('orders')) {
      title = 'الطلبات';
      subtitle = 'إدارة ومتابعة جميع الطلبات';
    } else if (path.contains('workers')) {
      title = 'العمال';
      subtitle = 'فريق التنظيف والتوزيع';
    } else if (path.contains('analytics')) {
      title = 'التحليلات';
      subtitle = 'مؤشرات الأداء';
    } else if (path.contains('landing')) {
      title = 'محتوى الموقع';
      subtitle = 'تحرير صفحة الهبوط ديناميكياً';
    } else if (path.contains('settings')) {
      title = 'الإعدادات';
      subtitle = 'إعدادات النظام';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: Row(
        children: [
          _Sidebar(selectedIndex: selectedIndex),
          Expanded(
            child: Column(
              children: [
                _Header(title: title, subtitle: subtitle),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final int selectedIndex;
  const _Sidebar({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: AppTheme.darkBackground,
      child: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'Dr',
                      style: TextStyle(
                        color: AppTheme.textDark,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'دكتور كلينر',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _SidebarItem(
            icon: Icons.dashboard_outlined,
            label: 'لوحة التحكم',
            selected: selectedIndex == 0,
            onTap: () => context.go('/admin'),
          ),
          _SidebarItem(
            icon: Icons.receipt_long_outlined,
            label: 'الطلبات',
            selected: selectedIndex == 1,
            onTap: () => context.go('/admin/orders'),
          ),
          _SidebarItem(
            icon: Icons.people_outline,
            label: 'العمال',
            selected: selectedIndex == 2,
            onTap: () => context.go('/admin/workers'),
          ),
          _SidebarItem(
            icon: Icons.bar_chart_outlined,
            label: 'التحليلات',
            selected: selectedIndex == 3,
            onTap: () => context.go('/admin/analytics'),
          ),
          _SidebarItem(
            icon: Icons.web_outlined,
            label: 'محتوى الموقع',
            selected: selectedIndex == 4,
            onTap: () => context.go('/admin/landing'),
          ),
          _SidebarItem(
            icon: Icons.settings_outlined,
            label: 'الإعدادات',
            selected: selectedIndex == 5,
            onTap: () => context.go('/admin/settings'),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: goToLandingSite,
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.white.withOpacity(0.4), size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'العودة للموقع',
                    style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primaryGold.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: selected ? Border.all(color: AppTheme.primaryGold.withOpacity(0.3)) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? AppTheme.primaryGold : Colors.white.withOpacity(0.5),
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: selected ? AppTheme.primaryGold : Colors.white.withOpacity(0.6),
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String? subtitle;
  const _Header({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppTheme.borderSubtle)),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 13, color: AppTheme.textMuted),
                ),
            ],
          ),
          const Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppTheme.primaryGold,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'م',
                style: TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
