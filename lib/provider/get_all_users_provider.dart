import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/all_user_details.dart';

class GetAllUsersDataNotifier extends StateNotifier<List<UserData>> {
  GetAllUsersDataNotifier() : super([]);

  Future<void> getUserData(String token) async {
    print('i think we didnt come here ?');
    final url = Uri.parse('https://parking-system-3qkl.onrender.com/api/user');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        //  print('we are here ? in get data user ?');
        var jsonData = json.decode(response.body);
        List<dynamic> users = jsonData['data'];
        List<UserData> allUsersData = users
            .map((dataItem) =>
                UserData.fromJson(dataItem as Map<String, dynamic>))
            .toList();

        state = allUsersData;
        // print(
        //     'your user data is : ${json.decode(response.body)['data'][1]['username']},  and your list : $allUsersData ');
      } else {
        throw Exception('Faild To load Data : ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error In Getting The Data From Server $e');
    }
  }
}

final allUsersDataInfo =
    StateNotifierProvider<GetAllUsersDataNotifier, List<UserData>>(
  (ref) => GetAllUsersDataNotifier(),
);
