// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/auth/user_register_provider.dart';
import 'verification_screen.dart';
import '../../widgets/elevated_bottom.dart';
import '../../models/const.dart';
import '../../models/input_decoration.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  // void Function(String email) onEmail;
  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _form = GlobalKey<FormState>();

  var _enteredName = '';
  var _enteredEmail = '';
  var _enteredPhone = '';
  var _enteredPassword = '';
  var _eneteredCarType = '';
  final RegExp regex = RegExp(r'^01[0-2]\d{8}$');

  bool isloading = false;

  void _submit() async {
    setState(() {
      isloading = true;
    });

    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    try {
      await ref.read(userRegisterInfo.notifier).registerUser(
            _enteredName,
            _enteredEmail,
            _enteredPhone,
            _enteredPassword,
            _eneteredCarType,
          );
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => VerificationScreen(
            fromAnyScreen: 'RegisterScreen',
          ),
        ),
      );
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    } finally {
      setState(() {
        isloading = false;
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
              'Register Your Account',
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
                    'Enter your Details to Continue using our App',
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontWeight: FontWeight.w400,
                      fontSize: 22.sp,
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
                      children: [
                        TextFormField(
                          decoration:
                              registerDecoration('Name', 'Your Full Name'),
                          autocorrect: true,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.trim().length < 5) {
                              return 'Please Enter Your Full Name';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _enteredName = newValue!;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 30),
                        TextFormField(
                          decoration:
                              registerDecoration('Email', 'Email Address'),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
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
                            _enteredEmail = newValue!;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 30),
                        TextFormField(
                          decoration:
                              registerDecoration('Mobile No', 'Mobile Number'),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            // if (value == null ||
                            //     value.trim().isEmpty ||
                            //     value.trim().length < 11 ||
                            //     value.trim().length > 11 ||
                            //     !value.contains('010') ||
                            //     !value.contains('011') ||
                            //     !value.contains('012') ||
                            //     !value.contains('015')) {
                            //   return 'Please Enter Valid Phone Number';
                            // }
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            }
                            if (!regex.hasMatch(value)) {
                              return 'Please enter a valid Egyptian phone number';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _enteredPhone = newValue!;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 30),
                        TextFormField(
                          decoration:
                              registerDecoration('Password', 'Password'),
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
                            _enteredPassword = newValue!;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 30),
                        TextFormField(
                          decoration:
                              registerDecoration('Car', 'Your Car Type'),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.trim().length < 4) {
                              return "Please provide a valid car name";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _eneteredCarType = newValue!;
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 30),
                        isloading
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 20.h),
                                child: const CircularProgressIndicator(),
                              )
                            : ElevatedButtonApp(
                                onPressed: _submit,
                                label: 'Register',
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
