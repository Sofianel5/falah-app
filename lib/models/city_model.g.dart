// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    coordinates: json['coordinates'] == null
        ? null
        : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
    country: json['country'] == null
        ? null
        : Country.fromJson(json['country'] as Map<String, dynamic>),
    verboseName: json['verbose_name'] as String,
    name: json['name'] as String,
    id: json['id'] as int,
    img: json['img'] as String,
  )..venues = (json['venues'] as List)
      ?.map((e) => e == null ? null : Venue.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'coordinates': instance.coordinates?.toJson(),
      'country': instance.country?.toJson(),
      'name': instance.name,
      'venues': instance.venues?.map((e) => e?.toJson())?.toList(),
      'verbose_name': instance.verboseName,
      'img': instance.img,
    };
