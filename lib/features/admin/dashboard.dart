import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: Row(
        children: [
          _Sidebar(selectedIndex: 0),
          Expanded(
            child: Column(
              children: [
                _Header(title: 'Dashboard', subtitle: 'Welcome back, Admin'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KPI Cards
                        GridView.count(
                          crossAxisCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1.8,
                          children: const [
                            _KpiCard(title: 'Total Orders', value: '1,248', icon: Icons.receipt_long, trend: '+12%', color: AppTheme.primaryGold),
                            _KpiCard(title: 'Active Workers', value: '87', icon: Icons.people, trend: '+3', color: Color(0xFF2D8E5B)),
                            _KpiCard(title: 'Revenue', value: '148,500 EGP', icon: Icons.payments, trend: '+8%', color: Color(0xFF5B6AD0)),
                            _KpiCard(title: 'Satisfaction', value: '4.8 / 5', icon: Icons.star, trend: '+0.2', color: Color(0xFFE67E22)),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Text('Recent Orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                        const SizedBox(height: 16),
                        _RecentOrdersTable(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String trend;
  final Color color;
  const _KpiCard({required this.title, required this.value, required this.icon, required this.trend, required this.color});

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
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: color, size: 18),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
              const SizedBox(height: 2),
              Text(trend, style: TextStyle(fontSize: 12, color: trend.startsWith('+') ? const Color(0xFF2D8E5B) : AppTheme.errorRed, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentOrdersTable extends StatelessWidget {
  final _orders = const [
    {'id': '#ORD-001', 'client': 'Ahmed Mohamed', 'service': 'Deep Cleaning', 'date': '2024-01-15', 'amount': '2,400 EGP', 'status': 'Completed'},
    {'id': '#ORD-002', 'client': 'Sara Khalid', 'service': 'Basic Clean', 'date': '2024-01-15', 'amount': '1,200 EGP', 'status': 'Pending'},
    {'id': '#ORD-003', 'client': 'Mohamed Ali', 'service': 'Royal Package', 'date': '2024-01-14', 'amount': '4,500 EGP', 'status': 'Completed'},
    {'id': '#ORD-004', 'client': 'Nour Hassan', 'service': 'Premium Package', 'date': '2024-01-14', 'amount': '2,400 EGP', 'status': 'Cancelled'},
    {'id': '#ORD-005', 'client': 'Omar Farouk', 'service': 'Basic Clean', 'date': '2024-01-13', 'amount': '1,200 EGP', 'status': 'Pending'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.borderSubtle)),
      child: Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFF9F7F2),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Row(
              children: [
                Expanded(flex: 1, child: Text('Order ID', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textMuted))),
                Expanded(flex: 2, child: Text('Client', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textMuted))),
                Expanded(flex: 2, child: Text('Service', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textMuted))),
                Expanded(flex: 2, child: Text('Amount', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textMuted))),
                Expanded(flex: 1, child: Text('Status', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.textMuted))),
              ],
            ),
          ),
          ..._orders.map((o) => _OrderRow(order: o)),
        ],
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  final Map<String, String> order;
  const _OrderRow({required this.order});

  @override
  Widget build(BuildContext context) {
    final status = order['status']!;
    final statusColor = status == 'Completed' ? const Color(0xFF2D8E5B) : status == 'Pending' ? const Color(0xFFE67E22) : AppTheme.errorRed;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFEEEBE4)))),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(order['id']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.primaryGold))),
          Expanded(flex: 2, child: Text(order['client']!, style: const TextStyle(fontSize: 13, color: AppTheme.textDark))),
          Expanded(flex: 2, child: Text(order['service']!, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted))),
          Expanded(flex: 2, child: Text(order['amount']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark))),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: Text(status, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: statusColor), textAlign: TextAlign.center),
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
                  width: 32, height: 32,
                  decoration: BoxDecoration(color: AppTheme.primaryGold, borderRadius: BorderRadius.circular(6)),
                  child: const Center(child: Text('N', style: TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.w800, fontSize: 16))),
                ),
                const SizedBox(width: 10),
                const Text('Nazavly ERP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _SidebarItem(icon: Icons.dashboard_outlined, label: 'Dashboard', selected: selectedIndex == 0, onTap: () => context.go('/admin')),
          _SidebarItem(icon: Icons.receipt_long_outlined, label: 'Orders', selected: selectedIndex == 1, onTap: () => context.go('/admin/orders')),
          _SidebarItem(icon: Icons.people_outline, label: 'Workers', selected: selectedIndex == 2, onTap: () {}),
          _SidebarItem(icon: Icons.bar_chart_outlined, label: 'Analytics', selected: selectedIndex == 3, onTap: () {}),
          _SidebarItem(icon: Icons.settings_outlined, label: 'Settings', selected: selectedIndex == 4, onTap: () {}),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () => context.go('/'),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.white.withOpacity(0.4), size: 16),
                  const SizedBox(width: 8),
                  Text('Back to Site', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13)),
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
  const _SidebarItem({required this.icon, required this.label, required this.selected, required this.onTap});

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
            Icon(icon, color: selected ? AppTheme.primaryGold : Colors.white.withOpacity(0.5), size: 20),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(color: selected ? AppTheme.primaryGold : Colors.white.withOpacity(0.6), fontWeight: selected ? FontWeight.w600 : FontWeight.w400, fontSize: 14)),
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
      decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: AppTheme.borderSubtle))),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
              if (subtitle != null) Text(subtitle!, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
            ],
          ),
          const Spacer(),
          Container(
            width: 40, height: 40,
            decoration: const BoxDecoration(color: AppTheme.primaryGold, shape: BoxShape.circle),
            child: const Center(child: Text('A', style: TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.w700))),
          ),
        ],
      ),
    );
  }
}