import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/const.dart';

class ElevatedButtonApp extends StatelessWidget {
  const ElevatedButtonApp({
    super.key,
    required this.onPressed,
    required this.label,
  });
  final Function() onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kMainColor,
        minimumSize: Size(300.w, 45.h),
        elevation: 0,
      ),
      child: Text(
        label,
        style: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
