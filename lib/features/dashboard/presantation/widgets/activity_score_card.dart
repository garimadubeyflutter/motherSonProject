import 'package:flutter/material.dart';

class ActivityScoreCard extends StatelessWidget {
  final int score;
  final String category;
  final String recommendation;

  const ActivityScoreCard({
    super.key,
    required this.score,
    required this.category,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0f2027),
            Color(0xFF203a43),
            Color(0xFF2c5364),
          ],
        ),
        border: Border.all(
          color: Colors.tealAccent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.tealAccent.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Activity Score",
            style: TextStyle(
                color: Colors.white70, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(
            "$score",
            style: const TextStyle(
              fontSize: 48,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$category Activity",
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            recommendation,
            textAlign: TextAlign.center,
            style:
            const TextStyle(color: Colors.white70),
          )
        ],
      ),
    );
  }
}
