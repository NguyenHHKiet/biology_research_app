// model/genus.dart
class Genus {
  final int id;
  final String name;

  Genus({required this.id, required this.name});

  factory Genus.fromJson(Map<String, dynamic> json) {
    return Genus(
      id: json['id'],
      name: json['name'],
    );
  }
}
