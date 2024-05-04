import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/all_user_details.dart';

class UserLoggedInNotifier extends StateNotifier<UserLoggedIn?> {
  UserLoggedInNotifier() : super(null);
  Future<void> initializeUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? email = prefs.getString('email');
      final String? token = prefs.getString('token');
      final bool isAdmin = prefs.getBool('isAdmin') ?? false;
      print(
          "SharedPreferences loaded: email=$email, token=$token, isAdmin=$isAdmin");
      if (email != null && token != null) {
        state = UserLoggedIn(email: email, token: token, isAdmin: isAdmin);
        print("User initialized: $state");
      } else {
        print("No saved user data found.");
      }
    } catch (error) {
      print('Error intitalizzion : $error');
      throw error;
    }
  }

  Future<void> login(String email, String token, bool isAdmin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('token', token);
    await prefs.setBool('isAdmin', isAdmin);
    print('Logged in with: $email, Token: $token, Is Admin: $isAdmin');
    state = UserLoggedIn(email: email, token: token, isAdmin: isAdmin);
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('token');
    await prefs.remove('isAdmin');
    state = null;
  }
}

final userLoggedIn = StateNotifierProvider<UserLoggedInNotifier, UserLoggedIn?>(
    (ref) => UserLoggedInNotifier());
