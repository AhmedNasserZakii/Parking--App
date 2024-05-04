import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/const.dart';

class DataRowInfo extends StatelessWidget {
  const DataRowInfo({
    super.key,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24.w,
        ),
        SizedBox(width: 20.w),
        Text(
          title,
          style: latoStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
