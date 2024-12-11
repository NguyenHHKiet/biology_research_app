import 'Order.dart';

class Family {
  final String name;
  final Order order;

  Family({required this.name, required this.order});

  factory Family.fromJson(Map<String, dynamic> json) {
    return Family(
      name: json['name'],
      order: Order.fromJson(json['order']),
    );
  }
}
