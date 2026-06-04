import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/admin_layout.dart';
import '../../core/admin_scope.dart';
import '../../core/admin_store.dart';
import '../../core/theme.dart';
import 'widgets/order_card.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  OrderStatus? _filterStatus;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = AdminScope.of(context);
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final filtered = store.filteredOrders(status: _filterStatus, query: _searchQuery);
        final mobile = AdminLayout.isMobile(context);
        return SingleChildScrollView(
          padding: AdminLayout.pagePadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SummaryRow(store: store).animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppTheme.borderSubtle),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: AppTheme.textDark, fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'بحث بالعميل أو رقم الطلب...',
                        hintStyle: TextStyle(color: AppTheme.textMuted, fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: AppTheme.textMuted, size: 18),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onChanged: (v) => setState(() => _searchQuery = v),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [null, ...OrderStatus.values].map(
                        (s) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: _FilterChip(
                            label: s == null ? 'الكل' : orderStatusLabelAr(s),
                            isActive: _filterStatus == s,
                            color: s == null ? AppTheme.textDark : orderStatusColor(s),
                            onTap: () => setState(() => _filterStatus = s),
                          ),
                        ),
                      ).toList(),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 20),
              _OrdersSection(orders: filtered, store: store, mobile: mobile)
                  .animate()
                  .fadeIn(delay: 150.ms),
            ],
          ),
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final AdminStore store;
  const _SummaryRow({required this.store});

  @override
  Widget build(BuildContext context) {
    final counts = {
      'الكل': store.totalOrders,
      'انتظار': store.pendingCount,
      'تنفيذ': store.inProgressCount,
      'مكتمل': store.completedCount,
    };
    final colors = [
      AppTheme.textDark,
      orderStatusColor(OrderStatus.pending),
      orderStatusColor(OrderStatus.inProgress),
      orderStatusColor(OrderStatus.completed),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: counts.entries.toList().asMap().entries.map((entry) {
        final i = entry.key;
        final e = entry.value;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors[i].withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e.value.toString(),
                style: TextStyle(color: colors[i], fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(e.key, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isActive ? color.withOpacity(0.4) : AppTheme.borderSubtle),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? color : AppTheme.textMuted,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _OrdersSection extends StatelessWidget {
  final List<OrderModel> orders;
  final AdminStore store;
  final bool mobile;
  const _OrdersSection({
    required this.orders,
    required this.store,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    if (mobile) {
      if (orders.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(48),
          child: Center(
            child: Text('لا توجد طلبات', style: TextStyle(color: AppTheme.textMuted, fontSize: 14)),
          ),
        );
      }
      return Column(
        children: orders
            .map((o) => AdminOrderCard(order: o, store: store, showWorker: true))
            .toList(),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFEEEBE4))),
            ),
            child: const Row(
              children: [
                _TH('رقم الطلب', flex: 2),
                _TH('العميل', flex: 3),
                _TH('الخدمة', flex: 3),
                _TH('العامل', flex: 3),
                _TH('التاريخ', flex: 2),
                _TH('المبلغ', flex: 2),
                _TH('الحالة', flex: 2),
                _TH('إجراء', flex: 1),
              ],
            ),
          ),
          if (orders.isEmpty)
            const Padding(
              padding: EdgeInsets.all(48),
              child: Text('لا توجد طلبات', style: TextStyle(color: AppTheme.textMuted, fontSize: 14)),
            )
          else
            ...orders.map((o) => _OrderRow(order: o, store: store)),
        ],
      ),
    );
  }
}

class _TH extends StatelessWidget {
  final String label;
  final int flex;
  const _TH(this.label, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.textMuted,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _OrderRow extends StatefulWidget {
  final OrderModel order;
  final AdminStore store;
  const _OrderRow({required this.order, required this.store});

  @override
  State<_OrderRow> createState() => _OrderRowState();
}

class _OrderRowState extends State<_OrderRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final o = widget.order;
    final activeWorkers = widget.store.workers.where((w) => w.active).toList();
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0xFFF9F7F2) : Colors.transparent,
          border: const Border(bottom: BorderSide(color: Color(0xFFEEEBE4))),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                o.id,
                style: const TextStyle(
                  color: AppTheme.primaryGold,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(flex: 3, child: Text(o.client, style: const TextStyle(fontSize: 13))),
            Expanded(
              flex: 3,
              child: Text(o.service, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
            ),
            Expanded(
              flex: 3,
              child: PopupMenuButton<String>(
                child: Text(
                  o.worker,
                  style: TextStyle(
                    fontSize: 13,
                    color: o.worker == 'غير معيّن' ? AppTheme.textMuted : AppTheme.textDark,
                  ),
                ),
                onSelected: (name) => widget.store.assignWorker(o.id, name),
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'غير معيّن', child: Text('غير معيّن')),
                  ...activeWorkers.map((w) => PopupMenuItem(value: w.name, child: Text(w.name))),
                ],
              ),
            ),
            Expanded(flex: 2, child: Text(o.date, style: const TextStyle(fontSize: 12, color: AppTheme.textMuted))),
            Expanded(
              flex: 2,
              child: Text(o.amount, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              flex: 2,
              child: PopupMenuButton<OrderStatus>(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: orderStatusColor(o.status).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    orderStatusLabelAr(o.status),
                    style: TextStyle(
                      color: orderStatusColor(o.status),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onSelected: (s) => widget.store.updateOrderStatus(o.id, s),
                itemBuilder: (_) => OrderStatus.values
                    .map((s) => PopupMenuItem(value: s, child: Text(orderStatusLabelAr(s))))
                    .toList(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(Icons.more_horiz, color: Colors.grey.shade400, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
