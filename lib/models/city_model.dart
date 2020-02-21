import 'coordinates_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'city_model.g.dart';

@JsonSerializable(explicitToJson: true)
class City {
  City({
    this.coordinates,
    this.country,
    this.verboseName,
    this.valueName,
  });

  Coordinates coordinates;
  String country;
  String valueName;
  String verboseName;
  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}
// Later get this from server
final List<City> cities = [
  City(
    coordinates: Coordinates(lat: 40.7413203, lng: -73.9922277),
    country: "USA",
    verboseName: "New York",
    valueName: "nyc",
  ),
  City(
    coordinates: Coordinates(lat: 38.8953399, lng: -77.0517666),
    country: "USA",
    verboseName: "Washington D.C.",
    valueName: "nyc",
  ),
];