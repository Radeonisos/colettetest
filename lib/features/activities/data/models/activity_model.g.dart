// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ActivityModel _$$_ActivityModelFromJson(Map<String, dynamic> json) =>
    _$_ActivityModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      start: json['start'] as String,
      isRegister: json['is_register'] as bool,
      numberAttendees: json['number_attendees'] as int,
    );

Map<String, dynamic> _$$_ActivityModelToJson(_$_ActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'start': instance.start,
      'is_register': instance.isRegister,
      'number_attendees': instance.numberAttendees,
    };
