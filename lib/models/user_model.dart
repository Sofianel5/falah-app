import 'package:falah/api/urls.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:falah/models/program_model.dart';
import 'package:falah/models/venue_model.dart';

import 'city_model.dart';
part 'user_model.g.dart';


@JsonSerializable(explicitToJson: true)
class User {
  User({
    this.email,
    this.firstName,
    this.lastName,
    this.pk,
    this.pfpUrl,
    this.city,
  });

  @JsonKey(name: 'profile_pic')
  String pfpUrl;

  @JsonKey(name: 'active_city')
  City city;


  String getPfpUrl() {
    return pfpUrl;
  }
  String getFullName() {
    return firstName + " " + lastName;
  }
  String token;
  int pk;
  String email;

  @JsonKey(name: 'first_name')
  String firstName;
  List<String> interests = []; //make into getter with api

  @JsonKey(name: 'last_name')
  String lastName;
  List<Program> programs = [];

  List<Venue> venues = [];
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
  String toString() {
    return firstName + " " + lastName;
  }
}