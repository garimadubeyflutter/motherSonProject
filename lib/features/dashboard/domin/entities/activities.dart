class Activity {
  final int steps;
  final int calories;
  final double distance;

  const Activity({
    required this.steps,
    required this.calories,
    required this.distance,
  });

  Activity copyWith({
    int? steps,
    int? calories,
    double? distance,
  }) {
    return Activity(
      steps: steps ?? this.steps,
      calories: calories ?? this.calories,
      distance: distance ?? this.distance,
    );
  }
}
