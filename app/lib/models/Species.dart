import 'ConservationStatus.dart';
import 'Habitat.dart';
import 'taxonomy/Genus.dart';

class Species {
  final int id;
  final String scientificName;
  final String commonName;
  final ConservationStatus? conservationStatus;
  final List<Habitat> habitats;
  final Genus? genus;
  final String? imageUrl;

  Species({
    required this.id,
    required this.scientificName,
    required this.commonName,
    this.conservationStatus,
    required this.habitats,
    this.genus,
    this.imageUrl,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    var habitatsList = (json['habitats'] as List)
        .map((habitatJson) => Habitat.fromJson(habitatJson))
        .toList();
    ConservationStatus? conservationStatus;
    if (json['conservationStatus'] != null) {
      conservationStatus =
          ConservationStatus.fromJson(json['conservationStatus']);
    }
    Genus? genus;
    if (json['genus'] != null) {
      genus = Genus.fromJson(json['genus']);
    }
    return Species(
      id: json['id'],
      scientificName: json['scientific_name'],
      commonName: json['common_name'],
      imageUrl: json['image_url'],
      conservationStatus: conservationStatus,
      habitats: habitatsList,
      genus: genus,
    );
  }
}
