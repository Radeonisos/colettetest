import 'package:equatable/equatable.dart';

import 'activity_item.dart';

class ActivitiesList extends Equatable {
  const ActivitiesList({required this.activities});

  final List<ActivityItem> activities;

  ActivityItem getByPosition(int position) => activities[position];

  ActivityItem getById(int id) =>
      activities.firstWhere((element) => element.id == id);

  @override
  List<Object> get props => [activities];
}
