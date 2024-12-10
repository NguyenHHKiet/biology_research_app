import 'package:flutter/material.dart';

class SpeciesList extends StatelessWidget {
  final List<dynamic> species;

  const SpeciesList({super.key, required this.species});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: species.length,
      itemBuilder: (context, index) {
        final speciesItem = species[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            title: Text(
              speciesItem['common_name'] ?? 'Unknown Species',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              speciesItem['scientific_name'] ?? 'Unknown Scientific Name',
            ),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Action khi người dùng nhấn vào một loài (có thể mở chi tiết loài)
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(speciesItem['common_name'] ?? 'Species Details'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Scientific Name: ${speciesItem['scientific_name'] ?? 'N/A'}"),
                      const SizedBox(height: 10),
                      Text("Genus: ${speciesItem['genus']?['name'] ?? 'N/A'}"),
                      const SizedBox(height: 10),
                      Text("Organism Groups: ${_getOrganismGroups(speciesItem)}"),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _getOrganismGroups(dynamic speciesItem) {
    if (speciesItem['organismGroups'] == null ||
        (speciesItem['organismGroups'] as List).isEmpty) {
      return 'N/A';
    }
    return (speciesItem['organismGroups'] as List)
        .map((group) => group['name'])
        .join(', ');
  }
}
