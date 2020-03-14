import 'dart:convert';

import 'package:falah/api/urls.dart';
import 'package:falah/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'coordinates_model.dart';
import 'city_model.dart';
import 'program_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'venue_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Venue {
  Venue({
    this.coordinates,
    this.city,
    this.img,
    this.programs,
    this.title,
    this.id,
    this.creator,
    this.value,
  });
  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
  Map<String, dynamic> toJson() => _$VenueToJson(this);

  String getImgUrl() {
    return Urls.MEDIA_BASE_URL + img;
  }
  User creator;
  City city;
  Coordinates coordinates;
  String img;
  String title;
  int id;
  List<Program> programs;
  String value;
  String toString() {
    return "creator: " + creator.toString() + "city: " + city.toString() + "\n coordinates: " + coordinates.toString() + "\n title: " + 
    title.toString() + "\n img: " + img + "\n id: " + id.toString() + "\n programs: " + programs.toString() +
    "\n value: " + value;
  }
  static Future<List<Venue>> getVenues(String cityName) async {
    List<Venue> venues = [];
    var response = await http.get(Urls.VENUE_GETTER_URL + "?city=" + cityName);
    var responseJson;
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseJson = json.decode(response.body);
      for (var venue in responseJson) {
        print(Venue.fromJson(venue));
        venues.add(Venue.fromJson(venue));
      }
    }
    return venues;
  }
} 
/*
final List<Venue> venues = [
  Venue(
    coordinates: Coordinates(lat: 40.7721221, lng: -73.9265175),
    city: cities[0],
    pk: 0,
    imgUrl: "https://static01.nyt.com/images/2014/10/27/realestate/20141102-LIVING-slide-33E8/20141102-LIVING-slide-33E8-videoLarge.jpg",
    name: "Astoria Mosque",
    programs: programs,
    value: "astoria_mosque",
  ),
  Venue(
    coordinates: Coordinates(lat: 40.7674376, lng: -73.9204642),
    city: cities[0],
    pk: 1,
    imgUrl: "https://media.timeout.com/images/105517324/630/472/image.jpg",
    name: "CIANA",
    programs: programs,
    value: "ciana",
  ),
];*/