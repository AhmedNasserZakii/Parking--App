import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/const.dart';

// ignore: must_be_immutable
class TextFormFieldOTP extends StatelessWidget {
  TextFormFieldOTP({
    super.key,
    required this.first,
    required this.last,
    required this.onSaved,
  });
  bool last;
  bool first;
  void Function(String? value) onSaved;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 45.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: kOtpcolor,
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 25.sp),
        onChanged: (value) {
          if (value.isNotEmpty && last == false) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration:
            const InputDecoration(border: InputBorder.none, hintText: '-'),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onSaved: (newValue) {
          onSaved(newValue);
        },
      ),
    );
  }
}
