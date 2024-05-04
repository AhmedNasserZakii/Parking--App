import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_core/firebase_core.dart';

import 'provider/gat_all_slots_provider.dart';
import 'provider/get_all_users_provider.dart';
import 'provider/get_user_data_provider.dart';
import 'provider/user_logged_in.dart';
import 'screens/admin_screens/admin_home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/user_screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final loginInfo = ref.watch(userLoginInfo);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Parking App',
          theme: ThemeData(),
          home: const InitializerWidget(),
          // home: Scaffold(body: OTP()),
        );
      },
    );
  }
}

class InitializerWidget extends ConsumerWidget {
  const InitializerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(userLoggedIn.notifier).initializeUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Text(' InitializerWidget  Error: ${snapshot.error}'),
            ),
          );
        }
        final userLogin = ref.watch(userLoggedIn);
        if (userLogin == null) {
          return const LoginScreen();
        } else if (userLogin.isAdmin) {
          ref.read(allUsersDataInfo.notifier).getUserData(userLogin.token);
          ref.read(allSlotsDataInfo.notifier).getAllSlots(userLogin.token);
          return const AdminHomeScreen();
        } else {
          ref.read(userDataProvider.notifier).getUserData(userLogin.token);
          ref.read(allSlotsDataInfo.notifier).getAllSlots(userLogin.token);
          return const HomeScreen();
        }
      },
    );
  }
}
