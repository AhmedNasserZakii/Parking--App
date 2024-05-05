// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/const.dart';
import '../../provider/auth/user_login_provider.dart';
import '../../provider/gat_all_slots_provider.dart';
import '../../provider/get_all_users_provider.dart';
import '../../provider/user_logged_in.dart';

class InformationPageScreen extends ConsumerStatefulWidget {
  const InformationPageScreen({
    super.key,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.mobileNumber,
    required this.carType,
    required this.currentPoints,
  });
  final String userId;
  final String userName;
  final String userEmail;
  final String mobileNumber;
  final String carType;
  final int currentPoints;

  @override
  ConsumerState<InformationPageScreen> createState() =>
      _InformationPageScreenState();
}

class _InformationPageScreenState extends ConsumerState<InformationPageScreen> {
  @override
  Widget build(BuildContext context) {
    final adminInfo = ref.watch(userLoginInfo);
    String adminToken = adminInfo.token;
    int userEnteredPoints;
    int totalPoitns = widget.currentPoints;

    // @override
    // void initState() {
    //   super.initState();
    //   ref.read(allUsersDataInfo.notifier).getUserData(adminToken);
    // }

    Future<bool> sumbitAddPoints() async {
      // ref.read(allSlotsDataInfo.notifier).getAllSlots(userLogin.token);
      print('we are in update points admin function ');
      bool isUpdated = await ref
          .read(allSlotsDataInfo.notifier)
          .updateUserPoints(
              token: adminToken, userId: widget.userId, points: totalPoitns);

      if (isUpdated) {
        print('true');
        await ref.read(userLoggedIn.notifier).initializeUser();
        await ref.read(allUsersDataInfo.notifier).getUserData(adminToken);
        return true;
      } else {
        print('false');
        return false;
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainColor,
          title: Text(
            textAlign: TextAlign.center,
            widget.userEmail,
            style: TextStyle(
              color: const Color(0xffD9D9D9),
              fontSize: 20.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 25.h,
            ),
            child: Center(
              child: SizedBox(
                height: 600.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50.h,
                      width: 170.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xffD9D9D9),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff000000).withOpacity(.25),
                              spreadRadius: 0, // Spread radius
                              blurRadius: 4, // Blur radius
                              offset: const Offset(
                                  4, 4), // changes position of shadow
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Information',
                            style: GoogleFonts.lato(
                              fontSize: 20.sp,
                              color: const Color(0xff757897),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Icon(
                            FontAwesomeIcons.newspaper,
                            color: Color(0xff757897),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF3F6FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 28,
                            right: 28.w,
                            top: 12,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'name',
                                        style: GoogleFonts.lato(
                                          color: const Color(0xff677191),
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        widget.userName,
                                        style: GoogleFonts.lato(
                                            color: const Color(0xff192342),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'points',
                                        style: GoogleFonts.lato(
                                          color: const Color(0xff677191),
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        '$totalPoitns \$',
                                        style: GoogleFonts.lato(
                                            color: const Color(0xff192342),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Vehicle Type',
                                        style: GoogleFonts.lato(
                                          color: const Color(0xff677191),
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        'CAR',
                                        style: GoogleFonts.lato(
                                            color: const Color(0xff192342),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Car Type',
                                        style: GoogleFonts.lato(
                                          color: const Color(0xff677191),
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        widget.carType,
                                        style: GoogleFonts.lato(
                                            color: const Color(0xff192342),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'phone Number',
                                        style: GoogleFonts.lato(
                                          color: const Color(0xff677191),
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        widget.mobileNumber,
                                        style: GoogleFonts.lato(
                                            color: const Color(0xff192342),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 40.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    AddPoints(
                      onEnteredPoints: (enteredPoints) {
                        userEnteredPoints = enteredPoints;
                        totalPoitns = userEnteredPoints + widget.currentPoints;
                      },
                      onSumbited: sumbitAddPoints,
                    ),
                    SizedBox(height: 60.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddPoints extends StatefulWidget {
  const AddPoints(
      {super.key, required this.onEnteredPoints, required this.onSumbited});
  final void Function(int enteredPoints) onEnteredPoints;
  final Future<bool> Function() onSumbited;
  @override
  State<AddPoints> createState() => _AddPointsState();
}

class _AddPointsState extends State<AddPoints> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int enteredPoints = 0;
  Future<void> _sumbit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      widget.onEnteredPoints(enteredPoints);
      bool isUpdated = await widget.onSumbited();
      if (isUpdated == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Points added: $enteredPoints'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erorr Points added: $enteredPoints'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: 70.w,
          height: 35.h,
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(), // Border
              filled: true, // Filled background
              fillColor: Color(0xffD9D9D9), // Background color
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey), // Border color when enabled
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kMainColor,
                ), // Border color when focused
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ), // Border color when error
              ),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please Enter a Number';
              }
              if (int.tryParse(value) == null || int.parse(value) <= 0) {
                return 'Please enter a valid positive number';
              }
              return null;
            },
            onSaved: (newValue) {
              setState(() {
                enteredPoints = int.parse(newValue!);
              });
            },
          ),
        ),
        TextButton(
          onPressed: _sumbit,
          child: Text(
            'Add Points',
            style: GoogleFonts.lato(
              color: kMainColor,
              fontSize: 20.sp,
            ),
          ),
        ),
      ]),
    );
  }
}
