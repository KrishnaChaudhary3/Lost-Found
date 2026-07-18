import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';

class AuthService {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> saveUser({
    required String id,
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', id);
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
  }

  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getString('user_id'),
      'name': prefs.getString('user_name'),
      'email': prefs.getString('user_email'),
    };
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<Map<String, String>> authHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.apiUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await saveToken(data['token']);
        await saveUser(
          id: data['_id'] ?? '',
          name: data['name'] ?? '',
          email: data['email'] ?? '',
        );
        return null;
      } else {
        return data['message'] ?? 'Login failed';
      }
    } catch (e) {
      return 'Could not connect to server: $e';
    }
  }

  static Future<String?> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.apiUrl}/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await saveToken(data['token']);
        await saveUser(
          id: data['_id'] ?? '',
          name: data['name'] ?? name,
          email: data['email'] ?? email,
        );
        return null;
      } else {
        return data['message'] ?? 'Registration failed';
      }
    } catch (e) {
      return 'Could not connect to server: $e';
    }
  }
}

