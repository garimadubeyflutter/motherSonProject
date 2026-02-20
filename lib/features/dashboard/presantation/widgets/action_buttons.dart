import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  Widget _button(
      BuildContext context, String text, String route) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.tealAccent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () => context.push(route),
      child: Text(
        text,
        style: const TextStyle(color: Colors.tealAccent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: [
            _button(context, "Activity Log",
                "/activity-log"),
            _button(context, "Start Activity",
                "/activity-log"),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: [
            _button(context, "Heart Rate",
                "/heart-rate"),
            _button(context, "SpO₂ Level",
                "/spo2"),
          ],
        ),
      ],
    );
  }
}
