import 'package:falah/models/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:falah/screens/create_program_primarysubject_screen.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen({this.userRepo});
  UserRepository userRepo;
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  Map _validity;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: "");
    _validity = {
      "program name": true,
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
            if (_name.text == null) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Enter a name')));
              return;
            } else if (_name.text == "" || _name.text.length == 0) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Enter a name')));
              return;
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreatePrimarySubjectScreen(
                    userRepo: widget.userRepo,
                    jsonData: {"name": _name.text},
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

  Widget _buildNameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(60, 0, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Name of program",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
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
              keyboardType: TextInputType.text,
              controller: _name,
              style: TextStyle(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: _validity["program name"]
                            ? Colors.black
                            : Colors.red,
                        width: 1),
                    borderRadius: BorderRadius.circular(30)),
                hintText: "Rocketry Workshop",
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.create),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 3, 0, 0),
          child: Text(
            _validity["program name"] ? "" : "Enter program name",
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
    final userRepo = Provider.of<UserRepository>(context);
    return SafeArea(
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
              "Lets start with some basic info",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          _buildNameField(),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 0,
            ),
            child: _buildNextButton(),
          ),
        ],
      ),
    );
  }
}
