import 'Phylum.dart';

class Class {
  final String name;
  final Phylum phylum;

  Class({required this.name, required this.phylum});

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      name: json['name'],
      phylum: Phylum.fromJson(json['phylum']),
    );
  }
}
