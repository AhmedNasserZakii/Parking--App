// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/all_user_details.dart';
import '../../models/const.dart';
import '../../provider/auth/user_login_provider.dart';
import '../../provider/gat_all_slots_provider.dart';
import '../../provider/get_user_data_provider.dart';
import '../../provider/user_logged_in.dart';
import '../../widgets/elevated_bottom.dart';
import 'payment_falied.dart';
import 'payment_success_screen.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({
    super.key,
    required this.slotCode,
    required this.timeDuration,
  });

  final int slotCode;
  final int timeDuration;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserData userDataInfo = ref.watch(userDataProvider);
    final loginInfo = ref.watch(userLoginInfo);

    int totalUserPoints = userDataInfo.points;

    int totalHours = timeDuration;
    int pointsPerHour = 20;
    int totalPoints = totalHours * pointsPerHour;
    int remainingPoints = totalUserPoints - totalPoints;

    String userId = userDataInfo.id;
    String userToken = '';
    List<SlotData> allSlotsData = ref.watch(allSlotsDataInfo);
    String slotId = ref.read(allSlotsDataInfo.notifier).getSpeceficSlotId(
        allSlots: allSlotsData, slotCode: slotCode.toString());

    Future<void> submitPayment() async {
      final userInfo = ref.watch(userLoginInfo);
      final userInfoLogin = ref.watch(userLoggedIn);
      if (userInfo.token != '' || userInfo.token.trim().isNotEmpty) {
        userToken = userInfo.token;
      } else {
        userToken = userInfoLogin!.token;
      }
      bool updateSlotSuccess = await ref
          .read(allSlotsDataInfo.notifier)
          .updateSlot(
              slotId: slotId, userId: userId, token: userToken, isFree: false);
      bool updatePointsSuccess = await ref
          .read(allSlotsDataInfo.notifier)
          .updateUserPoints(
              token: userToken, userId: userId, points: remainingPoints);
      if (updateSlotSuccess && updatePointsSuccess) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const PaymentSuccessScreeen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const PaymentFailureScreeen(),
          ),
        );
      }
    }

    return FutureBuilder(
      future: ref.read(userDataProvider.notifier).getUserData(userToken),
      builder: (context, snapshot) {
        // if (snapshot.connectionState != ConnectionState.done) {
        //   // Show loading indicator while data is fetching
        //   return const Scaffold(
        //     body: Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   );
        // }
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error Accourd'),
            ),
          );
        } else {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Payment Method',
                  style: latoStyle.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      Card(
                        color: kOtpcolor,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 20.h, right: 20.w, left: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 30,
                              ),
                              TextRow(
                                title1: 'Total Points : ',
                                title2: '$totalUserPoints point',
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 30,
                              ),
                              TextRow(
                                title1: 'Total Hours : ',
                                title2: '$totalHours hour',
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 30,
                              ),
                              TextRow(
                                title1: 'Points / Hour :',
                                title2: '$pointsPerHour points',
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 80.h,
                            width: 5.w,
                            color: kMainColor,
                          ),
                          Container(
                            width: 270.w,
                            height: 80.h,
                            color: kOtpcolor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              child: Column(
                                children: [
                                  TextRow(
                                      title1: 'Total',
                                      title2: '$totalPoints points'),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 70,
                                  ),
                                  TextRow(
                                      title1: 'Remaining ',
                                      title2: '$remainingPoints points'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      ElevatedButtonApp(
                        onPressed: () async {
                          if (remainingPoints < 0) {
                            return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xffF3F6FF),
                                  title: const Text(
                                    'You Dont Have enough points',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Text(
                                    'You Should Charge some points',
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
                          } else {
                            submitPayment();
                          }
                        },
                        label: 'Pay',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class TextRow extends StatelessWidget {
  const TextRow({
    super.key,
    required this.title1,
    required this.title2,
  });

  final String title1;
  final String title2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title1,
          textAlign: TextAlign.start,
          style: latoStyle.copyWith(
            color: kSecTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        Text(
          textAlign: TextAlign.start,
          title2,
          style: latoStyle.copyWith(
            color: kSecTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
