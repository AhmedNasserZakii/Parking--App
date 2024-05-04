import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key, required this.timerCount});

  final void Function(int timer) timerCount;
  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  int _countdown = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
        widget.timerCount(_countdown);
      } else {
        _timer.cancel();
        // Countdown completed, you can add your logic here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      ' $_countdown seconds',
      style: GoogleFonts.getFont('Lato', fontSize: 16.sp, color: Colors.black),
    );
  }
}
