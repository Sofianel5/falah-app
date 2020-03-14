import 'package:intl/intl.dart';
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

  @JsonKey(name: 'stop')
  DateTime end;
  DateTime start;
  final formatter = new DateFormat('hh:mm aaa EEEE, LLLL d, y');
  String toString() {
    return "from: " + formatter.format(start) + "\nuntil: " + formatter.format(end);
  }
}