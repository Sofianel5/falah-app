import 'package:falah/models/user_repository.dart';
import 'package:falah/screens/venue_screen.dart';
import 'package:falah/screens/vertical_venues_screen.dart';
import 'package:flutter/material.dart';
import 'package:falah/models/venue_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VenueCarousel extends StatelessWidget {
  VenueCarousel({this.venues, this.title, this.userRepo});
  List<Venue> venues;
  String title;
  UserRepository userRepo;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => VerticalVenuesScreen(
                                venues: venues,
                                userRepo: userRepo,
                              ))),
                  child: Text(
                    "See all",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 300.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: venues == null ? 0 : venues.length,
              itemBuilder: (BuildContext context, int index) {
                Venue venue = venues[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => VenueScreen(venue: venue, userRepo: userRepo))),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    width: 210.0,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Positioned(
                          bottom: 15.0,
                          child: Container(
                            height: 120,
                            width: 200.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                      '${venue.programs == null ? 0 : venue.programs.length} programs',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2)),
                                  Text('${venue.title}',
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0)
                              ]),
                          child: Stack(
                            children: <Widget>[
                              Hero(
                                tag: venue.getImgUrl(),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image(
                                      height: 180,
                                      width: 180,
                                      image: NetworkImage(venue.getImgUrl()),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(venue.city.verboseName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                        )),
                                    Row(
                                      children: <Widget>[
                                        Icon(FontAwesomeIcons.locationArrow,
                                            size: 10, color: Colors.white),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(venue.city.country.countryName,
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
