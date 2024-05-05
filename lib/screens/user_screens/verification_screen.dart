// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/const.dart';
import '../../provider/auth/user_login_provider.dart';
import '../../provider/auth/user_register_provider.dart';
import '../../provider/auth/user_reset_password.dart';
import '../../provider/gat_all_slots_provider.dart';
import '../../widgets/counter_timer.dart';
import '../../widgets/elevated_bottom.dart';
import '../../widgets/otp.dart';
import 'home_screen.dart';
import 'new_password_screen.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  VerificationScreen({super.key, this.email, required this.fromAnyScreen});
  String? email;
  String fromAnyScreen;
  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  final formKey = GlobalKey<FormState>();
  int _timerData = 30;
  String firstAnswer = '';

  String secAnswer = '';

  String thirdAnswer = '';

  String forthAnswer = '';

  String fifthAnswer = '';
  String? userPhoneToken;

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
  }

  void setupPushNotifications() async {
    try {
      final fcm = FirebaseMessaging.instance;
      await fcm.requestPermission();
      final token = await fcm.getToken();
      userPhoneToken = token;
      print('phone token is : $token');

      // Listen to token updates
      // FirebaseMessaging.instance.onTokenRefresh.listen(sendTokenToServer);
    } catch (e) {
      print('Error done $e');
    }
  }

  Future<void> sendTokenToServer(String token) async {
    try {
      final loginInfo = ref.watch(userLoginInfo);
      final userToken = loginInfo.token;
      final userId = loginInfo.id;
      await ref.read(allSlotsDataInfo.notifier).putphoneUserToken(
          userId: userId, userToken: userToken, userPhoneToken: token);
    } catch (e) {
      print('Failed to send token to server $e');
    }
  }

  void submit() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();

    String concatenatedString =
        firstAnswer + secAnswer + thirdAnswer + forthAnswer + fifthAnswer;

    int cominedNumber = int.parse(concatenatedString);
    final emailaccout = ref.watch(userRegisterInfo).email;
    // await ref
    //     .read(userRegisterInfo.notifier)
    //     .checkOTP(emailaccout, cominedNumber);
    try {
      if (widget.fromAnyScreen == 'RegisterScreen') {
        await ref
            .read(userRegisterInfo.notifier)
            .checkOTP(widget.email ?? emailaccout, cominedNumber);
        if (userPhoneToken != null) {
          sendTokenToServer(userPhoneToken!);
          print("Token sent to server");
        } else {
          print('Null token');
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      } else if (widget.fromAnyScreen == 'ResetScreen') {
        await ref
            .read(userResetPassword.notifier)
            .checkResetPasswordOTP(widget.email!, cominedNumber);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => UpdatePasswordScreen(
              email: widget.email!,
            ),
          ),
          (Route<dynamic> route) => false,
        );
      }

      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (ctx) => const HomeScreen(),
      //   ),
      // );
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.only(top: 10.h, bottom: 10.h, left: 5.w, right: 5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  kCarsLogo,
                  width: 570.w,
                  height: 250.h,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 110.w),
                  child: Text(
                    'Enter the \nVerification Code',
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.h, right: 30.w, left: 30.w),
                  child: Text(
                    'Please enter the verification code we sent to your Email ${widget.email ?? ref.watch(userRegisterInfo).email}',
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontSize: 13.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 25.h),
                Padding(
                  padding: EdgeInsets.only(right: 185.w),
                  child: Text(
                    'Verification Code',
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 60),
                OTP(
                  formKey: formKey,
                  dataAnswerd: (
                      {required answer1,
                      required answer2,
                      required answer3,
                      required answer4,
                      required answer5}) {
                    setState(() {
                      firstAnswer = answer1;
                      secAnswer = answer2;
                      thirdAnswer = answer3;
                      forthAnswer = answer4;
                      fifthAnswer = answer5;
                    });
                  },
                ),
                // CountdownTimer(),
                SizedBox(height: MediaQuery.of(context).size.height / 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IgnorePointer(
                      ignoring: _timerData > 0 ? true : false,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Resend code in',
                          style: GoogleFonts.getFont('Lato',
                              fontSize: 16.sp, color: Colors.black),
                        ),
                      ),
                    ),
                    CountdownTimer(
                      timerCount: (timer) {
                        setState(() {
                          _timerData = timer;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButtonApp(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (ctx) => const HomeScreen(),
                    //   ),
                    // );
                    setState(() {
                      submit();
                    });
                  },
                  label: 'Verify',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
