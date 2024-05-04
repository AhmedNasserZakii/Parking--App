// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/card.dart';
import '../models/const.dart';
import '../widgets/elevated_bottom.dart';

import '../widgets/timer.dart';

class HomeWidget extends GetView<TimerController> {
  HomeWidget({super.key, required this.onSelectItem});

  void Function(int selctedIndex) onSelectItem;
  @override
  Widget build(BuildContext context) {
    Get.put(TimerController());

    bool isEmpty = true;
    Widget content = Column(
      children: [
        Center(
          child: SizedBox(
            height: 400.h,
            width: 400.w,
            child: Image.asset(
              'assets/images/Designer.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        const Spacer(),
        ElevatedButtonApp(
            onPressed: () {
              onSelectItem(1);
            },
            label: 'Book Parking'),
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
      ],
    );
    return isEmpty == true
        ? content
        : SingleChildScrollView(
            child: Column(
              children: [
                // CircularTimer(),
                Container(
                  height: 230.h,
                  width: 220.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: kMainColor, width: 5)),
                  child: Obx(
                    () => Center(
                      child: Text(
                        controller.time.value,
                        style: GoogleFonts.getFont('Lato',
                            color: kMainColor,
                            fontSize: 45.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                ),
                const CardInfo(),
              ],
            ),
          );
  }
}
