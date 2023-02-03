import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

@freezed
class ActivityModel with _$ActivityModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ActivityModel(
      {required int id,
      required String title,
      required String description,
      required String start,
      required bool isRegister,
      required int numberAttendees}) = _ActivityModel;

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);
}
