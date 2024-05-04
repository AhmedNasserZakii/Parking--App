import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/const.dart';

InputDecoration loginDecoration(String label, String hintText) {
  return InputDecoration(
    label: Center(
      child: Text(
        label,
      ),
    ),
    hintText: hintText,
    contentPadding: EdgeInsets.all(13.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(80.w),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: kFormColor,
    floatingLabelBehavior: FloatingLabelBehavior.never,
  );
}

InputDecoration registerDecoration(String label, String hintText) {
  return InputDecoration(
    label: Text(
      label,
      style: const TextStyle(color: Colors.black),
    ),
    hintText: hintText,
    contentPadding: EdgeInsets.all(13.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.w),
      // borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.white,
    // floatingLabelBehavior: FloatingLabelBehavior.never,
  );
}

InputDecoration otpDecoration(String label, String hintText) {
  return InputDecoration(
    label: Text(
      label,
      style: const TextStyle(color: Colors.black),
    ),
    hintText: hintText,
    contentPadding: EdgeInsets.all(13.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.w),
      // borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.white,
    // floatingLabelBehavior: FloatingLabelBehavior.never,
  );
}
