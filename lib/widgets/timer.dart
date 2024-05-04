import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 1;
  final time = '00.00.00'.obs;

  @override
  void onReady() {
    super.onReady();
    _startTimer(5);
  }

  @override
  void onClose() {
    super.onClose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == -1) {
        timer.cancel();
      } else {
        int hours = (remainingSeconds ~/ 3600).toInt();
        int minutes = (remainingSeconds % 3600) ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value =
            '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        remainingSeconds--;
      }
    });
  }
}
