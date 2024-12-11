import 'Family.dart';

class Genus {
  final String name;
  final Family family;

  Genus({required this.name, required this.family});

  factory Genus.fromJson(Map<String, dynamic> json) {
    return Genus(
      name: json['name'],
      family: Family.fromJson(json['family']),
    );
  }
}
