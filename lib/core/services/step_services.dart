import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class StepService {
  static const double kmPerStep = 0.0008;
  static const double caloriesPerStep = 0.04;

  Future<bool> requestActivityPermission() async {
    final status = await Permission.activityRecognition.request();
    return status.isGranted;
  }

  Stream<int> get stepStream => Pedometer.stepCountStream
      .map((event) => event.steps)
      .handleError((_) {})
      .distinct();

  Future<int> getLatestStepCount() async {
    try {
      final event = await Pedometer.stepCountStream.first;
      return event.steps;
    } on PlatformException {
      return 0;
    }
  }
}
