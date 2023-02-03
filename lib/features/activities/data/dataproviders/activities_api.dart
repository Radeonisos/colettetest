import 'json/activities_json.dart';

class ActivitiesAPI {
  Future<List<Map<String, Object>>> getRawActivities() async {
    await Future.delayed(const Duration(seconds: 2)); // simulate call api
    final List<Map<String, Object>> rawActivities = activitiesJson;
    return rawActivities;
  }

  Future<bool> setMyActivity(int id, bool isMine) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate call api
    return true;
  }
}
