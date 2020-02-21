// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Program _$ProgramFromJson(Map<String, dynamic> json) {
  return Program(
    imgUrl: json['imgUrl'] as String,
    pk: json['pk'] as int,
    title: json['title'] as String,
    type: json['type'] as String,
    primarySubject: json['primarySubject'] as String,
    secondarySubject: json['secondarySubject'] as String,
    sessions: (json['sessions'] as List)
        ?.map((e) =>
            e == null ? null : Session.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    description: json['description'] as String,
    venue: json['venue'] == null
        ? null
        : Venue.fromJson(json['venue'] as Map<String, dynamic>),
    active: json['active'] as bool,
    full: json['full'] as bool,
    creator: json['creator'] == null
        ? null
        : User.fromJson(json['creator'] as Map<String, dynamic>),
    tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
      'active': instance.active,
      'creator': instance.creator?.toJson(),
      'full': instance.full,
      'imgUrl': instance.imgUrl,
      'pk': instance.pk,
      'description': instance.description,
      'primarySubject': instance.primarySubject,
      'secondarySubject': instance.secondarySubject,
      'sessions': instance.sessions?.map((e) => e?.toJson())?.toList(),
      'tags': instance.tags,
      'title': instance.title,
      'type': instance.type,
      'venue': instance.venue?.toJson(),
    };
