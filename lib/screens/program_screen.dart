import 'package:falah/models/program_model.dart';
import 'package:falah/screens/venue_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:falah/models/user_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ProgramScreen extends StatefulWidget {
  ProgramScreen({this.program, this.userRepo});
  Program program;
  UserRepository userRepo;
  @override
  _ProgramScreenState createState() =>
      _ProgramScreenState(program: program, userRepo: userRepo);
}

class _ProgramScreenState extends State<ProgramScreen> {
  _ProgramScreenState({this.program, this.userRepo});
  Program program;
  UserRepository userRepo;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (program.venue == null) {
      program.getVenue();
    }
    print(userRepo);
  }

  Widget _buildRegisterButton(UserRepository user) {
    var def = GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: RaisedButton(
          onPressed: () async {
            if (!await user.registerForProgram(program)) {
              _key.currentState.showSnackBar(
                SnackBar(
                  content: Text("Something is wrong."),
                ),
              );
            } else {
              _key.currentState.showSnackBar(
                SnackBar(
                  content: Text("Successfully registered."),
                ),
              );
              setState(() {
                program.userIsRegistered = true;
              });
            }
          },
          elevation: 5,
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Theme.of(context).primaryColor,
          child: Text(
            "Register",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
    var full = GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: RaisedButton(
          onPressed: () async {
            _key.currentState.showSnackBar(
              SnackBar(
                content: Text("Cannot register for a full program."),
              ),
            );
          },
          elevation: 5,
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.grey,
          child: Text(
            "Full",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
    var registered = GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: RaisedButton(
          onPressed: () async {
            if (!await user.unregisterForProgram(program)) {
              _key.currentState.showSnackBar(
                SnackBar(
                  content: Text("Something is wrong."),
                ),
              );
            } else {
              _key.currentState.showSnackBar(
                SnackBar(
                  content: Text("Successfully unregistered."),
                ),
              );
              setState(() {
                program.userIsRegistered = false;
              });
            }
          },
          elevation: 5,
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Theme.of(context).primaryColor,
          child: Text(
            "Unregister",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
    if (program.full ?? false) {
      return full;
    } else if (program.userIsRegistered ?? false) {
      return registered;
    } else {
      return def;
    }
  }

  Widget _buildSessionsInfo() {
      var children = <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Sessions", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
          ],
        ),
      ];
      for (var session in program.sessions)
        {
          children.add(Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(session.toString()),
              )
            ],
          ));          
        }
      return Column(children: children,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    )
                  ],
                ),
                child: Hero(
                  tag: widget.program.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image(
                      image: NetworkImage(widget.program.getImgUrl()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        iconSize: 30,
                        color: Colors.black,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: IconButton(
                            icon: Icon(Icons.search),
                            iconSize: 30,
                            color: Colors.black,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VenueScreen(
                            venue: program.venue,
                            userRepo: userRepo,
                          ),
                        ),
                      ),
                      child: Text(
                        widget.program.name +
                            " | " +
                            widget.program.venue.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 15,
                          color: Colors.white70,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          widget.program.venue.city.country.countryName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                bottom: 20,
                child: GestureDetector(
                  onTap: () => MapsLauncher.launchCoordinates(
                      widget.program.venue.coordinates.lat,
                      widget.program.venue.coordinates.lng),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white70,
                    size: 25,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.program.name,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.25,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                child: _buildRegisterButton(widget.userRepo),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  width: 200,
                  child: Text(program.description),
                ),
              ),
            ],
          ),
          _buildSessionsInfo(),
        ],
      ),
    );
  }
}
