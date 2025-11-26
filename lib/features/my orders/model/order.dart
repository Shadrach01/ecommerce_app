// ignore_for_file: public_member_api_docs, sort_constructors_first
enum OrderStatus { active, completed, cancelled }

class Order {
  final String orderNumber;
  final int itemCount;
  final double totalAmouunt;
  final OrderStatus status;
  final String imageUrl;
  final DateTime orderDate;

  Order({
    required this.orderNumber,
    required this.itemCount,
    required this.totalAmouunt,
    required this.status,
    required this.imageUrl,
    required this.orderDate,
  });

  String get statusString => status.name;
}
