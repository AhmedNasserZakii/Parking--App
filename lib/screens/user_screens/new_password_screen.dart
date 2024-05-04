// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/const.dart';
import '../../models/input_decoration.dart';
import '../../provider/auth/user_reset_password.dart';
import '../../widgets/elevated_bottom.dart';
import 'home_screen.dart';

final _formKey = GlobalKey<FormState>();

class UpdatePasswordScreen extends ConsumerWidget {
  const UpdatePasswordScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    String enteredPassword = '';

    void submit() async {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      _formKey.currentState!.save();

      try {
        await ref
            .read(userResetPassword.notifier)
            .updateUserpassword(email, enteredPassword);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
      } on Exception catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                kCarsLogo,
                width: 570.w,
                height: 250.h,
                fit: BoxFit.cover,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 19),
              Text(
                'Update Your Password?',
                style: TextStyle(fontSize: 24.sp),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 19),
              Padding(
                padding: EdgeInsets.only(left: 25.w, right: 25.w),
                child: TextFormField(
                  decoration:
                      registerDecoration('Password', 'Enter your password'),
                  autocorrect: false,
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
                    enteredPassword = newValue!;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: ElevatedButtonApp(onPressed: submit, label: 'Update'),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
