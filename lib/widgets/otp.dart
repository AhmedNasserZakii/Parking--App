// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../widgets/text_form_field.dart';

class OTP extends StatefulWidget {
  OTP({
    super.key,
    required this.formKey,
    required this.dataAnswerd,
  });

  final GlobalKey<FormState> formKey;
  void Function({
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
    required String answer5,
  }) dataAnswerd;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  String firstAnswer = '';

  String secAnswer = '';

  String thirdAnswer = '';

  String forthAnswer = '';

  String fifthAnswer = '';
  void submitData() {
    widget.dataAnswerd(
      answer1: firstAnswer,
      answer2: secAnswer,
      answer3: thirdAnswer,
      answer4: forthAnswer,
      answer5: fifthAnswer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormFieldOTP(
            first: true,
            last: false,
            onSaved: (value) {
              firstAnswer = value!;
            },
          ),
          TextFormFieldOTP(
            first: false,
            last: false,
            onSaved: (value) {
              secAnswer = value!;
            },
          ),
          TextFormFieldOTP(
            first: false,
            last: false,
            onSaved: (value) {
              thirdAnswer = value!;
            },
          ),
          TextFormFieldOTP(
            first: false,
            last: false,
            onSaved: (value) {
              forthAnswer = value!;
            },
          ),
          TextFormFieldOTP(
            first: false,
            last: true,
            onSaved: (value) {
              fifthAnswer = value!;
              submitData();
            },
          ),
        ],
      ),
    );
  }
}
