import 'package:equatable/equatable.dart';

abstract class ActivityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}



class UpdateCalories extends ActivityEvent {
  final int calories;
  UpdateCalories(this.calories);

  @override
  List<Object?> get props => [calories];
}
class StepsUpdated extends ActivityEvent {
  final int steps;
  StepsUpdated(this.steps);

  @override
  List<Object?> get props => [steps];
}
class UpdateDistance extends ActivityEvent {
  final double distance;
  UpdateDistance(this.distance);

  @override
  List<Object?> get props => [distance];
}

