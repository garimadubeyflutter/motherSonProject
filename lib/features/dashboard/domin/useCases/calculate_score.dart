import '../entities/activities.dart';

class CalculateScore {
  int call(Activity activity) {
    int score = 0;

    score += (activity.steps / 10000 * 40).clamp(0, 40).toInt();
    score += (activity.calories / 500 * 30).clamp(0, 30).toInt();
    score += (activity.distance / 8 * 30).clamp(0, 30).toInt();

    return score.clamp(0, 100);
  }

  String category(int score) {
    if (score <= 30) return "Low";
    if (score <= 70) return "Moderate";
    return "High";
  }
//mlk;k
  String recommendation(String category) {
    switch (category) {
      case "Low":
        return "Try to move more today.";
      case "Moderate":
        return "Good progress! Push a bit more.";
      case "High":
        return "Excellent work! Take recovery.";
      default:
        return "";
    }
  }
}
