import 'package:falah/widgets/program_carousel.dart';
import 'package:flutter/material.dart';
import 'package:falah/models/user_repository.dart';
import 'package:provider/provider.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  @override
  Widget build(BuildContext context) {
    final userRepo = Provider.of<UserRepository>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    print("edit");
                  },
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 15)
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: NetworkImage(
                            userRepo.user.pfpUrl),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    print("settings");
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,0,20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(userRepo.user.getFullName(),
                style: TextStyle(fontSize: 25, 
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.25,),)
              ],
            ),
          ),
          ProgramCarousel(
            title: "Upcoming programs",
          ),
          _buildLogoutWidget(userRepo),
        ],
      ),
    );
  }
  void _showLogoutDialog(UserRepository user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Are you sure you want to sign out?"),
          content: new Text("You must be logged back in"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Logout", style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
                user.signOut();
              },
            ),
          ],
        );
      },
    );
  }
  _buildLogoutWidget(UserRepository user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => _showLogoutDialog(user),
          child: Text("Log out"),
        )
      ],
    );
  }
}
