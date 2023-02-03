import 'package:bloc/bloc.dart';
import 'package:colette_test/features/activities/data/repositories/activities_repository.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/activity_model.dart';
import '../models/activities_list.dart';
import '../models/activity_item.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  ActivitiesBloc({required this.activitiesRepository})
      : super(ActivitiesLoading()) {
    on<ActivitiesStarted>(_onStarted);
    on<ActivitiesCached>(_activitiesCached);

    on<ActivitiesMine>(_mineActivities);
    on<SwitchStatusRegister>(_onSwitchStatusRegister);
  }

  final ActivitesRepository activitiesRepository;
  List<ActivityItem> activityItemsCached = [];
  Future<void> _onStarted(
    ActivitiesStarted event,
    Emitter<ActivitiesState> emit,
  ) async {
    emit(ActivitiesLoading());
    try {
      final List<ActivityModel> activitiesMApi =
          await activitiesRepository.getActivities();
      activityItemsCached = formatList(activitiesMApi);
      emit(ActivitiesLoaded(ActivitiesList(activities: activityItemsCached)));
    } catch (_) {
      emit(ActivitiesError());
    }
  }

  Future<void> _activitiesCached(
    ActivitiesCached event,
    Emitter<ActivitiesState> emit,
  ) async {
    emit(ActivitiesLoading());
    try {
      emit(ActivitiesLoaded(ActivitiesList(activities: activityItemsCached)));
    } catch (_) {
      emit(ActivitiesError());
    }
  }

  void _mineActivities(
    ActivitiesMine event,
    Emitter<ActivitiesState> emit,
  ) {
    emit(ActivitiesLoaded(ActivitiesList(
        activities: activityItemsCached
            .where((element) => element.isRegister)
            .toList())));
  }

  Future<void> _onSwitchStatusRegister(
      SwitchStatusRegister event, Emitter<ActivitiesState> emit) async {
    emit(ActivitiesLoading());
    try {
      final bool isSuccess = await activitiesRepository.setActivity(
          event.id, event.isMine); //call api for set value isRegister
      if (isSuccess) {
        ActivityItem activityModel =
            activityItemsCached.firstWhere((element) => element.id == event.id);
        activityModel.isRegister = event.isMine;
        emit(ActivitiesLoaded(ActivitiesList(activities: activityItemsCached)));
      } else {
        emit(ActivitiesError());
      }
    } catch (_) {
      emit(ActivitiesError());
    }
  }

  List<ActivityItem> formatList(List<ActivityModel> activities,
      {bool isMine = false}) {
    List<ActivityItem> activitiesListItem = [];
    for (int i = 0; i < activities.length; i++) {
      ActivityModel activityModel = activities[i];
      if ((activityModel.isRegister && isMine) || !isMine) {
        DateTime dateActivity = DateTime.parse(activityModel.start);
        activitiesListItem.add(ActivityItem(
            activityModel.id,
            activityModel.title,
            activityModel.description,
            dateActivity,
            activityModel.isRegister,
            activityModel.numberAttendees));
      }
    }
    return activitiesListItem;
  }
}
