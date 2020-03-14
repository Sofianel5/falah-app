import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:falah/api/urls.dart';
import 'package:falah/models/venue_model.dart';

import 'coordinates_model.dart';
import 'country_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'city_model.g.dart';

@JsonSerializable(explicitToJson: true)
class City {
  City({
    this.coordinates,
    this.country,
    this.verboseName,
    this.name,
    this.id,
    this.img,
  });
  int id;
  Coordinates coordinates;
  Country country;
  String name;
  List<Venue> venues;
  @JsonKey(name: 'verbose_name')
  String verboseName;
  String img;
  String getImgUrl() {
    return Urls.MEDIA_BASE_URL + img;
  }
  String toString() {
    return "id: " + id.toString() + "\n coordinates: " + coordinates.toString() + "\n name: " + 
    name.toString() + "\n img: " + img + "\n id: " + id.toString() + "\n country: " + country.toString() +
    "\n verboseName: " + verboseName;
  }
  Future getVenues() async {
    print("getting venues from city");
    var response = await http.get(Urls.VENUE_GETTER_URL);
    var responseJson;
    if (response.statusCode == 200) {
      // Set _user.programs
      responseJson = json.decode(response.body);
      //print(responseJson);
      venues = [];
      for (var venue in responseJson) {
        print(Venue.fromJson(venue));
        if (venues != null) {
          venues.add(Venue.fromJson(venue));
        } else {
          venues = [];
          venues.add(Venue.fromJson(venue));
        }
      }
    }
  }  
  static Future<List<City>> getCities(String countryName) async {
    List<City> cities = [];
    var response = await http.get(Urls.CITY_GETTER_URL + "?countryName=" + countryName);
    var responseJson;
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseJson = json.decode(response.body);
      for (var city in responseJson) {
        print(City.fromJson(city));
        cities.add(City.fromJson(city));
      }
    }
    return cities;
  }
  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}
// Later get this from server
/*final List<City> cities = [
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
];*/