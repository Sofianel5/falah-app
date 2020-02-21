import 'package:json_annotation/json_annotation.dart';
part 'session_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Session {
  Session({
    this.start,
    this.end,
  });
  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
  DateTime end;
  DateTime start;
}