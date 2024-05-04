// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/const.dart';
import '../../models/input_decoration.dart';
import '../../provider/auth/user_reset_password.dart';
import '../../widgets/elevated_bottom.dart';
import 'verification_screen.dart';

final _formKey = GlobalKey<FormState>();

class ForgetPassword extends ConsumerWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    String enteredEmail = '';

    void submit() async {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      _formKey.currentState!.save();

      try {
        await ref
            .read(userResetPassword.notifier)
            .resetPasswordSendVerificationCode(enteredEmail);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerificationScreen(
            email: enteredEmail,
            fromAnyScreen: 'ResetScreen',
          ),
        ));
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
                'Forget The Password?',
                style: TextStyle(fontSize: 24.sp),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 19),
              Padding(
                padding: EdgeInsets.only(left: 25.w, right: 25.w),
                child: TextFormField(
                  decoration: registerDecoration('Email', 'Enter your Email'),
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
                    enteredEmail = newValue!;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: ElevatedButtonApp(onPressed: submit, label: 'Send'),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
