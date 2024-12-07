import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  static Future<List<dynamic>> fetchSpecies() async {
    final response = await http.get(Uri.parse('$baseUrl/species'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load species');
    }
  }
}
