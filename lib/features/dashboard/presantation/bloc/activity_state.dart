import 'package:equatable/equatable.dart';

import '../../domin/entities/activities.dart';

class ActivityState extends Equatable {
  final Activity activity;

  const ActivityState({required this.activity});

  @override
  List<Object?> get props => [activity];
}
