import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/const.dart';

class DetailsCardRow extends StatelessWidget {
  const DetailsCardRow({
    super.key,
    required this.title,
    required this.icon,
    required this.onTaped,
  });

  final String title;
  final IconData icon;
  final Function() onTaped;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 25.h,
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 250),
        TextButton(
          child: Text(
            title,
            style: latoStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
