import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../models/all_user_details.dart';
import '../models/const.dart';
import '../provider/auth/user_login_provider.dart';

import '../provider/gat_all_slots_provider.dart';
import '../provider/user_logged_in.dart';
import '../screens/user_screens/parking_details.dart';
import '../widgets/elevated_bottom.dart';

class Parking extends ConsumerStatefulWidget {
  const Parking({super.key});

  @override
  ConsumerState<Parking> createState() => _ParkingState();
}

class _ParkingState extends ConsumerState<Parking> {
  // List<bool> tappedStates = List.generate(8, (index) => false);
  int? tappedIndex;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(userLoginInfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userLoginInfo);
    final userInfoLogin = ref.watch(userLoggedIn);
    String userToken = '';
    if (userInfo.token != '' || userInfo.token.trim().isNotEmpty) {
      userToken = userInfo.token;
    } else {
      userToken = userInfoLogin!.token;
    }

    List<SlotData> allSlotsData = ref.watch(allSlotsDataInfo);
    return FutureBuilder(
      future: ref.read(allSlotsDataInfo.notifier).getAllSlots(userToken),
      builder: (context, snapshot) {
        // if (!snapshot.hasData) {
        //   return const Scaffold(
        //     body: Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   );
        // }
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error Accourd '),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        mainAxisSpacing: 20.h, // Spacing between rows
                        crossAxisSpacing: 50.w, // Spacing between columns
                        childAspectRatio: 1, // Aspect ratio of each item
                      ),
                      itemCount: allSlotsData.length, // Total number of items
                      itemBuilder: (context, index) {
                        // Builder function for generating each grid item
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              // tappedStates = List.generate(8, (index) => false);
                              // tappedStates[index] = !tappedStates[index];
                              if (tappedIndex ==
                                  int.parse(allSlotsData[index].code)) {
                                // If the same item is tapped again, deselect it
                                tappedIndex = null;
                              } else {
                                // If a different item is tapped, update the tappedIndex
                                if (!allSlotsData[index].isFree) {
                                  tappedIndex = null;
                                } else {
                                  tappedIndex =
                                      int.parse(allSlotsData[index].code);
                                  print('tappedIndex = $tappedIndex');
                                }
                              }
                            });
                          },
                          child: !allSlotsData[index].isFree
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15.h),
                                    border: Border.all(
                                      color: const Color(0xff567DF4),
                                      width: 4,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Slot A  0${allSlotsData[index].code} ',
                                    style: latoStyle.copyWith(
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color:
                                        // tappedStates[index] ? Colors.red : const Color(0xffF3F6FF),
                                        tappedIndex ==
                                                int.parse(
                                                    allSlotsData[index].code)
                                            ? Colors.red
                                            : const Color(0xffF3F6FF),
                                    borderRadius: BorderRadius.circular(15.h),
                                    border: Border.all(
                                      color: const Color(0xff567DF4),
                                      width: 4,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Slot A  0${allSlotsData[index].code} ',
                                    style: latoStyle.copyWith(
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height / 20),
                  ElevatedButtonApp(
                      onPressed: () {
                        if (tappedIndex == null) {
                          return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: const Color(0xffF3F6FF),
                                title: const Text(
                                  'Empty Slot',
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                  'You Should Select a Slot to complete your parking',
                                  textAlign: TextAlign.center,
                                  style: latoStyle.copyWith(fontSize: 18.sp),
                                ),
                                actions: [
                                  Center(
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                kMainColor),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'OK',
                                        style: latoStyle.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ParkingDetailsScreen(
                              slotIndex: tappedIndex!,
                            ),
                          ),
                        );
                      },
                      label: 'Confirm'),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
