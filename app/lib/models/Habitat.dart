class Habitat {
  final int id;
  final String name;
  final String description;
  final String climate;
  final int temperature;
  final int humidity;

  Habitat({
    required this.id,
    required this.name,
    required this.description,
    required this.climate,
    required this.temperature,
    required this.humidity,
  });

  factory Habitat.fromJson(Map<String, dynamic> json) {
    return Habitat(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      climate: json['climate'],
      temperature: json['temperature'],
      humidity: json['humidity'],
    );
  }
}
