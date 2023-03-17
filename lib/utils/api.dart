import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const String _baseUrl = 'https://story-api.dicoding.dev/v1/';

  static Future<http.Response> post(
      String endpoint, Map<String, String> body) async {
    return http.post(
      Uri.parse(_baseUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> get(
    String endpoint,
    String token, {
    int? page = 1,
    int? size = 10,
    int? location = 0,
  }) async {
    return await http.get(
      Uri.parse('$_baseUrl$endpoint?page=$page&size=$size&location=$location'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
