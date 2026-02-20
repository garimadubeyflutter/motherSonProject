import 'dart:async';
import 'package:pedometer/pedometer.dart';

class StepService {
  Stream<int> get stepStream async* {
    await for (StepCount event in Pedometer.stepCountStream) {
      yield event.steps;
    }
  }
}
