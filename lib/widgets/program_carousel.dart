import 'package:falah/models/program_model.dart';
import 'package:falah/models/user_repository.dart';
import 'package:falah/screens/program_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProgramCarousel extends StatelessWidget {
  ProgramCarousel({this.programs, this.title, this.userRepo});
  List<Program> programs;
  String title;
  UserRepository userRepo;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                onTap: () => print("see all"),
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
            itemCount: programs == null ? 0 : programs.length,
            itemBuilder: (BuildContext context, int index) {
              Program program = programs[index];
              return Container(
                margin: EdgeInsets.all(10.0),
                width: 300.0,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProgramScreen(program: program, userRepo: userRepo))),
                                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 15.0,
                        child: Container(
                          height: 120,
                          width: 300.0,
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
                                  '${program.name}',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                //SizedBox(height: 10,),
                                Text(
                                  program.description,
                                  style:
                                      TextStyle(color: Colors.grey, fontSize: 10),
                                ),
                                //SizedBox(height: 10,),
                                Text(
                                    'By ${program.creator.firstName} ${program.creator.lastName}',
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
                                  width: 280,
                                  image: NetworkImage(program.getImgUrl()),
                                  fit: BoxFit.cover,
                                )),
                            Positioned(
                              left: 10,
                              bottom: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(program.venue.title,
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
                                      Text(program.venue.city.verboseName,
                                          style: TextStyle(color: Colors.white)),
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
    );
  }
}
