import 'package:falah/models/venue_model.dart';
import 'city_model.dart';
import 'coordinates_model.dart';
import 'session_model.dart';
import 'user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'program_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Program {
  Program({
    this.imgUrl,
    this.pk,
    this.title,
    this.type,
    this.primarySubject,
    this.secondarySubject,
    this.sessions,
    this.description,
    this.venue,
    this.active,
    this.full,
    this.creator,
    this.tags
  });

  bool active;
  User creator;
  bool full;
  String imgUrl;
  int pk;
  String description;
  String primarySubject;
  String secondarySubject;
  List<Session> sessions;
  List<String> tags;
  String title;
  String type;
  Venue venue;
  factory Program.fromJson(Map<String, dynamic> json) => _$ProgramFromJson(json);
  Map<String, dynamic> toJson() => _$ProgramToJson(this);
}
List<Program> programs = [
  Program(
    imgUrl: "https://upload.wikimedia.org/wikipedia/commons/9/9a/Soyuz_TMA-9_launch.jpg",
    title: "Learn rocketry",
    pk: 0,
    type: "recurringClass",
    primarySubject: "science",
    secondarySubject: "physics",
    description: "Learn physics, chemistry, and engineering while making exciting rockets.",
    sessions: [
      Session(start: DateTime(2020, 1, 1, 12), end: DateTime(2020, 1, 1, 15)),
      Session(start: DateTime(2020, 1, 8, 12), end: DateTime(2020, 1, 8, 15))
    ],
    venue: Venue(
      coordinates: Coordinates(lat: 40.7721221, lng: -73.9265175),
      city: cities[0],
      pk: 0,
      imgUrl: "https://static01.nyt.com/images/2014/10/27/realestate/20141102-LIVING-slide-33E8/20141102-LIVING-slide-33E8-videoLarge.jpg",
      name: "Astoria Mosque",
      value: "astoria_mosque",
    ),
    active: true,
    full: false,
    creator: me,
    tags: ["Rocketry", "Physics", "Boom"],
  ),
  Program(
    imgUrl: "https://lonelyplanet-weblinc.netdna-ssl.com/product_images/lonely_planet_us/switzerland-travel-guide-9/browse/5aef97e60409ee2d14d5ca7f/zoom.jpg?c=1525651430",
    title: "Learn German",
    pk: 1,
    type: "recurringClass",
    primarySubject: "foreign_language",
    description: "Learn the German language, read and write like a pro!",
    secondarySubject: "german",
    sessions: [
      Session(start: DateTime(2020, 1, 1, 12), end: DateTime(2020, 1, 1, 15)),
      Session(start: DateTime(2020, 1, 8, 12), end: DateTime(2020, 1, 8, 15))
    ],
    venue: Venue(
      coordinates: Coordinates(lat: 40.7721221, lng: -73.9265175),
      city: cities[0],
      pk: 0,
      imgUrl: "https://static01.nyt.com/images/2014/10/27/realestate/20141102-LIVING-slide-33E8/20141102-LIVING-slide-33E8-videoLarge.jpg",
      name: "Astoria Mosque",
      value: "astoria_mosque",
    ),
    active: true,
    full: false,
    creator: me,
    tags: ["German", "Swizerland", "Schweiz"],
  ),
  Program(
    imgUrl: "https://i.pinimg.com/originals/76/15/06/761506a591ab1053c38262642e365180.png",
    title: "Learn Coding",
    pk: 2,
    type: "recurringClass",
    primarySubject: "science",
    secondarySubject: "computer_science",
    description: "Learn the basics of coding. Learn python, javascript, and swift with us.",
    sessions: [
      Session(start: DateTime(2020, 1, 1, 12), end: DateTime(2020, 1, 1, 15)),
      Session(start: DateTime(2020, 1, 8, 12), end: DateTime(2020, 1, 8, 15))
    ],
    venue: Venue(
      coordinates: Coordinates(lat: 40.7674376, lng: -73.9204642),
      city: cities[0],
      pk: 1,
      imgUrl: "https://media.timeout.com/images/105517324/630/472/image.jpg",
      name: "CIANA",
      value: "ciana",
    ),
    active: true,
    full: false,
    creator: me,
    tags: ["HTML", "CSS", "Flutter"],
  ),
];