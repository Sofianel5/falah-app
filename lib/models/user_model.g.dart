// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    pk: json['pk'] as int,
  )
    ..token = json['token'] as String
    ..programs = (json['programs'] as List)
        ?.map((e) =>
            e == null ? null : Program.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'token': instance.token,
      'pk': instance.pk,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'programs': instance.programs?.map((e) => e?.toJson())?.toList(),
    };
