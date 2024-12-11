import 'Kingdom.dart';

class Phylum {
  final String name;
  final Kingdom kingdom;

  Phylum({required this.name, required this.kingdom});

  factory Phylum.fromJson(Map<String, dynamic> json) {
    return Phylum(
      name: json['name'],
      kingdom: Kingdom.fromJson(json['kingdom']),
    );
  }
}
