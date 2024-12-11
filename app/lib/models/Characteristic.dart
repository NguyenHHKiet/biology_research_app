// model/characteristic.dart
class Characteristic {
  final int id;
  final String type;
  final String value;
  final String units;

  Characteristic({
    required this.id,
    required this.type,
    required this.value,
    required this.units,
  });

  factory Characteristic.fromJson(Map<String, dynamic> json) {
    return Characteristic(
      id: json['id'],
      type: json['characteristic_type'],
      value: json['value'],
      units: json['units'],
    );
  }
}
