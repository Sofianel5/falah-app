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
    country: json['country'] as String,
    verboseName: json['verboseName'] as String,
    valueName: json['valueName'] as String,
  );
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'coordinates': instance.coordinates?.toJson(),
      'country': instance.country,
      'valueName': instance.valueName,
      'verboseName': instance.verboseName,
    };
