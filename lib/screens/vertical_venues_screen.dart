import 'package:falah/models/user_repository.dart';
import 'package:falah/screens/venue_screen.dart';
import 'package:flutter/material.dart';
import 'package:falah/models/venue_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class VerticalVenuesScreen extends StatefulWidget {
  VerticalVenuesScreen({
    this.venues,
    this.userRepo,
  });

  UserRepository userRepo;
  List<Venue> venues;

  @override
  State<StatefulWidget> createState() {
    return _VerticalVenuesScreenState(venues: venues, userRepo: userRepo);
  }
}

class _VerticalVenuesScreenState extends State<VerticalVenuesScreen> {
  _VerticalVenuesScreenState({
    this.venues,
    this.userRepo,
  });

  List<Venue> venues;
  UserRepository userRepo;

  Widget buildList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: venues == null ? 0 : venues.length,
      itemBuilder: (BuildContext context, int index) {
        Venue venue = venues[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VenueScreen(venue: venue, userRepo: userRepo),
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(10.0),
            width: 400.0,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  bottom: 15.0,
                  child: Container(
                    height: 120,
                    width: 400.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('${venue.title}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2)),
                          //SizedBox(height: 10,),
                          //SizedBox(height: 10,),
                          Text(
                              'By ${venue.creator.firstName} ${venue.creator.lastName}',
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
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image(
                            height: 180,
                            width: 400,
                            image: NetworkImage(venue.getImgUrl()),
                            fit: BoxFit.cover,
                          )),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                venue.title +
                                    " | " +
                                    (venue.programs == null
                                        ? "0"
                                        : venue.programs.length.toString()) +
                                    " programs",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
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
                                Text(
                                  venue.city.verboseName,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print("search");
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Venues",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: buildList(context),
          ),
        ],
      ),
    );
  }
}
