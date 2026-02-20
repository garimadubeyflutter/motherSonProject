import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HourlyChart extends StatelessWidget {
  const HourlyChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> hourlySteps =
    List.generate(24, (index) => Random().nextInt(800));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hourly Steps",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: BarChart(
            BarChartData(
              barGroups: List.generate(24, (index) {
                final steps = hourlySteps[index];
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: steps.toDouble(),
                      color: steps > 200
                          ? Colors.green
                          : Colors.grey,
                      width: 8,
                      borderRadius:
                      BorderRadius.circular(4),
                    )
                  ],
                );
              }),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget:
                        (value, meta) => Text(
                      value.toInt().toString(),
                      style:
                      const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
              borderData:
              FlBorderData(show: false),
              gridData:
              const FlGridData(show: false),
            ),
          ),
        ),
      ],
    );
  }
}
