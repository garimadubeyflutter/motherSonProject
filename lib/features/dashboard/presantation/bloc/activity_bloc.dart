import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domin/entities/activities.dart';
import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc()
      : super(const ActivityState(
    activity: Activity(steps: 0, calories: 0, distance: 0),
  )) {
    on<StepsUpdated>((event, emit) {
      emit(ActivityState(
        activity: state.activity.copyWith(steps: event.steps),
      ));
    });

    on<UpdateCalories>((event, emit) {
      emit(ActivityState(
        activity: state.activity.copyWith(calories: event.calories),
      ));
    });

    on<UpdateDistance>((event, emit) {
      emit(ActivityState(
        activity: state.activity.copyWith(distance: event.distance),
      ));
    });
  }
}
