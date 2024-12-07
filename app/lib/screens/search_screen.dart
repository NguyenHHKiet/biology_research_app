import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/species_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> _speciesList = [];

  @override
  void initState() {
    super.initState();
    _fetchSpecies();
  }

  Future<void> _fetchSpecies() async {
    try {
      final species = await ApiService.fetchSpecies();
      setState(() {
        _speciesList = species;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch species data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Biology Data')),
      body: _speciesList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SpeciesList(species: _speciesList),
    );
  }
}
