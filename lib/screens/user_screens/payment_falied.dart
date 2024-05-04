import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/const.dart';
import 'home_screen.dart';

class PaymentFailureScreeen extends StatefulWidget {
  const PaymentFailureScreeen({super.key});

  @override
  State<PaymentFailureScreeen> createState() => _PaymentFailureScreeenState();
}

class _PaymentFailureScreeenState extends State<PaymentFailureScreeen> {
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
                  color: Color.fromARGB(255, 248, 74, 62),
                ),
                child: const Icon(
                  Icons.close,
                  size: 85,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Text(
                'Payment \nFailure!',
                style: latoStyle.copyWith(
                    color: Colors.white,
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Text(
                'Please \n Try again later',
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
