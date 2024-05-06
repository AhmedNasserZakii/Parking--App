import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/all_user_details.dart';
import '../models/const.dart';
import '../provider/auth/user_login_provider.dart';
import '../provider/get_all_users_provider.dart';
import '../provider/user_logged_in.dart';
import '../screens/admin_screens/information_screen.dart';

class ListAllUsers extends ConsumerWidget {
  const ListAllUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<UserData> allUsersData = ref.watch(allUsersDataInfo);
    final adminInfo = ref.watch(userLoginInfo);
    final adminInfoLogin = ref.watch(userLoggedIn);
    String adminToken = '';
    if (adminInfo.token != '' || adminInfo.token.trim().isNotEmpty) {
      adminToken = adminInfo.token;
    } else {
      adminToken = adminInfoLogin!.token;
    }
    return FutureBuilder(
      future: ref.read(allUsersDataInfo.notifier).getUserData(adminToken),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error Accourd '),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: allUsersData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => InformationPageScreen(
                        userId: allUsersData[index].id,
                        userEmail: allUsersData[index].email,
                        userName: allUsersData[index].userName,
                        mobileNumber: allUsersData[index].mobileNumber,
                        carType: allUsersData[index].carType,
                        currentPoints: allUsersData[index].points,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 8.h, left: 20.w, right: 20.w, bottom: 8.h),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kOtpcolor,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: kMainColor.withOpacity(0.5),
                        radius: 20.w,
                        child: Text(
                          '${allUsersData[index].points}',
                          maxLines: 1,
                        ),
                      ),
                      title: Text(
                        allUsersData[index].email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: latoStyle,
                      ),
                      trailing: Text(
                        allUsersData[index].carType,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
