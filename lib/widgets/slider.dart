// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/const.dart';

class TimeSlider extends StatefulWidget {
  TimeSlider({super.key, required this.onTimeSelected});

  void Function(int sliderValue) onTimeSelected;
  @override
  State<TimeSlider> createState() => _SliderState();
}

double sliderValue = 4;

class _SliderState extends State<TimeSlider> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Text(
              'Time Duration : ${sliderValue.round()} Hours',
              style: latoStyle.copyWith(fontSize: 16.sp),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          Slider(
            activeColor: kMainColor,
            value: sliderValue,
            min: 0,
            max: 48,
            divisions: 12,
            label: "${sliderValue.round()} hrs",
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });

              widget.onTimeSelected(value.round());
            },
          ),
        ],
      ),
    );
  }
}
