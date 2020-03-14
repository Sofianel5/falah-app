import 'dart:convert';

import 'package:falah/api/urls.dart';
import 'package:falah/models/venue_model.dart';
import 'city_model.dart';
import 'coordinates_model.dart';
import 'package:http/http.dart' as http;
import 'session_model.dart';
import 'user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'program_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Program {
  static Future<List<List<String>>> getPrimarySubjects() async {
    var response = await http.get(Urls.PRIMARY_SUBJECTS_GETTER_URL);
    var responseJson;
    if (response.statusCode == 200) {
      // Set _user.programs
      responseJson = json.decode(response.body);
      print(responseJson);
      return responseJson;
    }
    else {
      print(response);
      return Future.delayed(Duration.zero);
    }
  } 
  static Future<List<List<String>>> getSecondarySubjects() async {
    var response = await http.get(Urls.SECONDARY_SUBJECTS_GETTER_URL);
    var responseJson;
    if (response.statusCode == 200) {
      // Set _user.programs
      responseJson = json.decode(response.body);
      print(responseJson);
      return responseJson;
    }
    else {
      print(response);
      return Future.delayed(Duration.zero);
    }
  } 
  Program({
    this.img,
    this.id,
    this.type,
    this.primarySubject,
    this.secondarySubject,
    this.sessions,
    this.description,
    this.venue,
    this.name,
    this.active,
    this.full,
    this.creator,
    this.tags,
    this.maxAttendees,
    this.userIsRegistered,
    this.createdBySelf
  });
  String getImgUrl() {
    return Urls.MEDIA_BASE_URL + img;
  }
  bool active;
  User creator;
  bool full;
  String img;
  int id;
  
  @JsonKey(name: 'max_attendees')
  int maxAttendees;

  String description;

  @JsonKey(name: 'primary_subject')
  String primarySubject;

  @JsonKey(name: 'secondary_subject')
  String secondarySubject;
  List<Session> sessions;
  String name;
  bool createdBySelf;
  bool userIsRegistered;
  String tags;
  String type;
  Venue venue;
  List<String> getTags() {
    return tags.split(" ");
  }
  void getVenue() async {
    print("getting venue for program");
    var response = await http.get(Urls.VENUE_FROM_PROGRAM_GETTER_URL);
    var responseJson;
    if (response.statusCode == 200) {
      // Set _user.programs
      responseJson = json.decode(response.body);
      //print(responseJson);
      print(responseJson);
      venue = Venue.fromJson(responseJson);
    }
  }
  String toString() {
    return "active: " + active.toString() + "\n creator: " + creator.toString() + "\n full: " + 
    full.toString() + "\n img: " + img + "\n id: " + id.toString() + "\n description: " + description +
    "\n primarySubject: " + primarySubject + "\n secondarySubject: " + secondarySubject + "\n sessions: " + sessions.toString() +
    "\n tags: " + tags + "\n type: " + type;
  }
  factory Program.fromJson(Map<String, dynamic> json) => _$ProgramFromJson(json);
  Map<String, dynamic> toJson() => _$ProgramToJson(this);
  static const List<List<String>> PRIMARY_SUBJECTS = [
    [
        "math",
        "Math"
    ],
    [
        "english",
        "English"
    ],
    [
        "foreign_language",
        "Foreign Language"
    ],
    [
        "science",
        "Science"
    ],
    [
        "social_science",
        "Social Science"
    ],
    [
        "political",
        "Political"
    ],
    [
        "skills",
        "Skills"
    ],
    [
        "other",
        "Other"
    ]
  ];
  static const SECONDARY_SUBJECTS = {
    "math": [
      ["elementry", "Elementry School"],
      ["preAlgebra", "Pre Algebra"],
      ["algebra", "Algebra"],
      ["geometry", "Geometry"],
      ["basicApp", "Basic applications"],
      ["preCalculus", "Pre Calculus"],
      ["calculus", "Calculus"],
      ["mcalc", "Multivariable Calculus"],
      ["lalgebra", "Linear Algebra"],
      ["advancedApp", "Advanced applications"],
    ],
    "science": [
      ["astro", "Astrophysics"],
      ["bio", "Biology"],
      ["chem", "Chemistry"],
      ["cs", "Computer Science"],
      ["orgo", "Organic Chemistry"],
      ["physics", "Physics"],
      ["medicine", "Medicine"],
      ["zoology", "Zoology"],
    ],
    "english": [
      ["fiction", "Fiction"],
      ["nonfiction", "Non-fiction"],
      ["poetry", "Poetry"],
    ],
    "foreign_language": [
      ["spanish", "Spanish"],
      ["german", "German"],
      ["french", "French"],
      ["russian", "Russian"],
      ["arabic", "Arabic"],
      ["chinese", "Chinese"],
    ],
    "social_science": [
      ["econ", "Economics"],
      ["polsci", "Political Science"],
      ["sociology", "Sociology"],
      ["psych", "Psychology"],
    ],
    "political": [
      ["voting", "Voting"],
      ["immigration", "Imigration Law"],
      ["taxes", "Taxes"]
    ],
    "skills": [
      ["sports", "Sports"],
      ["woodworking", "Woodworking"],
      ["fishing", "Fishing"],
    ],
    "other": [
      ["other", "Other"]
    ]
  };
}
/*
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
*/