import 'dart:async';
import 'dart:math';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/step_services.dart';
import '../../domin/useCases/calculate_score.dart';
import '../bloc/activity_bloc.dart';
import '../bloc/activity_event.dart';
import '../bloc/activity_state.dart';
import '../widgets/activity_score_card.dart';
import '../widgets/daily_goal_section.dart';
import '../widgets/hourly_chart.dart';
import '../widgets/action_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  int batteryLevel = 0;
  final Battery _battery = Battery();
  StreamSubscription<int>? _stepSubscription;
  final StepService _stepService = StepService();
  int? _initialSensorSteps;
  bool _refreshingSteps = false;

  @override
  void initState() {
    super.initState();
    _loadBattery();
    _startStepTracking();
  }

  Future<void> _startStepTracking() async {
    final hasPermission = await _stepService.requestActivityPermission();
    if (!hasPermission || !mounted) return;

    _stepSubscription = _stepService.stepStream.listen(
      _applySensorSteps,
      onError: (_) {},
    );
  }

  void _applySensorSteps(int sensorSteps) {
    _initialSensorSteps ??= sensorSteps;
    final currentSessionSteps = max(0, sensorSteps - _initialSensorSteps!);
    final distanceKm =
        double.parse((currentSessionSteps * StepService.kmPerStep).toStringAsFixed(2));
    final calories = (currentSessionSteps * StepService.caloriesPerStep).round();

    final activityBloc = context.read<ActivityBloc>();
    activityBloc.add(StepsUpdated(currentSessionSteps));
    activityBloc.add(UpdateDistance(distanceKm));
    activityBloc.add(UpdateCalories(calories));
  }

  Future<void> _refreshStepData() async {
    if (_refreshingSteps) return;
    setState(() {
      _refreshingSteps = true;
    });

    try {
      final sensorSteps = await _stepService.getLatestStepCount();
      if (!mounted) return;
      _applySensorSteps(sensorSteps);
    } finally {
      if (mounted) {
        setState(() {
          _refreshingSteps = false;
        });
      }
    }
  }

  Future<void> _loadBattery() async {
    final level = await _battery.batteryLevel;
    setState(() {
      batteryLevel = level;
    });
  }

  void _changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  @override
  void dispose() {
    _stepSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calculator = CalculateScore();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            final score = calculator(state.activity);
            final category = calculator.category(score);
            final recommendation = calculator.recommendation(category);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "retimer Ring",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Text(
                          "$batteryLevel%",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton.icon(
                      onPressed: _refreshingSteps ? null : _refreshStepData,
                      icon: _refreshingSteps
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.refresh),
                      label: const Text("Refresh Steps"),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Date Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => _changeDate(-1),
                        icon: const Icon(Icons.arrow_left, color: Colors.white),
                      ),
                      Text(
                        DateFormat("EEE, dd MMM yyyy").format(selectedDate),
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () => _changeDate(1),
                        icon: const Icon(Icons.arrow_right, color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Score Card
                  ActivityScoreCard(
                    score: score,
                    category: category,
                    recommendation: recommendation,
                  ),

                  const SizedBox(height: 30),

                  DailyGoalSection(activity: state.activity),

                  const SizedBox(height: 30),

                  const ActionButtons(),

                  const SizedBox(height: 30),

                  const HourlyChart(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
