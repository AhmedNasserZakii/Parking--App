import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/all_user_details.dart';

class UserLoginNotifier extends StateNotifier<UserLoginInfo> {
  UserLoginNotifier()
      : super(
          UserLoginInfo(
            id: '',
            isAdmin: false,
            token: '',
            isVerified: false,
          ),
        );

  Future<void> login(String email, String password) async {
    final url = Uri.parse('https://parking-system-3qkl.onrender.com/signin');
    Map<String, String> loginbody = {"email": email, "password": password};
    final response = await http.post(url, body: loginbody);
    if (response.statusCode == 200) {
      final userLoginInfo = UserLoginInfo(
        token: json.decode(response.body)['token'],
        id: json.decode(response.body)['id'],
        isAdmin: json.decode(response.body)['isAdmin'],
        isVerified: json.decode(response.body)['isVerified'],
      );
      state = userLoginInfo;
      saveToken(json.decode(response.body)['token']);
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}

final userLoginInfo = StateNotifierProvider<UserLoginNotifier, UserLoginInfo>(
    (ref) => UserLoginNotifier());
