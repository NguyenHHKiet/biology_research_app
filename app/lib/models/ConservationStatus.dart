// model/conservation_status.dart
class ConservationStatus {
  final int id;
  final String description;

  ConservationStatus({required this.id, required this.description});

  factory ConservationStatus.fromJson(Map<String, dynamic> json) {
    return ConservationStatus(
      id: json['id'],
      description: json['description'],
    );
  }
}
