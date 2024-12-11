// model/species.dart
import 'package:app/models/Characteristic.dart';
import 'package:app/models/ConservationStatus.dart';
import 'package:app/models/Genus.dart';
import 'package:app/models/Habitat.dart';

class Species {
  final int id;
  final String scientificName;
  final String commonName;
  final Genus genus;
  final ConservationStatus? conservationStatus;
  final List<Characteristic> characteristics;
  final List<Habitat> habitats;

  Species({
    required this.id,
    required this.scientificName,
    required this.commonName,
    required this.genus,
    this.conservationStatus,
    required this.characteristics,
    required this.habitats,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      id: json['id'],
      scientificName: json['scientific_name'],
      commonName: json['common_name'],
      genus: Genus.fromJson(json['genus']),
      conservationStatus: json['conservationStatus'] != null
          ? ConservationStatus.fromJson(json['conservationStatus'])
          : null,
      characteristics: (json['characteristics'] as List)
          .map((e) => Characteristic.fromJson(e))
          .toList(),
      habitats:
          (json['habitats'] as List).map((e) => Habitat.fromJson(e)).toList(),
    );
  }
}
