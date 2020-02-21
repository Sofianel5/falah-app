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
    imgUrl: json['imgUrl'] as String,
    programs: (json['programs'] as List)
        ?.map((e) =>
            e == null ? null : Program.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    name: json['name'] as String,
    pk: json['pk'] as int,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'city': instance.city?.toJson(),
      'coordinates': instance.coordinates?.toJson(),
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'pk': instance.pk,
      'programs': instance.programs?.map((e) => e?.toJson())?.toList(),
      'value': instance.value,
    };
