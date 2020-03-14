// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Venue _$VenueFromJson(Map<String, dynamic> json) {
  return Venue(
    coordinates: json['coordinates'] == null
        ? null
        : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    img: json['img'] as String,
    programs: (json['programs'] as List)
        ?.map((e) =>
            e == null ? null : Program.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    title: json['title'] as String,
    id: json['id'] as int,
    creator: json['creator'] == null
        ? null
        : User.fromJson(json['creator'] as Map<String, dynamic>),
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'creator': instance.creator?.toJson(),
      'city': instance.city?.toJson(),
      'coordinates': instance.coordinates?.toJson(),
      'img': instance.img,
      'title': instance.title,
      'id': instance.id,
      'programs': instance.programs?.map((e) => e?.toJson())?.toList(),
      'value': instance.value,
    };
