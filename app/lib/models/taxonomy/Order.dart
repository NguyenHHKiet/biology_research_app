import 'Class.dart';

class Order {
  final String name;
  final Class classData;

  Order({required this.name, required this.classData});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      name: json['name'],
      classData: Class.fromJson(json['class']),
    );
  }
}
