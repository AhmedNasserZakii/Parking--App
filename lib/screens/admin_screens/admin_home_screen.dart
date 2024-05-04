import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/const.dart';
import '../../provider/user_logged_in.dart';
import '../../widgets/admin_park.dart';
import '../../widgets/all_users.dart';
import '../login_screen.dart';

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  ConsumerState<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen> {
  List<Widget> tabList = const [
    ListAllUsers(),
    AdminPark(),
  ];
  Widget content = Center(
    child: Text(
      textAlign: TextAlign.center,
      'What You Want ? \n Pick one !',
      style: latoStyle.copyWith(fontSize: 24.sp, fontWeight: FontWeight.bold),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const LoginScreen()));
                ref.read(userLoggedIn.notifier).logout();
              },
              icon: const Icon(
                Icons.logout,
                color: kMainColor,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 370.w,
                height: 150.h,
                child: Image.asset(
                  kCarsLogo,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        content = tabList[0];
                      });
                    },
                    icon: Icon(
                      Icons.person_outline,
                      size: 25.h,
                      color: Colors.grey,
                    ),
                    label: Text(
                      'users',
                      style: latoStyle.copyWith(fontSize: 25.sp),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        content = tabList[1];
                      });
                    },
                    icon: Icon(
                      Icons.map_sharp,
                      size: 25.h,
                      color: Colors.grey,
                    ),
                    label: Text(
                      'park',
                      style: latoStyle.copyWith(fontSize: 25.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              SizedBox(
                height: 400.h,
                child: content,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
