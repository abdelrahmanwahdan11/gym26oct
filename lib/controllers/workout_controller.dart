import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data/repositories/prefs_repository.dart';

class WorkoutController extends GetxController {
  WorkoutController(this.prefs);

  final PrefsRepository prefs;

  double _progress = 0.0;
  int _restSeconds = 30;
  Timer? _timer;

  double get progress => _progress;
  int get restSeconds => _restSeconds;

  @override
  void onInit() {
    super.onInit();
    bootstrap();
  }

  Future<void> bootstrap() async {
    _progress = 0.0;
    _restSeconds = 30;
    update();
  }

  void startSession() {
    _progress = 0.0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _progress += 1 / 60;
      if (_progress >= 1) {
        timer.cancel();
        HapticFeedback.mediumImpact();
      }
      update();
    });
  }

  void pauseSession() {
    _timer?.cancel();
    update();
  }

  void skipAhead() {
    _progress = (_progress + 0.2).clamp(0, 1);
    HapticFeedback.selectionClick();
    update();
  }

  void setRestSeconds(int seconds) {
    _restSeconds = seconds;
    update();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
