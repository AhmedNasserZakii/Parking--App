import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/const.dart';
import '../../widgets/elevated_bottom.dart';
import '../../widgets/parking_details_card.dart';
import '../../widgets/slider.dart';
import 'payment_screen.dart';

class ParkingDetailsScreen extends StatelessWidget {
  const ParkingDetailsScreen({super.key, required this.slotIndex});
  final int slotIndex;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    int timeSelected = 0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Parking Detail',
            style: latoStyle.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                kCarsLogo,
                width: 400.w,
                height: 200.h,
                fit: BoxFit.cover,
              ),
              TimeSlider(
                onTimeSelected: (sliderValue) {
                  timeSelected = sliderValue;
                },
              ),
              ParkingDetailsCardScreen(
                slotIndex: slotIndex,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              ElevatedButtonApp(
                  onPressed: () {
                    if (timeSelected == 0) {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: const Color(0xffF3F6FF),
                            title: const Text(
                              'Time is 0 H',
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              'You Should Select Time Duration',
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
                                    style:
                                        latoStyle.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => PaymentScreen(
                            slotCode: slotIndex,
                            timeDuration: timeSelected,
                          ),
                        ),
                      );
                    }
                  },
                  label: 'Confirm & pay'),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
            ],
          ),
        ),
      ),
    );
  }
}
