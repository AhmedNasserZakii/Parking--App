// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../models/all_user_details.dart';

class UserResetPasswordNotifier extends StateNotifier<Resetpassword> {
  UserResetPasswordNotifier() : super(const Resetpassword(email: ''));

  Future<void> resetPasswordSendVerificationCode(String email) async {
    final url =
        Uri.parse('https://parking-system-3qkl.onrender.com/forgetpassword');
    Map<String, String> emailData = {
      "email": email.toString(),
    };
    await http.post(url, body: emailData);
  }

  Future<void> checkResetPasswordOTP(String email, int otp) async {
    final url = Uri.parse('https://parking-system-3qkl.onrender.com/verifyOTP');
    String jsonBody = jsonEncode({
      "email": email,
      "otp": otp,
      "resetPassword": true,
      // Keep OTP as integer as the API expects
    });
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      throw Exception(json.decode(response.body)['message']);
    } else {}
  }

  Future<void> updateUserpassword(String email, String password) async {
    final url =
        Uri.parse('https://parking-system-3qkl.onrender.com/resetpassword');
    Map<String, String> dataAsjson = {
      "email": email,
      "newPassword": password,
    };
    try {
      final response = await http.post(url, body: dataAsjson);
    } catch (e) {
      throw Exception("print $e");
    }
  }
}

final userResetPassword =
    StateNotifierProvider<UserResetPasswordNotifier, Resetpassword>(
        (ref) => UserResetPasswordNotifier());
