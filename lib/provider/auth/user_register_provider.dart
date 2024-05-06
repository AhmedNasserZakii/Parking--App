import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/all_user_details.dart';

String? userToken;

class UserRegisterInfo extends StateNotifier<RegisterInfo> {
  UserRegisterInfo()
      : super(
          RegisterInfo(
              userName: '', email: '', phone: '', carType: '', password: ''),
        );

  Future<void> registerUser(String name, String emailAdress, String phoneNumber,
      String password, String carType) async {
    final url = Uri.parse('https://parking-system-3qkl.onrender.com/register');
    Map<String, String> dataAsJson = {
      "username": name.toString(),
      "password": password.toString(),
      "mobileNumber": phoneNumber.toString(),
      "carType": carType.toString(),
      "email": emailAdress.toString(),
    };
    final response = await http.post(
      url,
      body: dataAsJson,
    );
    if (response.statusCode == 201) {
      final token = json.decode(response.body)['token'];
      final userId = json.decode(response.body)['id'];
      userToken = token;
      //userToken = token.toString();
      sendVerificationCode(emailAdress, userId);

      saveToken(token);
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
    final enteredData = RegisterInfo(
        email: emailAdress,
        password: password,
        carType: carType,
        userName: name,
        phone: phoneNumber);
    state = enteredData;
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> sendVerificationCode(String email, String userId) async {
    final url = Uri.parse('https://parking-system-3qkl.onrender.com/getOTP');
    Map<String, String> emailAndId = {
      "email": email.toString(),
      "userId": userId.toString(),
    };
    await http.post(url, body: emailAndId);
  }

  Future<void> checkOTP(String email, int otp) async {
    final url = Uri.parse('https://parking-system-3qkl.onrender.com/verifyOTP');
    // Map<String, dynamic> oTP = {
    //   "email": email.toString(),
    //   "otp": otp.toString(),
    // };
    String jsonBody = jsonEncode({
      "email": email,
      "otp": otp, // Keep OTP as integer as the API expects
    });
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonBody,
    );
    if (response.statusCode != 200) {
      print('register provider');
      throw Exception(json.decode(response.body)['message']);
    } else {}
  }

  // Future<void> getUserInfo() async {
  //   final url =
  //       Uri.parse('https://parking-system-3qkl.onrender.com/api/user/me');
  //   final response = await http.get(url, headers: {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization': 'Bearer $userToken'
  //   });
  //   final userJsonData = jsonDecode(response.body);
  //   print('all users info include id ${response.body}');
  // }

  String getuserToken() {
    if (userToken == null) {
      return '';
    } else {
      return userToken!;
    }
  }
}

final userRegisterInfo = StateNotifierProvider<UserRegisterInfo, RegisterInfo>(
    (ref) => UserRegisterInfo());
