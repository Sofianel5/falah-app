import 'package:flutter/material.dart';
import 'package:falah/models/user_repository.dart';
import 'package:provider/provider.dart';

class PasswordResetScreen extends StatefulWidget {
    PasswordResetScreen(this.user);

  final UserRepository user;

  @override
  PasswordResetScreenState createState() => PasswordResetScreenState();
}
class PasswordResetScreenState extends State<PasswordResetScreen> {
  TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool _validity = true;
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _validity = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xFFF3F5F7),
          ),
          Form(
            key: _formKey,
            child: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 120,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Reset password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _buildEmailField(),
                    SizedBox(
                      height: 30,
                    ),
                    _buildSubmitButton(widget.user),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
          child: Text(
            "Email",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 10), blurRadius: 15),
            ],
          ),
          child: FormField(
            validator: (value) => _email.text != "" && _email.text.length != 0 ? "" : "Please provide a valid email",
            builder: (FormFieldState<int> state) => TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              style: TextStyle(),
              decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: _validity ? Colors.black : Colors.red,
                      width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "example@falah.world",
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 3, 0, 0),
          child: Text(
            _validity ? "" : "Please provide a valid email",
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

  Widget _buildSubmitButton(UserRepository user) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: RaisedButton(
          onPressed: () async {
            if (_validity) {
              _key.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
              bool result = await user.resetPassword(
                email: _email.text,
              );
              if (!result) {
                _key.currentState.showSnackBar(
                  SnackBar(
                    content: Text("Cannot connect to server."),
                  ),
                );
              } else {
                _key.currentState.showSnackBar(
                  SnackBar(
                    content: Text("Success! Check your email."),
                  ),
                );
              }
            } else {
              _key.currentState.showSnackBar(
                  SnackBar(
                    content: Text("Please provide all fields."),
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
            "Sign up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  
}