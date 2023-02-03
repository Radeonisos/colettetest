import '../dataproviders/activities_api.dart';
import '../models/activity_model.dart';

class ActivitesRepository {
  final ActivitiesAPI api = ActivitiesAPI();
  List<ActivityModel> activities = [];
  Future<List<ActivityModel>> getActivities() async {
    activities = [];
    final List<Map<String, Object>> rawActivities =
        await api.getRawActivities();
    for (var e in rawActivities) {
      activities.add(ActivityModel.fromJson(e));
    }
    return activities;
  }

  List<ActivityModel> getMyActivities() {
    return activities.where((element) => element.isRegister).toList();
  }

  List<ActivityModel> getActivitiesInCache() {
    return activities;
  }

  Future<bool> setActivity(int id, bool isMine) async {
    return await api.setMyActivity(id, isMine);
  }
}
