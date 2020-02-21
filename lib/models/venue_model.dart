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
    this.imgUrl,
    this.programs,
    this.name,
    this.pk,
    this.value,
  });
  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
  Map<String, dynamic> toJson() => _$VenueToJson(this);

  City city;
  Coordinates coordinates;
  String imgUrl;
  String name;
  int pk;
  List<Program> programs;
  String value;
}
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
];