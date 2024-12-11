import 'ConservationStatus.dart';
import 'Habitat.dart';

class Species {
  final int id;
  final String scientificName;
  final String commonName;
  final ConservationStatus? conservationStatus;
  final List<Habitat> habitats;

  Species({
    required this.id,
    required this.scientificName,
    required this.commonName,
    this.conservationStatus,
    required this.habitats,
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
    return Species(
      id: json['id'],
      scientificName: json['scientific_name'],
      commonName: json['common_name'],
      conservationStatus: conservationStatus,
      habitats: habitatsList,
    );
  }
}
