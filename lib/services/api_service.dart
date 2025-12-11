import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env.dart';
import 'oauth_service.dart';
import '../models/user_model.dart';
import '../models/skill_model.dart';
import '../models/project_model.dart';

class UserData {
  final UserModel user;
  final List<SkillModel> skills;
  final List<ProjectModel> project;

  UserData({
    required this.user,
    required this.skills,
    required this.project,
  });
}

class ApiService {
  ApiService._internal();
  static final ApiService instance = ApiService._internal();

  Future<UserModel?> getUser(String login) async {
    final token = await OAuthService.instance.getAccessToken();
    final String baseUrl = Env.baseUrl;
    if (token == null) return null;
    final url = Uri.parse('$baseUrl/users/$login');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final user = UserModel.fromJson(data);
      return user;
    } else {
      print('Error while getting User: ${response.statusCode}');
      return null;
    }
  }
}
