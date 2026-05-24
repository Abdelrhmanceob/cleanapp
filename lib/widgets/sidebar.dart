import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';

class AppSidebar extends StatelessWidget {
  final int selectedIndex;
  const AppSidebar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        border: Border(right: BorderSide(color: Colors.white.withOpacity(0.07))),
      ),
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.07))),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.bolt, color: AppTheme.textDark, size: 18),
                ),
                const SizedBox(width: 12),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Nazavly',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' ERP',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Nav items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NavSection(label: 'MAIN'),
                  _NavItem(icon: Icons.dashboard_outlined, label: 'Dashboard', index: 0, selectedIndex: selectedIndex),
                  _NavItem(icon: Icons.receipt_long_outlined, label: 'Orders', index: 1, selectedIndex: selectedIndex),
                  _NavItem(icon: Icons.people_outline, label: 'Workers', index: 2, selectedIndex: selectedIndex),
                  _NavItem(icon: Icons.map_outlined, label: 'Live Map', index: 3, selectedIndex: selectedIndex),
                  const SizedBox(height: 16),
                  _NavSection(label: 'ANALYTICS'),
                  _NavItem(icon: Icons.bar_chart_outlined, label: 'Reports', index: 4, selectedIndex: selectedIndex),
                  _NavItem(icon: Icons.trending_up_outlined, label: 'Revenue', index: 5, selectedIndex: selectedIndex),
                  const SizedBox(height: 16),
                  _NavSection(label: 'SETTINGS'),
                  _NavItem(icon: Icons.settings_outlined, label: 'Settings', index: 6, selectedIndex: selectedIndex),
                ],
              ),
            ),
          ),
          // Bottom user info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.07))),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppTheme.primaryGold.withOpacity(0.2),
                  child: const Text('A', style: TextStyle(color: AppTheme.primaryGold, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Admin User', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                      Text('admin@nazavly.com', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => context.go('/'),
                  child: Icon(Icons.logout, color: Colors.white.withOpacity(0.3), size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavSection extends StatelessWidget {
  final String label;
  const _NavSection({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withOpacity(0.25),
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final int index;
  final int selectedIndex;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.selectedIndex,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;
  final bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.index == widget.selectedIndex;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primaryGold.withOpacity(0.12)
              : _hovered
                  ? Colors.white.withOpacity(0.04)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isActive ? Border.all(color: AppTheme.primaryGold.withOpacity(0.25)) : null,
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 18,
              color: isActive ? AppTheme.primaryGold : Colors.white.withOpacity(0.45),
            ),
            const SizedBox(width: 12),
            Text(
              widget.label,
              style: TextStyle(
                color: isActive ? AppTheme.primaryGold : Colors.white.withOpacity(0.6),
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}