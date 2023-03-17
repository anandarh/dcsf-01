import 'dart:convert';
import 'package:storyapp/models/auth_response.dart';
import 'package:storyapp/utils/api.dart';

class AuthService {
  static Future<AuthResponse> login(String email, String password) async {
    final response =
        await Api.post('login', {'email': email, 'password': password});
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(data);
    } else {
      throw Exception(data['message']);
    }
  }

  static Future<AuthResponse> register(
      String name, String email, String password) async {
    final response = await Api.post(
        'register', {'name': name, 'email': email, 'password': password});
    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return AuthResponse.fromJson(data);
    } else {
      throw Exception(data['message']);
    }
  }
}
