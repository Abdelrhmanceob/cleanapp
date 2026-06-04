import 'package:flutter/material.dart';
import '../../core/admin_layout.dart';
import '../../core/admin_scope.dart';
import '../../core/theme.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AdminScope.of(context);
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final completionRate = store.totalOrders == 0
            ? 0.0
            : store.completedCount / store.totalOrders;
        final mobile = AdminLayout.isMobile(context);
        return SingleChildScrollView(
          padding: AdminLayout.pagePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _StatCard(
                    'معدل الإكمال',
                    '${(completionRate * 100).toStringAsFixed(0)}%',
                    fullWidth: mobile,
                  ),
                  _StatCard('طلبات قيد الانتظار', '${store.pendingCount}', fullWidth: mobile),
                  _StatCard('طلبات جارية', '${store.inProgressCount}', fullWidth: mobile),
                  _StatCard(
                    'متوسط الإيراد / طلب',
                    store.completedCount == 0
                        ? '—'
                        : '${(store.revenueEgp / store.completedCount).round()} ج.م',
                    fullWidth: mobile,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderSubtle),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ملخص سريع',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 16),
                    _Bar(label: 'مكتمل', value: store.completedCount, max: store.totalOrders, color: const Color(0xFF2D8E5B)),
                    _Bar(label: 'جاري', value: store.inProgressCount, max: store.totalOrders, color: const Color(0xFF4F9CF9)),
                    _Bar(label: 'انتظار', value: store.pendingCount, max: store.totalOrders, color: const Color(0xFFE67E22)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final bool fullWidth;
  const _StatCard(this.title, this.value, {this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppTheme.primaryDark)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  final Color color;
  const _Bar({required this.label, required this.value, required this.max, required this.color});

  @override
  Widget build(BuildContext context) {
    final pct = max == 0 ? 0.0 : value / max;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text('$value', style: const TextStyle(color: AppTheme.textMuted)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 8,
              backgroundColor: const Color(0xFFEEEBE4),
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
