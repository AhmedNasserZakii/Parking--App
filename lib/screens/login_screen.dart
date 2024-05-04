// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/const.dart';

import '../provider/auth/user_login_provider.dart';
import '../provider/gat_all_slots_provider.dart';
import '../provider/get_all_users_provider.dart';
import '../provider/get_user_data_provider.dart';
import '../provider/user_logged_in.dart';
import 'admin_screens/admin_home_screen.dart';
import 'user_screens/forget_password.dart';
import 'user_screens/home_screen.dart';
import 'user_screens/register_screen.dart';
import '../widgets/elevated_bottom.dart';
import '../models/input_decoration.dart';
import 'user_screens/verification_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _form = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  bool isAdmin = false;
  bool isVerified = false;
  bool isLoading = false;
  String userToken = '';

  void _submit() async {
    setState(() {
      isLoading = true;
    });

    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    try {
      await ref.read(userLoginInfo.notifier).login(_email, _password);
      final loginInfo = ref.watch(userLoginInfo);

      isAdmin = loginInfo.isAdmin;
      isVerified = loginInfo.isVerified;
      userToken = loginInfo.token;

      if (isAdmin && isVerified) {
        ref.read(userLoggedIn.notifier).login(_email, userToken, isAdmin);

        ref.read(allUsersDataInfo.notifier).getUserData(userToken);
        ref.read(allSlotsDataInfo.notifier).getAllSlots(userToken);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const AdminHomeScreen(),
          ),
        );
      } else if (!isAdmin && isVerified) {
        ref.read(userLoggedIn.notifier).login(_email, userToken, isAdmin);
        ref.read(userDataProvider.notifier).getUserData(userToken);
        ref.read(allSlotsDataInfo.notifier).getAllSlots(userToken);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const HomeScreen(),
          ),
        );
      } else if (!isAdmin && !isVerified) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => VerificationScreen(
              email: _email,
              fromAnyScreen: 'RegisterScreen',
            ),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Looking for Parking Places?',
              style: GoogleFonts.luckiestGuy(
                fontSize: 22.sp,
                color: kMainColor,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 570.w,
                  height: 250.h,
                  child: Image.asset(
                    kCarsLogo,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Login or Register to your Parking App Account',
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontWeight: FontWeight.w400,
                      fontSize: 24.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 15),
                Form(
                  key: _form,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, bottom: 10.h, right: 160.w),
                          child: Text(
                            'Email & password',
                            style: GoogleFonts.getFont(
                              'Lato',
                              fontSize: 13.sp,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        TextFormField(
                          decoration:
                              loginDecoration('Email Address', 'Email Address'),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.trim().length < 7 ||
                                !value.contains('@') ||
                                !value.contains('.com')) {
                              return 'Please Enter Validate Email Address';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _email = newValue!;
                          },
                        ),
                        SizedBox(height: 20.h),
                        TextFormField(
                          decoration: loginDecoration('Password', 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.trim().length < 4) {
                              return "Please provide a strong Password";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _password = newValue!;
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const ForgetPassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Forget Password',
                            style: GoogleFonts.lato(
                              color: kSecMainColor,
                            ),
                          ),
                        ),
                        isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButtonApp(
                                onPressed: _submit,
                                label: 'Login',
                              ),
                        isLoading
                            ? Container()
                            : Text(
                                'OR',
                                style: GoogleFonts.getFont(
                                  'Lato',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                        isLoading
                            ? Container()
                            : ElevatedButtonApp(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => const RegisterScreen(),
                                    ),
                                  );
                                },
                                label: 'Regesiter',
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
