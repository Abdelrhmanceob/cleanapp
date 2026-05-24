import 'package:flutter/material.dart';
import '../core/theme.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  const AppHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.07))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
              ),
              if (subtitle != null)
                Text(subtitle!, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13)),
            ],
          ),
          Row(
            children: [
              _HeaderIconBtn(icon: Icons.search, tooltip: 'Search'),
              const SizedBox(width: 8),
              _HeaderIconBtn(icon: Icons.notifications_outlined, tooltip: 'Notifications'),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 18,
                backgroundColor: AppTheme.primaryGold.withOpacity(0.2),
                child: const Text('A', style: TextStyle(color: AppTheme.primaryGold, fontWeight: FontWeight.w700, fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderIconBtn extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  const _HeaderIconBtn({required this.icon, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Icon(icon, color: Colors.white.withOpacity(0.5), size: 18),
      ),
    );
  }
}