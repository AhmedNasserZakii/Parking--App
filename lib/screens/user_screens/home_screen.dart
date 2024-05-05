import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/auth/user_login_provider.dart';
import '../../provider/gat_all_slots_provider.dart';
import '../../provider/get_user_data_provider.dart';
import '../../provider/user_image.dart';
import '../../socketService/socket_service.dart';
import './profile_screen.dart';

import '../../widgets/home_widget.dart';
import '../../widgets/parking.dart';
import '../../models/const.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  final SocketService _socketService = SocketService();

  String? userPhoneToken;
  @override
  void initState() {
    super.initState();
    _socketService.initializeSocket();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });

    setupPushNotifications();
  }

  void setupPushNotifications() async {
    try {
      final fcm = FirebaseMessaging.instance;
      await fcm.requestPermission();
      final token = await fcm.getToken();
      userPhoneToken = token;
      print('phone token is : $token');
      if (token != null) {
        sendTokenToServer(token);
      }
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirmation"),
              content: Text(message.notification?.body ?? ''),
              actions: <Widget>[
                TextButton(
                  child: const Text("Confirm"),
                  onPressed: () {
                    // Perform action on confirmation
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Deny"),
                  onPressed: () {
                    // Perform action on denial
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
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
      print("Token sent to server");
    } catch (e) {
      print('Failed to send token to server $e');
    }
  }

  @override
  void dispose() {
    _socketService.dispose();
    super.dispose();
  }

  void fetchData() {
    ref.watch(userDataProvider);
    ref.watch(allSlotsDataInfo);
  }

  @override
  Widget build(BuildContext context) {
    final imageFile = ref.watch(userImageProvider);
    final List<Widget> widgetOptions = [
      HomeWidget(
        onSelectItem: (selctedIndex) {
          setState(() {
            _selectedIndex = selctedIndex;
          });
        },
      ),
      const Parking(),
    ];
    final items = <Widget>[
      const Icon(
        Icons.home_filled,
        size: 30,
      ),
      const Icon(
        Icons.map,
        size: 30,
      )
    ];
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Color.fromARGB(86, 185, 214, 228).withOpacity(.9),
          appBar: AppBar(
            backgroundColor: kOtpcolor,
            title: Text(
              'Hello',
              style: GoogleFonts.luckiestGuy(
                fontSize: 30.sp,
                color: kMainColor,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 25.w,
                    backgroundColor: const Color.fromARGB(120, 218, 213, 213),
                    foregroundImage:
                        imageFile != null ? FileImage(imageFile) : null,
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: const IconThemeData(color: kSecTextColor)),
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: const Color(0xffF3F6FF),
              buttonBackgroundColor: kFormColor,
              animationDuration: const Duration(milliseconds: 500),
              animationCurve: Curves.bounceOut,
              items: items,
              height: 60,
              index: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          )),
    );
  }
}
// BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.home_filled,
//                 ),
//                 label: 'Home'),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.map),
//               label: 'Map',
//             ),
//             // BottomNavigationBarItem(
//             //   icon: Icon(Icons.payment),
//             //   label: 'Payment',
//             // ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: kMainColor,
         
//         ),