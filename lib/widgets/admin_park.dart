import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/all_user_details.dart';
import '../models/const.dart';
import '../provider/auth/user_login_provider.dart';
import '../provider/gat_all_slots_provider.dart';

class AdminPark extends ConsumerStatefulWidget {
  const AdminPark({super.key});

  @override
  ConsumerState<AdminPark> createState() => _AdminParkState();
}

class _AdminParkState extends ConsumerState<AdminPark> {
  @override
  Widget build(BuildContext context) {
    final adminInfo = ref.watch(userLoginInfo);
    String adminToken = adminInfo.token;
    List<SlotData> allSlotsData = ref.watch(allSlotsDataInfo);

    return FutureBuilder(
      future: ref.read(allSlotsDataInfo.notifier).getAllSlots(adminToken),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error Accourd '),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 2));
                allSlotsData = ref.watch(allSlotsDataInfo);
              },
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 50.w,
                  childAspectRatio: 1,
                ),
                itemCount: allSlotsData.length,
                itemBuilder: (context, index) {
                  if (!allSlotsData[index].isFree) {
                    return GestureDetector(
                      onTap: () {
                        _showMyDialog(
                            context: context,
                            onTapped: () {
                              ref.read(allSlotsDataInfo.notifier).updateSlot(
                                  slotId: allSlotsData[index].id,
                                  userId: null,
                                  token: adminToken,
                                  isFree: true);
                              Navigator.of(context).pop();
                            });
                      },
                      child: Container(
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
                              fontSize: 26.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F6FF),
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
                            fontSize: 26.sp, fontWeight: FontWeight.w600),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }
}

Future<void> _showMyDialog({
  required BuildContext context,
  required Function() onTapped,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap button to close dialog
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Make It free!'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                  'now you will make it a free slot and anyone can reserve this place again '),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close the dialog
            },
          ),
          TextButton(
            onPressed: onTapped,
            child: const Text('clear'),
          ),
        ],
      );
    },
  );
}
