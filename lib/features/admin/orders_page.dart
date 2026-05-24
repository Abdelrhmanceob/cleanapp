import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme.dart';

enum OrderStatus { pending, inProgress, completed, cancelled }

class OrderModel {
  final String id;
  final String client;
  final String service;
  final String address;
  final String worker;
  final String amount;
  final String date;
  final OrderStatus status;

  const OrderModel({
    required this.id,
    required this.client,
    required this.service,
    required this.address,
    required this.worker,
    required this.amount,
    required this.date,
    required this.status,
  });
}

const _mockOrders = [
  OrderModel(id: '#ORD-001', client: 'Sarah Johnson', service: 'Deep Cleaning', address: '14 Oak Ave, Cairo', worker: 'Ahmed Mohamed', amount: '\$120', date: 'May 24, 2026', status: OrderStatus.completed),
  OrderModel(id: '#ORD-002', client: 'Mark Williams', service: 'Regular Clean', address: '7 Main St, Cairo', worker: 'Unassigned', amount: '\$75', date: 'May 24, 2026', status: OrderStatus.pending),
  OrderModel(id: '#ORD-003', client: 'Emma Davis', service: 'Office Cleaning', address: '55 Business Park', worker: 'Khalid Hassan', amount: '\$200', date: 'May 23, 2026', status: OrderStatus.inProgress),
  OrderModel(id: '#ORD-004', client: 'James Wilson', service: 'Deep Cleaning', address: '9 Park Rd, Cairo', worker: 'Youssef Ali', amount: '\$120', date: 'May 23, 2026', status: OrderStatus.cancelled),
  OrderModel(id: '#ORD-005', client: 'Olivia Brown', service: 'Regular Clean', address: '23 Nile St, Cairo', worker: 'Ahmed Mohamed', amount: '\$75', date: 'May 22, 2026', status: OrderStatus.completed),
  OrderModel(id: '#ORD-006', client: 'Liam Martinez', service: 'Move-In Cleaning', address: '88 New Town Blvd', worker: 'Tamer Sayed', amount: '\$180', date: 'May 22, 2026', status: OrderStatus.completed),
  OrderModel(id: '#ORD-007', client: 'Ava Thompson', service: 'Regular Clean', address: '3 Garden City', worker: 'Unassigned', amount: '\$75', date: 'May 21, 2026', status: OrderStatus.pending),
  OrderModel(id: '#ORD-008', client: 'Noah Garcia', service: 'Deep Cleaning', address: '66 Zamalek, Cairo', worker: 'Khalid Hassan', amount: '\$120', date: 'May 21, 2026', status: OrderStatus.inProgress),
  OrderModel(id: '#ORD-009', client: 'Isabella Lee', service: 'Office Cleaning', address: '12 Smart Village', worker: 'Ahmed Mohamed', amount: '\$200', date: 'May 20, 2026', status: OrderStatus.completed),
  OrderModel(id: '#ORD-010', client: 'Mason Anderson', service: 'Regular Clean', address: '45 Maadi, Cairo', worker: 'Youssef Ali', amount: '\$75', date: 'May 20, 2026', status: OrderStatus.pending),
  OrderModel(id: '#ORD-011', client: 'Sophia Taylor', service: 'Deep Cleaning', address: '77 Heliopolis', worker: 'Tamer Sayed', amount: '\$120', date: 'May 19, 2026', status: OrderStatus.completed),
  OrderModel(id: '#ORD-012', client: 'Ethan Jackson', service: 'Move-In Cleaning', address: '31 New Cairo', worker: 'Unassigned', amount: '\$180', date: 'May 19, 2026', status: OrderStatus.cancelled),
];

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  OrderStatus? _filterStatus;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<OrderModel> get _filtered {
    return _mockOrders.where((o) {
      final matchStatus = _filterStatus == null || o.status == _filterStatus;
      final q = _searchQuery.toLowerCase();
      final matchSearch = q.isEmpty ||
          o.client.toLowerCase().contains(q) ||
          o.id.toLowerCase().contains(q) ||
          o.service.toLowerCase().contains(q);
      return matchStatus && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary chips
          _SummaryRow().animate().fadeIn(duration: 400.ms),
          const SizedBox(height: 24),
          // Search & filters
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppTheme.darkCard,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search orders, clients...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14),
                      prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.3), size: 18),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onChanged: (v) => setState(() => _searchQuery = v),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ...[null, OrderStatus.pending, OrderStatus.inProgress, OrderStatus.completed, OrderStatus.cancelled]
                  .map((s) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: _FilterChip(
                          label: s == null ? 'All' : _statusLabel(s),
                          isActive: _filterStatus == s,
                          color: s == null ? Colors.white : _statusColor(s),
                          onTap: () => setState(() => _filterStatus = s),
                        ),
                      )),
            ],
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 20),
          // Table
          _OrdersTable(orders: _filtered).animate().fadeIn(delay: 150.ms),
        ],
      ),
    );
  }
}

String _statusLabel(OrderStatus s) {
  switch (s) {
    case OrderStatus.pending: return 'Pending';
    case OrderStatus.inProgress: return 'In Progress';
    case OrderStatus.completed: return 'Completed';
    case OrderStatus.cancelled: return 'Cancelled';
  }
}

Color _statusColor(OrderStatus s) {
  switch (s) {
    case OrderStatus.pending: return const Color(0xFFFF9F43);
    case OrderStatus.inProgress: return const Color(0xFF4F9CF9);
    case OrderStatus.completed: return const Color(0xFF2D8E5B);
    case OrderStatus.cancelled: return const Color(0xFFBA1A1A);
  }
}

class _SummaryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counts = {
      'Total': _mockOrders.length,
      'Pending': _mockOrders.where((o) => o.status == OrderStatus.pending).length,
      'In Progress': _mockOrders.where((o) => o.status == OrderStatus.inProgress).length,
      'Completed': _mockOrders.where((o) => o.status == OrderStatus.completed).length,
      'Cancelled': _mockOrders.where((o) => o.status == OrderStatus.cancelled).length,
    };
    final colors = [Colors.white, const Color(0xFFFF9F43), const Color(0xFF4F9CF9), const Color(0xFF2D8E5B), const Color(0xFFBA1A1A)];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: counts.entries.toList().asMap().entries.map((entry) {
        final i = entry.key;
        final e = entry.value;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: AppTheme.darkCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors[i].withOpacity(0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.value.toString(), style: TextStyle(color: colors[i], fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text(e.key, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
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

  const _FilterChip({required this.label, required this.isActive, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isActive ? color.withOpacity(0.4) : Colors.white.withOpacity(0.1)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? color : Colors.white.withOpacity(0.5),
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _OrdersTable extends StatelessWidget {
  final List<OrderModel> orders;
  const _OrdersTable({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.07))),
            ),
            child: Row(
              children: [
                _TH('ORDER ID', flex: 2),
                _TH('CLIENT', flex: 3),
                _TH('SERVICE', flex: 3),
                _TH('WORKER', flex: 3),
                _TH('DATE', flex: 2),
                _TH('AMOUNT', flex: 2),
                _TH('STATUS', flex: 2),
                _TH('', flex: 1),
              ],
            ),
          ),
          if (orders.isEmpty)
            Padding(
              padding: const EdgeInsets.all(48),
              child: Text('No orders found', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14)),
            )
          else
            ...orders.map(
              (o) => _OrderRow(order: o),
            ),
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
        style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2),
      ),
    );
  }
}

class _OrderRow extends StatefulWidget {
  final OrderModel order;
  const _OrderRow({required this.order});

  @override
  State<_OrderRow> createState() => _OrderRowState();
}

class _OrderRowState extends State<_OrderRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final o = widget.order;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: _hovered ? Colors.white.withOpacity(0.03) : Colors.transparent,
          border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.04))),
        ),
        child: Row(
          children: [
            Expanded(flex: 2, child: Text(o.id, style: const TextStyle(color: AppTheme.primaryGold, fontSize: 13, fontWeight: FontWeight.w600))),
            Expanded(flex: 3, child: Text(o.client, style: const TextStyle(color: Colors.white, fontSize: 13))),
            Expanded(flex: 3, child: Text(o.service, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13))),
            Expanded(flex: 3, child: Text(o.worker, style: TextStyle(color: o.worker == 'Unassigned' ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.7), fontSize: 13))),
            Expanded(flex: 2, child: Text(o.date, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12))),
            Expanded(flex: 2, child: Text(o.amount, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500))),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(o.status).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: _statusColor(o.status).withOpacity(0.3)),
                ),
                child: Text(
                  _statusLabel(o.status),
                  style: TextStyle(color: _statusColor(o.status), fontSize: 11, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(Icons.more_horiz, color: Colors.white.withOpacity(0.2), size: 18),
            ),
          ],
        ),
      ),
    );
  }
}