import 'package:falah/models/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:falah/screens/create_program_primarysubject_screen.dart';
import 'package:falah/screens/create_program_tags_screen.dart';

class CreateProgramDescriptionScreen extends StatefulWidget {
  CreateProgramDescriptionScreen({this.userRepo, this.jsonData});
  UserRepository userRepo;
  Map<String, dynamic> jsonData;
  @override
  _CreateProgramDescriptionScreenState createState() => _CreateProgramDescriptionScreenState();
}

class _CreateProgramDescriptionScreenState extends State<CreateProgramDescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _description = TextEditingController();
  Map _validity;

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _description = TextEditingController(text: "");
    _validity = {
      "program description": true,
    };
  }

  String _validateField(
      dynamic value, String fieldName, TextEditingController controller) {
    bool validity = controller.text != "" && controller.text.length != 0;
    setState(() {
      _validity[fieldName] = validity;
    });
    print("asessing validity of " + fieldName);
    print(validity);
    return validity ? null : "Please provide a valid" + fieldName;
  }

  Widget _buildNextButton() {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: 200,
        child: RaisedButton(
          onPressed: () {
            // VALIDATE FIRST
            if (_description.text == null) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Enter a description')));
              return;
            } else if (_description.text == "" || _description.text.length == 0) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Enter a description')));
              return;
            } else {
              var json = widget.jsonData;
              json["description"] = _description.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateProgramTagsScreen(
                    userRepo: widget.userRepo,
                    jsonData: json,
                  ),
                ),
              );
            }
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
  Widget _buildDescriptionField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 200,
          width: 300,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 10),
                blurRadius: 15,
              ),
            ],
          ),
          child: FormField(
            builder: (FormFieldState<int> state) => TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              controller: _description,
              style: TextStyle(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _validity["program description"]
                            ? Colors.black
                            : Colors.red,
                        width: 1),
                    borderRadius: BorderRadius.circular(10)),
                hintText: "Rocketry Workshop...",
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.create),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 3, 0, 0),
          child: Text(
            _validity["program description"] ? "" : "Enter program name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 10,
            ),
          ),
        ),
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
                "Description",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _buildDescriptionField(),
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
