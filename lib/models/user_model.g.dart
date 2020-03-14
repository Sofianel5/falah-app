// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    pk: json['pk'] as int,
    pfpUrl: json['profile_pic'] as String,
    city: json['active_city'] == null
        ? null
        : City.fromJson(json['active_city'] as Map<String, dynamic>),
  )
    ..token = json['token'] as String
    ..interests = (json['interests'] as List)?.map((e) => e as String)?.toList()
    ..programs = (json['programs'] as List)
        ?.map((e) =>
            e == null ? null : Program.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..venues = (json['venues'] as List)
        ?.map(
            (e) => e == null ? null : Venue.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'profile_pic': instance.pfpUrl,
      'active_city': instance.city?.toJson(),
      'token': instance.token,
      'pk': instance.pk,
      'email': instance.email,
      'first_name': instance.firstName,
      'interests': instance.interests,
      'last_name': instance.lastName,
      'programs': instance.programs?.map((e) => e?.toJson())?.toList(),
      'venues': instance.venues?.map((e) => e?.toJson())?.toList(),
    };
