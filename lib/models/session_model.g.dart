// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) {
  return Session(
    start:
        json['start'] == null ? null : DateTime.parse(json['start'] as String),
    end: json['stop'] == null ? null : DateTime.parse(json['stop'] as String),
  );
}

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'stop': instance.end?.toIso8601String(),
      'start': instance.start?.toIso8601String(),
    };
