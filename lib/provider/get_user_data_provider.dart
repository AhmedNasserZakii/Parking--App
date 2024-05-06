import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/all_user_details.dart';

class GetUserDataNotifier extends StateNotifier<UserData> {
  GetUserDataNotifier()
      : super(UserData(
          id: '',
          userName: '',
          email: '',
          mobileNumber: '',
          carType: '',
          isAdmin: false,
          isVerified: false,
          points: 0,
          slot: null,
        ));

  Future<void> getUserData(String token) async {
    final url =
        Uri.parse('https://parking-system-3qkl.onrender.com/api/user/me');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final userJsonData = json.decode(response.body)['data'];
        final userData = UserData(
          id: userJsonData['id'],
          userName: userJsonData['username'],
          email: userJsonData['email'],
          mobileNumber: userJsonData['mobileNumber'],
          carType: userJsonData['carType'],
          isAdmin: userJsonData['isAdmin'],
          isVerified: userJsonData['isVerified'],
          points: userJsonData['points'],
          slot: userJsonData['slot'],
        );

        state = userData;
      } else {
        throw Exception(
            'Faild To load Data get user data provider : ${response.reasonPhrase} and user token is: $token');
      }
    } catch (e) {
      print('Error In Getting The Data From Server $e');
    }
  }
}

final userDataProvider = StateNotifierProvider<GetUserDataNotifier, UserData>(
  (ref) => GetUserDataNotifier(),
);
