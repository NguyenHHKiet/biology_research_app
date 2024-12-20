import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiAuthors {
  Future<void> createAuthor(String name, String affiliation) async {
    final url = Uri.parse('${dotenv.env['API_URL']}/api/v1/authors');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'affiliation': affiliation,
      }),
    );

    if (response.statusCode == 201) {
      print('Author created successfully: ${response.body}');
    } else {
      print('Failed to create author: ${response.body}');
    }
  }
}
