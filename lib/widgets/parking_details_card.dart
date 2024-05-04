import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/all_user_details.dart';
import '../models/const.dart';
import '../provider/get_user_data_provider.dart';

class ParkingDetailsCardScreen extends ConsumerWidget {
  const ParkingDetailsCardScreen({super.key, required this.slotIndex});
  final int slotIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserData userDataInfo = ref.watch(userDataProvider);
    return SizedBox(
      width: 290.w,
      height: 250.h,
      child: Card(
        //borderOnForeground: false,
        color: const Color(0xffF3F6FF),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VEHICLE TYPE',
                    style: latoStyle.copyWith(
                        color: kSecTextColor, fontSize: 16.sp),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Row(
                    children: [
                      Text(
                        'Car',
                        style: latoStyle.copyWith(
                          color: kTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        userDataInfo.carType,
                        style: latoStyle.copyWith(
                          color: kTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Text(
                    'Parking Slot',
                    style: latoStyle.copyWith(
                        color: kSecTextColor, fontSize: 16.sp),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Row(
                    children: [
                      Text(
                        'Slot',
                        style: latoStyle.copyWith(
                          color: kTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 3),
                      Text(
                        'A0$slotIndex',
                        style: latoStyle.copyWith(
                          color: kTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 50.h,
              color: const Color(0xffE2E9FD),
              child: Row(
                children: [
                  Container(
                    width: 8.h,
                    height: double.infinity,
                    color: kMainColor,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Text(
                          'TOTAL',
                          style: latoStyle.copyWith(
                              color: kSecTextColor, fontSize: 16.sp),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5),
                        Text(
                          'L 10.00',
                          style: latoStyle.copyWith(
                            color: kTextColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
