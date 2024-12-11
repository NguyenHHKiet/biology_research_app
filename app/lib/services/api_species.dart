import 'dart:convert';

import 'package:app/models/Species.dart';
import 'package:http/http.dart' as http;

class ApiSpecies {
  static const String apiUrl = 'http://localhost:3000/api/v1/species';

  Future<List<Species>> fetchSpecies() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> speciesJson = jsonData['data'];

      return speciesJson.map((e) => Species.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load species');
    }
  }
}
