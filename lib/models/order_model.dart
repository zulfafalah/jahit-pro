enum OrderStatus { proses, selesai, antrean, terlambat }

class OrderModel {
  final String id;
  final String customerName;
  final String itemDescription;
  final OrderStatus status;
  final String deadline;
  final String deadlineLabel;

  const OrderModel({
    required this.id,
    required this.customerName,
    required this.itemDescription,
    required this.status,
    required this.deadline,
    required this.deadlineLabel,
  });
}
