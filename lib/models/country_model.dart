import 'dart:convert';
import 'package:falah/api/urls.dart';
import 'package:http/http.dart' as http;
import 'coordinates_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'country_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Country {
  Country({
    this.coordinates,
    this.id,
    this.countryCode,
    this.countryName,
    this.img,
  });

  Coordinates coordinates;

  @JsonKey(name: 'country_code')
  String countryCode;
  int id;

  @JsonKey(name: 'country_name')
  String countryName;
  String img;
  String toString() {
    return "id: " + id.toString() + "\n coordinates: " + coordinates.toString() + "\n country_code: " + 
    countryCode.toString() + "\n img: " + img + "\n id: " + id.toString() + "\n countryCode: " + countryCode.toString() +
    "\n countryName: " + countryName;
  }
  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);

  static Future<List<Country>> getCountries() async {
    List<Country> countries = [];
    var response = await http.get(Urls.COUNTRY_GETTER_URL);
    var responseJson;
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseJson = json.decode(response.body);
      for (var country in responseJson) {
        print(Country.fromJson(country));
        countries.add(Country.fromJson(country));
      }
    }
    return countries;
  }
}