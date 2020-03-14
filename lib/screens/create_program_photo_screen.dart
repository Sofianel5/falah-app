import 'dart:io';
import 'package:falah/models/user_repository.dart';
import 'package:falah/screens/create_program_venue_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProgramPhotoScreen extends StatefulWidget {
  CreateProgramPhotoScreen({this.userRepo, this.jsonData});
  UserRepository userRepo;
  Map<String, dynamic> jsonData;
  @override
  _CreateProgramPhotoScreenState createState() => _CreateProgramPhotoScreenState();
}

class _CreateProgramPhotoScreenState extends State<CreateProgramPhotoScreen> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

  }


  Widget _buildNextButton() {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: 200,
        child: RaisedButton(
          onPressed: () {
            var json = widget.jsonData;
            json["img"] = _image;
            print(json);
            print("pushing to venue screen");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreateProgramVenueScreen(
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
  Widget _buildImageSelectButton() {
    return FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(_image == null ? Icons.add_a_photo : Icons.switch_camera),
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
                "Photo",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 20.0),
            _image == null
              ? Text('No image selected.')
              : Image.file(_image, height: 100),
              SizedBox(height: 20.0),
            _buildImageSelectButton(),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 0,
              ),
              child: _buildNextButton(),
            ),
            _buildBackButton()
          ],
        ),
      ),
    );
  }
}
