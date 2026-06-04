import 'package:flutter/material.dart';
import '../../../core/admin_store.dart';
import '../../../core/theme.dart';

/// Compact order card for narrow admin layouts.
class AdminOrderCard extends StatelessWidget {
  final OrderModel order;
  final AdminStore store;
  final bool showWorker;
  const AdminOrderCard({
    super.key,
    required this.order,
    required this.store,
    this.showWorker = false,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = orderStatusColor(order.status);
    final activeWorkers = store.workers.where((w) => w.active).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  order.id,
                  style: const TextStyle(
                    color: AppTheme.primaryGold,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              PopupMenuButton<OrderStatus>(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    orderStatusLabelAr(order.status),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
                onSelected: (s) => store.updateOrderStatus(order.id, s),
                itemBuilder: (_) => OrderStatus.values
                    .map((s) => PopupMenuItem(value: s, child: Text(orderStatusLabelAr(s))))
                    .toList(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(order.client, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          const SizedBox(height: 4),
          Text(order.service, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
          if (showWorker) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton<String>(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.person_outline, size: 16, color: AppTheme.textMuted),
                    const SizedBox(width: 6),
                    Text(
                      order.worker,
                      style: TextStyle(
                        fontSize: 13,
                        color: order.worker == 'غير معيّن' ? AppTheme.textMuted : AppTheme.textDark,
                      ),
                    ),
                  ],
                ),
                onSelected: (name) => store.assignWorker(order.id, name),
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'غير معيّن', child: Text('غير معيّن')),
                  ...activeWorkers.map((w) => PopupMenuItem(value: w.name, child: Text(w.name))),
                ],
              ),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              if (showWorker)
                Expanded(
                  child: Text(
                    order.date,
                    style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                  ),
                ),
              Text(
                order.amount,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
