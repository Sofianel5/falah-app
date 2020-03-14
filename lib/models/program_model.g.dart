// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Program _$ProgramFromJson(Map<String, dynamic> json) {
  return Program(
    img: json['img'] as String,
    id: json['id'] as int,
    type: json['type'] as String,
    primarySubject: json['primary_subject'] as String,
    secondarySubject: json['secondary_subject'] as String,
    sessions: (json['sessions'] as List)
        ?.map((e) =>
            e == null ? null : Session.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    description: json['description'] as String,
    venue: json['venue'] == null
        ? null
        : Venue.fromJson(json['venue'] as Map<String, dynamic>),
    name: json['name'] as String,
    active: json['active'] as bool,
    full: json['full'] as bool,
    creator: json['creator'] == null
        ? null
        : User.fromJson(json['creator'] as Map<String, dynamic>),
    tags: json['tags'] as String,
    maxAttendees: json['max_attendees'] as int,
    userIsRegistered: json['userIsRegistered'] as bool,
    createdBySelf: json['createdBySelf'] as bool,
  );
}

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
      'active': instance.active,
      'creator': instance.creator?.toJson(),
      'full': instance.full,
      'img': instance.img,
      'id': instance.id,
      'max_attendees': instance.maxAttendees,
      'description': instance.description,
      'primary_subject': instance.primarySubject,
      'secondary_subject': instance.secondarySubject,
      'sessions': instance.sessions?.map((e) => e?.toJson())?.toList(),
      'name': instance.name,
      'createdBySelf': instance.createdBySelf,
      'userIsRegistered': instance.userIsRegistered,
      'tags': instance.tags,
      'type': instance.type,
      'venue': instance.venue?.toJson(),
    };
