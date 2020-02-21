import 'package:json_annotation/json_annotation.dart';
import 'package:falah/models/program_model.dart';
part 'user_model.g.dart';


@JsonSerializable(explicitToJson: true)
class User {
  User({
    this.email,
    this.firstName,
    this.lastName,
    this.pk,
  });
  String token;
  int pk;
  String email;
  String firstName;
  //List<String> interests = []; make into getter with api
  String lastName;
  List<Program> programs= []; 
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
User me = User(email: "sofiane@falah.world", firstName: "Sofiane", lastName: "Larbi");