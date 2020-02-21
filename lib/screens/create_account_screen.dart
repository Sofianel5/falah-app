import 'package:falah/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:falah/models/user_repository.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen(this.user);

  final UserRepository user;

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _password = TextEditingController();
  Map _validity;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _firstName.dispose();
    _lastName.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    _firstName = TextEditingController(text: "");
    _lastName = TextEditingController(text: "");
    _validity = {
      "first name": true,
      "last name": true,
      "email": true,
      "password": true,
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
            validator: (value) => _validateField(value, "email", _email),
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
                      color: _validity["email"] ? Colors.black : Colors.red,
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
            _validity["email"] ? "" : "Please provide a valid email",
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

  Widget _buildFirstNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
          child: Text(
            "First name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        Container(
          height: 60,
          width: 150,
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
            validator: (value) =>
                _validateField(value, "first name", _firstName),
            builder: (FormFieldState<int> state) => TextField(
              keyboardType: TextInputType.text,
              controller: _firstName,
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
                        color:
                            _validity["first name"] ? Colors.black : Colors.red,
                        width: 1),
                    borderRadius: BorderRadius.circular(30)),
                hintText: "Sofiane",
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 3, 0, 0),
          child: Text(
            _validity["first name"] ? "" : "Enter first name",
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

  Widget _buildLastNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
          child: Text(
            "Last name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        Container(
          height: 60,
          width: 150,
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
            validator: (value) => _validateField(value, "last name", _lastName),
            builder: (FormFieldState<int> state) => TextField(
              keyboardType: TextInputType.text,
              controller: _lastName,
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
                        color:
                            _validity["last name"] ? Colors.black : Colors.red,
                        width: 1),
                    borderRadius: BorderRadius.circular(30)),
                hintText: "Larbi",
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 3, 0, 0),
          child: Text(
            _validity["last name"] ? "" : "Enter last name",
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

  Widget _buildNameRow() {
    return Row(
      children: <Widget>[
        _buildFirstNameField(),
        Expanded(
          child: Container(),
        ),
        _buildLastNameField()
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
          child: Text(
            "Password",
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
            validator: (value) => _validateField(value, "password", _password),
            builder: (FormFieldState<int> state) => TextField(
              controller: _password,
              obscureText: true,
              style: TextStyle(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(30)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            _validity["password"] ? Colors.black : Colors.red,
                        width: 1),
                    borderRadius: BorderRadius.circular(30)),
                hintText: "password",
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 3, 0, 0),
          child: Text(
            _validity["password"] ? "" : "Please provide a valid password",
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

  Widget _buildForgotPasswordBtn() {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          onPressed: () => print("Forgot password"),
          child: Text("Forgot password?"),
        ),
      ),
    );
  }

  Widget _loginBackBtn() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        alignment: Alignment.center,
        child: Text("Go back"),
      ),
    );
  }

  Widget _buildSignupButton(UserRepository user) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: RaisedButton(
          onPressed: () async {
            print("validating form");
            if (_formKey.currentState.validate()) {
              _key.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
              Map result = await user.signUp(
                email: _email.text,
                password: _password.text,
                firstName: _firstName.text,
                lastName: _lastName.text,
              );
              if (!result["validity"]) {
                print(result);
                for (var field in ["email", "password"]) {
                  if (result["response"] != null) {
                    setState(() {
                      _validity[field] = result["response"][field] == null;
                    });
                  }
                }
                _key.currentState.showSnackBar(
                  SnackBar(
                    content: Text(result["message"] ?? "Unknown error. Please report this."),
                  ),
                );
              } else {
                print(result);
                _key.currentState.showSnackBar(
                  SnackBar(
                    content: Text(result["message"] ?? "Success!"),
                  ),
                );
                Navigator.pop(context);
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
                      "Sign up",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    _buildNameRow(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildEmailField(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildPasswordField(),
                    _buildForgotPasswordBtn(),
                    _buildSignupButton(widget.user),
                    _loginBackBtn(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
