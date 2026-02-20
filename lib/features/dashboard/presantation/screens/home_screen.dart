import 'dart:async';
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
  late StreamSubscription<int> _stepSubscription;
  final StepService _stepService = StepService();

  @override
  void initState() {
    super.initState();
    _loadBattery();
    _stepSubscription =
        _stepService.stepStream.listen((steps) {
          context
              .read<ActivityBloc>()
              .add(StepsUpdated(steps));
        });
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
  Widget build(BuildContext context) {
    final calculator = CalculateScore();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            final score = calculator(state.activity);
            final category = calculator.category(score);
            final recommendation =
            calculator.recommendation(category);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
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
                          style: const TextStyle(
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Date Selector
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => _changeDate(-1),
                        icon: const Icon(Icons.arrow_left,
                            color: Colors.white),
                      ),
                      Text(
                        DateFormat(
                            "EEE, dd MMM yyyy")
                            .format(selectedDate),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () => _changeDate(1),
                        icon: const Icon(Icons.arrow_right,
                            color: Colors.white),
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
