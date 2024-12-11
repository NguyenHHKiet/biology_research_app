class ConservationStatus {
  final String description;
  final String severity;
  final String name;

  ConservationStatus({
    required this.description,
    required this.severity,
    required this.name,
  });

  factory ConservationStatus.fromJson(Map<String, dynamic> json) {
    return ConservationStatus(
      description: json['description'],
      severity: json['severity'],
      name: json['name'],
    );
  }
}
