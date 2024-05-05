import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/user_image.dart';
import '../../socketService/socket_service.dart';
import './profile_screen.dart';
import './register_screen.dart';
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

  // String? userPhoneToken;
  @override
  void initState() {
    super.initState();
    _socketService.initializeSocket();

    // setupPushNotifications();
  }

  // void setupPushNotifications() async {
  //   try {
  //     final fcm = FirebaseMessaging.instance;
  //     await fcm.requestPermission();
  //     final token = await fcm.getToken();
  //     userPhoneToken = token;
  //     print('phone token is : $token');
  //     if (token != null) {
  //       sendTokenToServer(token);
  //     }
  //     // Listen to token updates
  //     // FirebaseMessaging.instance.onTokenRefresh.listen(sendTokenToServer);
  //   } catch (e) {
  //     print('Error done $e');
  //   }
  // }

  // Future<void> sendTokenToServer(String token) async {
  //   try {
  //     final loginInfo = ref.watch(userLoginInfo);
  //     final userToken = loginInfo.token;
  //     final userId = loginInfo.id;
  //     await ref.read(allSlotsDataInfo.notifier).putphoneUserToken(
  //         userId: userId, userToken: userToken, userPhoneToken: token);
  //     print("Token sent to server");
  //   } catch (e) {
  //     print('Failed to send token to server $e');
  //   }
  // }

  @override
  void dispose() {
    _socketService.dispose();
    super.dispose();
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
      const RegisterScreen()
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.payment),
            //   label: 'Payment',
            // ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kMainColor,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
