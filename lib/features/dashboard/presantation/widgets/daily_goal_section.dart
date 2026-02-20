import 'package:flutter/material.dart';

import '../../domin/entities/activities.dart';

class DailyGoalSection extends StatelessWidget {
  final Activity activity;

  const DailyGoalSection({super.key, required this.activity});

  static const int stepTarget = 10000;
  static const int calorieTarget = 500;
  static const double distanceTarget = 8.0;

  @override
  Widget build(BuildContext context) {
    final double stepPercent = (activity.steps / stepTarget).clamp(0, 1);
    final double caloriePercent =
        (activity.calories / calorieTarget).clamp(0, 1);
    final double distancePercent =
        (activity.distance / distanceTarget).clamp(0, 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Daily Goals",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildRing(
              percent: stepPercent,
              icon: Icons.directions_walk,
              value: "${activity.steps}",
              target: "$stepTarget",
              label: "Steps",
              color: Colors.cyanAccent,
            ),
            _buildRing(
              percent: caloriePercent,
              icon: Icons.local_fire_department,
              value: "${activity.calories} kcal",
              target: "$calorieTarget kcal",
              label: "Calories",
              color: Colors.orangeAccent,
            ),
            _buildRing(
              percent: distancePercent,
              icon: Icons.location_on,
              value: "${activity.distance.toStringAsFixed(2)} km",
              target: "${distanceTarget.toStringAsFixed(1)} km",
              label: "Distance",
              color: Colors.tealAccent,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRing({
    required double percent,
    required IconData icon,
    required String value,
    required String target,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: percent),
          duration: const Duration(milliseconds: 800),
          builder: (context, valueAnim, _) {
            return SizedBox(
              height: 110,
              width: 110,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(
                          color: Colors.white12, width: 4),
                    ),
                  ),

                  SizedBox(
                    height: 110,
                    width: 110,
                    child: CircularProgressIndicator(
                      value: valueAnim,
                      strokeWidth: 6,
                      backgroundColor: Colors.transparent,
                      valueColor:
                      AlwaysStoppedAnimation(color),
                    ),
                  ),

                  Icon(icon, color: color, size: 28),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 15),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
              color: Colors.white60, fontSize: 14),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 110,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: percent,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "$value / $target",
          style: const TextStyle(color: Colors.white54, fontSize: 11),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
