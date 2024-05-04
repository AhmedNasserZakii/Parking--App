import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provider/user_image.dart';
import '../../provider/user_logged_in.dart';
import '../login_screen.dart';

import '../../provider/get_user_data_provider.dart';
import '../../widgets/account_data_row.dart';
import '../../widgets/elevated_bottom.dart';
import '../../widgets/image_picker.dart';
import '../../models/const.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final imageFile = ref.watch(userImageProvider);
    final userdataInfo = ref.watch(userDataProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Padding(
          padding: EdgeInsets.only(
            top: 90.h,
            bottom: 45.h,
            left: 10.w,
            right: 10.w,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.h),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.w, top: 15.h, right: 20.w, bottom: 15.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.w,
                          backgroundColor:
                              const Color.fromARGB(120, 218, 213, 213),
                          foregroundImage:
                              imageFile != null ? FileImage(imageFile) : null,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 18),
                        Text(
                          'MY ACCOUNT',
                          style: latoStyle.copyWith(
                              fontSize: 13.sp, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 25.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const UserImagePicker(),
                  Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Text(
                      'Profile Photo',
                      style: latoStyle.copyWith(
                          fontSize: 13.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, bottom: 15.h),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.h)),
                      color: kProfileCardColor,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20.w, top: 15.h, right: 20.w, bottom: 15.h),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // DetailsCardRow(
                              //   title: 'Personal Details',
                              //   icon: Icons.person,
                              //   onTaped: () {},
                              // ),
                              // DetailsCardRow(
                              //   title: 'Passwords and Security',
                              //   icon: Icons.settings,
                              //   onTaped: () {},
                              // ),
                              // DetailsCardRow(
                              //   title: 'Payments',
                              //   icon: Icons.payments,
                              //   onTaped: () {},
                              // ),
                              // DetailsCardRow(
                              //   title: 'Your Vehicle',
                              //   icon: Icons.directions_car,
                              //   onTaped: () {},
                              // ),

                              DataRowInfo(
                                icon: Icons.person,
                                title: userdataInfo.userName,
                              ),
                              SizedBox(height: 10.h),
                              DataRowInfo(
                                icon: Icons.directions_car,
                                title: userdataInfo.carType,
                              ),
                              SizedBox(height: 10.h),
                              DataRowInfo(
                                icon: Icons.phone_android_outlined,
                                title: userdataInfo.mobileNumber,
                              ),
                              SizedBox(height: 10.h),
                              DataRowInfo(
                                icon: Icons.payments,
                                title: '${userdataInfo.points} \$',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButtonApp(
                      onPressed: () {
                        ref.read(userLoggedIn.notifier).logout();
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => const LoginScreen(),
                          ),
                        );
                      },
                      label: 'LOGOUT'),
                  SizedBox(height: 30.h)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
