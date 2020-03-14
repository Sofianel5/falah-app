import 'package:falah/models/user_repository.dart';
import 'package:falah/screens/create_program_description_screen.dart';
import 'package:flutter/material.dart';
import 'package:falah/models/program_model.dart';

class CreateSecondarySubjectScreen extends StatefulWidget {
  CreateSecondarySubjectScreen({this.userRepo, this.jsonData});

  Map<String, dynamic> jsonData;
  UserRepository userRepo;

  @override
  _CreateSecondarySubjectScreenState createState() =>
      _CreateSecondarySubjectScreenState();
}

class _CreateSecondarySubjectScreenState
    extends State<CreateSecondarySubjectScreen> {
  int selectedIndex;
  List<List<String>> subjects;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    subjects = Program.SECONDARY_SUBJECTS[widget.jsonData["primary_subject"]];
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: () {
        if (selectedIndex == null) {
            return;
        }
        var json = widget.jsonData;
        json["secondary_subject"] = subjects[selectedIndex][0];
        print(json);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CreateProgramDescriptionScreen(
            userRepo: widget.userRepo,
            jsonData: json,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: 200,
        child: RaisedButton(
          onPressed: () {
            if (selectedIndex == null) {
            return;
        }
        var json = widget.jsonData;
        json["secondary_subject"] = subjects[selectedIndex][0];
        print(json);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CreateProgramDescriptionScreen(
            userRepo: widget.userRepo,
            jsonData: json,
            ),
          ),
        );
          },
          elevation: 5,
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Theme.of(context).primaryColor,
          child: Text(
            "Next",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectOptions() {
    List<Widget> children = <Widget>[];
    for (var i = 0; i < subjects.length; i++) {
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
            onTap: () => setState(() {
              selectedIndex = i;
            }),
            child: Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border(
                  top: BorderSide(
                      width: 1.0,
                      color: i == selectedIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                  left: BorderSide(
                      width: 1.0,
                      color: i == selectedIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                  right: BorderSide(
                      width: 1.0,
                      color: i == selectedIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                  bottom: BorderSide(
                      width: 1.0,
                      color: i == selectedIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: i == selectedIndex
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey),
                              left: BorderSide(
                                  width: 1.0,
                                  color: i == selectedIndex
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey),
                              right: BorderSide(
                                  width: 1.0,
                                  color: i == selectedIndex
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey),
                              bottom: BorderSide(
                                  width: 1.0,
                                  color: i == selectedIndex
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey),
                            ),
                            color: i == selectedIndex
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      width: 178,
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[Text(subjects[i][1], style: TextStyle(fontWeight: FontWeight.w600),)],
                      ),),
                  Container(
                      width: 60,
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[],
                      ),),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Column(
      children: children,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        alignment: Alignment.center,
        child: FlatButton(
          onPressed: () => Navigator.pop(
              context), //Navigator.push(context, MaterialPageRoute(builder: (_) => PasswordResetScreen(user))),
          child: Text("Back"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                "Create a program",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                "Secondary subject",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _buildSubjectOptions(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 0,
              ),
              child: _buildNextButton(),
            ),
            SizedBox(height: 5.0),
            _buildBackButton(),
          ],
        ),
      ),
    );
  }
}
