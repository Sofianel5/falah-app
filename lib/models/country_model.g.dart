// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    coordinates: json['coordinates'] == null
        ? null
        : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
    id: json['id'] as int,
    countryCode: json['country_code'] as String,
    countryName: json['country_name'] as String,
    img: json['img'] as String,
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'coordinates': instance.coordinates?.toJson(),
      'country_code': instance.countryCode,
      'id': instance.id,
      'country_name': instance.countryName,
      'img': instance.img,
    };
