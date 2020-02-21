import 'dart:convert';
import 'package:falah/models/program_model.dart';
import 'package:falah/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:falah/api/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  Status _status = Status.Unauthenticated;
  User _user;

  Status get status => _status;
  User get user => _user;

  UserRepository() {
    _getUser();
  }

  Future<bool> signIn({
    @required String email,
    @required String password,
  }) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      Map data = {
        "email": email,
        "password": password,
      };
      var jsonData;
      var response = await http.post(Urls.LOGIN_URL, body: data);
      SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
      if (response.statusCode == 200) {
        jsonData = json.decode(response.body);
        sharedPrefrences.setString("token", jsonData["auth_token"]);
        _user = await _getUser();
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      }
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }
  Future<Map> signUp({
    @required String email,
    @required String password,
    @required String firstName,
    @required String lastName,
  }) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      Map data = {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
      };
      var jsonData;
      var response = await http.post(Urls.SIGNUP_URL, body: data);
      //SharedPreferences sharedPrefrences = await SharedPreferences.getInstance();
      if (response.statusCode == 201) {
        print(response);
        jsonData = json.decode(response.body);
        bool validity = await signIn(email: jsonData["email"], password: password);
        print(validity);
        print(_status);
        return {"validity": validity};
      } else {
        jsonData = json.decode(response.body);
        if (jsonData["password"] != null) {
          return {"validity": false, "response": jsonData, "message": "Please provide valid entries to all fields. Note your password must not be too short or common."};
        }
        if (jsonData["email"] != null && jsonData["email"].contains("account with this Email already exists.")) {
          return {"validity": false, "response": jsonData, "message": "Please provide valid entries to all fields. Note this email is already associated with an account."};
        }
        return {"validity": false, "response": jsonData, "message": "Please provide valid entries to all fields."};
      }
    } catch(e) {
      print(e);
      return {"validity": false, "message": "Error connecting to server."};
    }
  }
  Future<String> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    if (token == null) {
      _user = null;
      _status = Status.Unauthenticated;
      notifyListeners();
      return null; 
    } else {
      return token;
    }
  }
  Future _getPrograms() async {
    assert(_user != null);
    var token = await _getToken();
    print("getting programs");
    var response = await http.post(Urls.PROGRAM_GETTER_URL,
      headers: {"Authorization": "Token " + token}
    );
    var responseJson;
    if (response.statusCode == 200) {
      // Set _user.programs
      responseJson = json.decode(response.body);
      print(responseJson);
      for (var program in responseJson) {
        print(program);
        _user.programs.add(Program.fromJson(program));
      }
      notifyListeners();
    }
  }
  Future _getUser() async {
    print("getting user");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    print(token);
    var response = await http.get(Urls.USER_URL, 
      headers: {"Authorization": "Token " +token, 'Accept': "application/json"}
    );
    var responseJson;
    if (response.statusCode == 200) {
      _status = Status.Authenticated;
      notifyListeners();
      responseJson = json.decode(response.body);
      _user = User.fromJson(responseJson);
      print(_user);
    }
  }

  Future signOut() async {
    deleteToken();
    _user = null;
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(User user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<void> deleteToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

}
