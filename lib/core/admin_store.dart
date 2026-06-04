import 'package:flutter/material.dart';

enum OrderStatus { pending, inProgress, completed, cancelled }

class OrderModel {
  final String id;
  String client;
  String service;
  String address;
  String worker;
  String amount;
  String date;
  OrderStatus status;

  OrderModel({
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

class WorkerModel {
  final String id;
  String name;
  String phone;
  String specialty;
  bool active;

  WorkerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.specialty,
    this.active = true,
  });
}

class AdminStore extends ChangeNotifier {
  AdminStore() {
    _orders = _seedOrders();
    _workers = _seedWorkers();
  }

  late List<OrderModel> _orders;
  late List<WorkerModel> _workers;
  int _orderSeq = 13;

  List<OrderModel> get orders => List.unmodifiable(_orders);

  List<WorkerModel> get workers => List.unmodifiable(_workers);

  int get totalOrders => _orders.length;

  int get activeWorkers => _workers.where((w) => w.active).length;

  int get pendingCount =>
      _orders.where((o) => o.status == OrderStatus.pending).length;

  int get inProgressCount =>
      _orders.where((o) => o.status == OrderStatus.inProgress).length;

  int get completedCount =>
      _orders.where((o) => o.status == OrderStatus.completed).length;

  int get revenueEgp => _orders
      .where((o) => o.status == OrderStatus.completed)
      .fold<int>(0, (sum, o) => sum + _parseAmount(o.amount));

  double get satisfactionScore {
    if (completedCount == 0) return 4.8;
    return 4.5 + (completedCount / totalOrders).clamp(0.0, 0.5);
  }

  List<OrderModel> filteredOrders({OrderStatus? status, String query = ''}) {
    final q = query.trim().toLowerCase();
    return _orders.where((o) {
      final matchStatus = status == null || o.status == status;
      final matchSearch = q.isEmpty ||
          o.client.toLowerCase().contains(q) ||
          o.id.toLowerCase().contains(q) ||
          o.service.toLowerCase().contains(q);
      return matchStatus && matchSearch;
    }).toList();
  }

  List<OrderModel> get recentOrders =>
      List<OrderModel>.from(_orders.take(5));

  void updateOrderStatus(String id, OrderStatus status) {
    final i = _orders.indexWhere((o) => o.id == id);
    if (i == -1) return;
    _orders[i].status = status;
    notifyListeners();
  }

  void assignWorker(String orderId, String workerName) {
    final i = _orders.indexWhere((o) => o.id == orderId);
    if (i == -1) return;
    _orders[i].worker = workerName;
    if (_orders[i].status == OrderStatus.pending) {
      _orders[i].status = OrderStatus.inProgress;
    }
    notifyListeners();
  }

  void addOrderFromBooking({
    required String client,
    required String phone,
    required String service,
    String notes = '',
  }) {
    final id = '#ORD-${_orderSeq.toString().padLeft(3, '0')}';
    _orderSeq++;
    final amount = _priceForService(service);
    _orders.insert(
      0,
      OrderModel(
        id: id,
        client: client,
        service: service,
        address: notes.isEmpty ? 'لم يُحدد — $phone' : notes,
        worker: 'غير معيّن',
        amount: '$amount ج.م',
        date: _todayLabel(),
        status: OrderStatus.pending,
      ),
    );
    notifyListeners();
  }

  void toggleWorkerActive(String id) {
    final i = _workers.indexWhere((w) => w.id == id);
    if (i == -1) return;
    _workers[i].active = !_workers[i].active;
    notifyListeners();
  }

  void addWorker({
    required String name,
    required String phone,
    required String specialty,
  }) {
    final id = 'W-${_workers.length + 1}';
    _workers.add(WorkerModel(
      id: id,
      name: name,
      phone: phone,
      specialty: specialty,
    ));
    notifyListeners();
  }

  static int _parseAmount(String amount) {
    final digits = amount.replaceAll(RegExp(r'[^\d]'), '');
    return int.tryParse(digits) ?? 0;
  }

  static int _priceForService(String service) {
    final s = service.toLowerCase();
    if (s.contains('ملك') || s.contains('royal')) return 4500;
    if (s.contains('فيل') || s.contains('villa') || s.contains('مميز')) {
      return 2400;
    }
    return 1200;
  }

  static String _todayLabel() {
    final n = DateTime.now();
    return '${n.year}-${n.month.toString().padLeft(2, '0')}-${n.day.toString().padLeft(2, '0')}';
  }

  static List<OrderModel> _seedOrders() => [
        OrderModel(
          id: '#ORD-001',
          client: 'أحمد صالح',
          service: 'تنظيف عميق',
          address: 'الشيخ زايد',
          worker: 'محمد حسن',
          amount: '2400 ج.م',
          date: '2026-06-01',
          status: OrderStatus.completed,
        ),
        OrderModel(
          id: '#ORD-002',
          client: 'سارة خالد',
          service: 'باقة أساسية',
          address: 'التجمع الخامس',
          worker: 'غير معيّن',
          amount: '1200 ج.م',
          date: '2026-06-02',
          status: OrderStatus.pending,
        ),
        OrderModel(
          id: '#ORD-003',
          client: 'محمد علي',
          service: 'باقة ملكية',
          address: 'مدينة نصر',
          worker: 'فاطمة عادل',
          amount: '4500 ج.م',
          date: '2026-06-02',
          status: OrderStatus.inProgress,
        ),
        OrderModel(
          id: '#ORD-004',
          client: 'نور حسن',
          service: 'تنظيف فيلا',
          address: 'القاهرة الجديدة',
          worker: 'يوسف إبراهيم',
          amount: '2400 ج.م',
          date: '2026-06-03',
          status: OrderStatus.completed,
        ),
        OrderModel(
          id: '#ORD-005',
          client: 'عمر فاروق',
          service: 'باقة أساسية',
          address: 'المعادي',
          worker: 'غير معيّن',
          amount: '1200 ج.م',
          date: '2026-06-03',
          status: OrderStatus.pending,
        ),
        OrderModel(
          id: '#ORD-006',
          client: 'ليلى محمود',
          service: 'تنظيف مكتب',
          address: 'العباسية',
          worker: 'محمد حسن',
          amount: '2000 ج.م',
          date: '2026-06-03',
          status: OrderStatus.completed,
        ),
        OrderModel(
          id: '#ORD-007',
          client: 'كريم عبد الله',
          service: 'باقة أساسية',
          address: '6 أكتوبر',
          worker: 'غير معيّن',
          amount: '1200 ج.م',
          date: '2026-06-04',
          status: OrderStatus.pending,
        ),
        OrderModel(
          id: '#ORD-008',
          client: 'هند رامي',
          service: 'تنظيف عميق',
          address: 'الزمالك',
          worker: 'فاطمة عادل',
          amount: '2400 ج.م',
          date: '2026-06-04',
          status: OrderStatus.inProgress,
        ),
      ];

  static List<WorkerModel> _seedWorkers() => [
        WorkerModel(
          id: 'W-1',
          name: 'محمد حسن',
          phone: '01001234567',
          specialty: 'تنظيف منازل',
        ),
        WorkerModel(
          id: 'W-2',
          name: 'فاطمة عادل',
          phone: '01009876543',
          specialty: 'تنظيف فيلات',
        ),
        WorkerModel(
          id: 'W-3',
          name: 'يوسف إبراهيم',
          phone: '01005551234',
          specialty: 'تنظيف صناعي',
        ),
        WorkerModel(
          id: 'W-4',
          name: 'مريم سعيد',
          phone: '01007778888',
          specialty: 'تنظيف كمبوندات',
          active: false,
        ),
      ];
}

String orderStatusLabelAr(OrderStatus s) {
  switch (s) {
    case OrderStatus.pending:
      return 'قيد الانتظار';
    case OrderStatus.inProgress:
      return 'جاري التنفيذ';
    case OrderStatus.completed:
      return 'مكتمل';
    case OrderStatus.cancelled:
      return 'ملغي';
  }
}

Color orderStatusColor(OrderStatus s) {
  switch (s) {
    case OrderStatus.pending:
      return const Color(0xFFE67E22);
    case OrderStatus.inProgress:
      return const Color(0xFF4F9CF9);
    case OrderStatus.completed:
      return const Color(0xFF2D8E5B);
    case OrderStatus.cancelled:
      return const Color(0xFFBA1A1A);
  }
}
