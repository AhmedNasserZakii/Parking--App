import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/const.dart';
import 'home_screen.dart';

class PaymentSuccessScreeen extends StatefulWidget {
  const PaymentSuccessScreeen({super.key});

  @override
  State<PaymentSuccessScreeen> createState() => _PaymentSuccessScreeenState();
}

class _PaymentSuccessScreeenState extends State<PaymentSuccessScreeen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Container(
                height: 170,
                width: 170,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff2BDC3D),
                ),
                child: const Icon(
                  Icons.check,
                  size: 85,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Text(
                'Payment \nSuccess!',
                style: latoStyle.copyWith(
                    color: Colors.white,
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Text(
                '1 Paking slot \nhas been booked for you',
                textAlign: TextAlign.center,
                style: latoStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
