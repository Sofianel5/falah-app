import 'package:json_annotation/json_annotation.dart';

part 'coordinates_model.g.dart';
@JsonSerializable(explicitToJson: true)
class Coordinates {
  Coordinates({
    this.lat,
    this.lng,
  });
  factory Coordinates.fromJson(Map<String, dynamic> json) => _$CoordinatesFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
  double lat;
  double lng;
}