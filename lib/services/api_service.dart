import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env.dart';
import 'oauth_service.dart';
import '../models/user_model.dart';

class ApiService {
  ApiService._internal();
  static final ApiService instance = ApiService._internal();
  final String _baseUrl = Env.baseUrl;

  Future<UserModel?> getUser(String login) async {
    final token = await OAuthService.instance.getAccessToken();
    if (token == null) return null;

    final url = Uri.parse('$_baseUrl/users/$login');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } else {
      print('Fehler beim Abrufen des Users: ${response.statusCode}');
      return null;
    }
  }
}
