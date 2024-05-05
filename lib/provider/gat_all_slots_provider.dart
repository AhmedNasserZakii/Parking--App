import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

import '../models/all_user_details.dart';

class GetAllSlotsDataNotifier extends StateNotifier<List<SlotData>> {
  GetAllSlotsDataNotifier() : super([]);

  String getSpeceficSlotId(
      {required List<SlotData> allSlots, required String slotCode}) {
    for (var slot in allSlots) {
      if (slot.code == slotCode) {
        print('Your Slot with code $slotCode has ID: ${slot.id}');
        return slot.id;
      }
    }
    print(
        'No slot found with code $slotCode. Returning default ID: nullSlotId');
    return 'nullSlotId'; // Consider using null instead of 'nullSlotId' if appropriate for your logic.
  }

  Future<bool> updateSlot(
      {required String slotId,
      required String? userId,
      required String token,
      required bool isFree}) async {
    var url =
        Uri.parse('https://parking-system-3qkl.onrender.com/api/slot/$slotId');
    try {
      if (isFree == true) {
        userId = null;
      }
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
          {"userId": userId, "isFree": isFree},
        ),
      );
      print('Response from PUT request: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error Occurred when update slote $error');
      return false;
    }
  }

  Future<bool> updateUserPoints(
      {required String token,
      required String userId,
      required int points}) async {
    var url =
        Uri.parse('https://parking-system-3qkl.onrender.com/api/user/$userId');
    try {
      final resposne = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
          <String, dynamic>{"points": points, "payment": true},
        ),
      );

      if (resposne.statusCode == 200) {
        print("Update Successful");
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error Occurred when update slote $error');
      return false;
    }
  }

  Future<void> putphoneUserToken(
      {required String userId,
      required String userToken,
      required String userPhoneToken}) async {
    final url =
        Uri.parse('https://parking-system-3qkl.onrender.com/api/user/$userId');
    try {
      final resposne = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: jsonEncode(
          <String, String>{"FCMtoken": userPhoneToken},
        ),
      );
      if (resposne.statusCode != 200) {
        print('userPhoneToken sent successufly $userPhoneToken');
      }
    } catch (error) {
      throw Exception('$error');
    }
  }

  Future<void> getAllSlots(String token) async {
    final url = Uri.parse('https://parking-system-3qkl.onrender.com/api/slot');

    try {
      //print('we are here ? in get Slot DAta ?');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      //print(' response slot sdata ${response.body}');
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<dynamic> slots = jsonData['data'];
        //const {name , code , id , }=response.body
        List<SlotData> allSlotsData = slots
            .map((dataItem) =>
                SlotData.fromJson(dataItem as Map<String, dynamic>))
            .toList();

        state = allSlotsData;
        String slotId =
            getSpeceficSlotId(allSlots: allSlotsData, slotCode: '2');
        print('your slot id is : $slotId');
        // await updateSlot(
        //     slotId, 'b04f7ec3-9c72-4906-9c7d-b56ac9395f2a', token, false);
        // updateUserPoints(token, 'b04f7ec3-9c72-4906-9c7d-b56ac9395f2a', 500);

        // print(
        //     ' your slotCode is : ${allSlotsData[0].code} ,your Slots Length = ${allSlotsData.length}, your user data is : ${json.decode(response.body)['data'][1]['id']},  and your list : $allSlotsData ');
      } else {
        throw Exception('Faild To load Data : ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error In Getting The Data From Server $e');
    }
  }

  Future<void> sendAlarm(String slotCode) async {
    final url =
        Uri.parse('https://parking-system-3qkl.onrender.com/alertsecurity');

    try {
      final response =
          await http.post(url, body: <String, String>{'slotNumber': slotCode});
      if (response.statusCode == 200) {
        print('send alart done');
      }
    } catch (error) {
      throw Exception('Your send alarm Error is : $error');
    }
  }
}

final allSlotsDataInfo =
    StateNotifierProvider<GetAllSlotsDataNotifier, List<SlotData>>(
  (ref) => GetAllSlotsDataNotifier(),
);
