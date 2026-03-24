import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';

// ─── Dashboard Stats ─────────────────────────────────────────────────────────

class DashboardStats {
  final int todayOrders;
  final int lateOrders;
  final int completedOrders;

  const DashboardStats({
    required this.todayOrders,
    required this.lateOrders,
    required this.completedOrders,
  });
}

class DashboardStatsNotifier extends Notifier<DashboardStats> {
  @override
  DashboardStats build() {
    return const DashboardStats(
      todayOrders: 12,
      lateOrders: 3,
      completedOrders: 8,
    );
  }

  void updateStats(DashboardStats stats) {
    state = stats;
  }
}

final dashboardStatsProvider =
    NotifierProvider<DashboardStatsNotifier, DashboardStats>(
  DashboardStatsNotifier.new,
);

// ─── Orders List ─────────────────────────────────────────────────────────────

class OrdersNotifier extends Notifier<List<OrderModel>> {
  @override
  List<OrderModel> build() {
    return const [
      OrderModel(
        id: '1',
        customerName: 'Budi Santoso',
        itemDescription: 'Jas Formal Pria (Custom)',
        status: OrderStatus.proses,
        deadline: 'besok',
        deadlineLabel: 'Deadline: Besok',
      ),
      OrderModel(
        id: '2',
        customerName: 'Siti Aminah',
        itemDescription: 'Kebaya Brokat Modern',
        status: OrderStatus.selesai,
        deadline: 'done',
        deadlineLabel: 'Siap Diambil',
      ),
      OrderModel(
        id: '3',
        customerName: 'Andi Wijaya',
        itemDescription: 'Kemeja Batik Slim-Fit',
        status: OrderStatus.antrean,
        deadline: 'pending',
        deadlineLabel: 'Menunggu Pengukuran',
      ),
    ];
  }

  void addOrder(OrderModel order) {
    state = [...state, order];
  }

  void removeOrder(String id) {
    state = state.where((o) => o.id != id).toList();
  }
}

final ordersProvider = NotifierProvider<OrdersNotifier, List<OrderModel>>(
  OrdersNotifier.new,
);

// ─── Bottom Nav Index ─────────────────────────────────────────────────────────

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
