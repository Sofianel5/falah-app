import 'package:falah/models/user_repository.dart';
import 'package:falah/screens/create_program_photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:falah/screens/create_program_primarysubject_screen.dart';

class CreateProgramTagsScreen extends StatefulWidget {
  CreateProgramTagsScreen({this.userRepo, this.jsonData});

  Map<String, dynamic> jsonData;
  UserRepository userRepo;

  @override
  _CreateProgramTagsScreenState createState() =>
      _CreateProgramTagsScreenState();
}

class _CreateProgramTagsScreenState extends State<CreateProgramTagsScreen> {
  TextEditingController _tag = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> _tags = [];
  Map _validity;

  @override
  void dispose() {
    _tag.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tag = TextEditingController(text: "");
    _validity = {
      "program description": true,
    };
  }

  bool _validateTag(String tag) {
    print(tag);
    if (tag == null) {
      return false;
    } else if (tag == "") {
      return false;
    } else if (tag.trim() == "") {
      return false;
    } else {
      return true;
    }
  }

  Widget _buildNextButton(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: 200,
        child: RaisedButton(
          onPressed: () {
            var json = widget.jsonData;
            var csv = "";
            for (var i = 0; i < _tags.length; i++) {
              csv += i != 0 ? ","+ _tags[i].trim() : _tags[i].trim();
            }
            json["tags"] = csv;
            print(json);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreateProgramPhotoScreen(
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

  List<Widget> _makeTheTags() {
    List<Widget> children = <Widget>[];
    for (var i = 0; i < _tags.length; i++) {
      children.add(Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          child: Row(
            children: <Widget>[
              Text(_tags[i]),
              GestureDetector(
                onTap: () {
                  print("called to delete");
                  setState(() {
                    _tags.removeAt(i);
                  });
                  print(_tags);
                },
                child: Container(
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    }
    return children;
  }

  Widget _buildTagsField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 150,
                child: TextField(controller: _tag,),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  print("tapped");
                  if (_validateTag(_tag.text)) {
                    print("validated");
                    setState(() {_tags.add(_tag.text);});
                    _tag.clear();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        width: 60,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Add tag",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Wrap(
            spacing:0.0,
            runSpacing: 0.0,
            children: _makeTheTags(),
          ),
        )
      ],
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
                "Add tags",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _buildTagsField(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 0,
              ),
              child: _buildNextButton(context),
            ),
          ],
        ),
      ),
    );
  }
}
