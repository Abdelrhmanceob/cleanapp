import 'package:flutter/material.dart';
import '../../core/admin_layout.dart';
import '../../core/admin_scope.dart';
import '../../core/admin_store.dart';
import '../../core/theme.dart';
import 'widgets/order_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AdminScope.of(context);
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final cols = AdminLayout.gridColumns(context);
        final mobile = AdminLayout.isMobile(context);
        return SingleChildScrollView(
          padding: AdminLayout.pagePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                crossAxisCount: cols,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: AdminLayout.gridChildAspectRatio(context),
                children: [
                  _KpiCard(
                    title: 'إجمالي الطلبات',
                    value: '${store.totalOrders}',
                    icon: Icons.receipt_long,
                    trend: '+${store.pendingCount} جديد',
                    color: AppTheme.primaryGold,
                  ),
                  _KpiCard(
                    title: 'عمال نشطون',
                    value: '${store.activeWorkers}',
                    icon: Icons.people,
                    trend: '${store.workers.length} إجمالي',
                    color: const Color(0xFF2D8E5B),
                  ),
                  _KpiCard(
                    title: 'الإيرادات',
                    value: '${_formatNumber(store.revenueEgp)} ج.م',
                    icon: Icons.payments,
                    trend: '${store.completedCount} مكتمل',
                    color: const Color(0xFF5B6AD0),
                  ),
                  _KpiCard(
                    title: 'رضا العملاء',
                    value: '${store.satisfactionScore.toStringAsFixed(1)} / 5',
                    icon: Icons.star,
                    trend: '+0.2',
                    color: const Color(0xFFE67E22),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'أحدث الطلبات',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 16),
              _RecentOrdersSection(
                orders: store.recentOrders,
                store: store,
                mobile: mobile,
              ),
            ],
          ),
        );
      },
    );
  }

  static String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String trend;
  final Color color;
  const _KpiCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.trend,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 12,
                  color: trend.startsWith('+') ? const Color(0xFF2D8E5B) : AppTheme.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentOrdersSection extends StatelessWidget {
  final List<OrderModel> orders;
  final AdminStore store;
  final bool mobile;
  const _RecentOrdersSection({
    required this.orders,
    required this.store,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    if (mobile) {
      if (orders.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text('لا توجد طلبات بعد', style: TextStyle(color: AppTheme.textMuted)),
          ),
        );
      }
      return Column(
        children: orders
            .map((o) => AdminOrderCard(order: o, store: store))
            .toList(),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFF9F7F2),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Row(
              children: [
                Expanded(flex: 1, child: Text('رقم الطلب', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textMuted))),
                Expanded(flex: 2, child: Text('العميل', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textMuted))),
                Expanded(flex: 2, child: Text('الخدمة', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textMuted))),
                Expanded(flex: 2, child: Text('المبلغ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textMuted))),
                Expanded(flex: 1, child: Text('الحالة', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textMuted))),
              ],
            ),
          ),
          if (orders.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text('لا توجد طلبات بعد', style: TextStyle(color: AppTheme.textMuted)),
            )
          else
            ...orders.map((o) => _OrderRow(order: o, store: store)),
        ],
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  final OrderModel order;
  final AdminStore store;
  const _OrderRow({required this.order, required this.store});

  @override
  Widget build(BuildContext context) {
    final statusColor = orderStatusColor(order.status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEEEBE4))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              order.id,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppTheme.primaryGold,
              ),
            ),
          ),
          Expanded(flex: 2, child: Text(order.client, style: const TextStyle(fontSize: 13, color: AppTheme.textDark))),
          Expanded(flex: 2, child: Text(order.service, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted))),
          Expanded(
            flex: 2,
            child: Text(
              order.amount,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark),
            ),
          ),
          Expanded(
            flex: 1,
            child: PopupMenuButton<OrderStatus>(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  orderStatusLabelAr(order.status),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: statusColor),
                  textAlign: TextAlign.center,
                ),
              ),
              onSelected: (s) => store.updateOrderStatus(order.id, s),
              itemBuilder: (_) => OrderStatus.values
                  .map(
                    (s) => PopupMenuItem(
                      value: s,
                      child: Text(orderStatusLabelAr(s)),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
