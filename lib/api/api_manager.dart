import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  static const String _baseUrl = "";
  static const String _loginUrl = _baseUrl + "login/";
  String _storageKeyMobileToken = "token";
  static const String _applicationId = "falah_flutter_app";
  String token;
  String _deviceId;
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  Future<String> _getDeviceIdentity() async {
    if (_deviceId == null) {
      try {
        if (Platform.isAndroid) {
          AndroidDeviceInfo info = await _deviceInfoPlugin.androidInfo;
          _deviceId = "${info.device}-${info.id}";
        } else if (Platform.isIOS) {
          IosDeviceInfo info = await _deviceInfoPlugin.iosInfo;
          _deviceId = "${info.model}-${info.identifierForVendor}";
        }
      } on PlatformException {
        _deviceId = "unknown";
      }
    }
    return _deviceId;
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _getMobileToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(_storageKeyMobileToken) ?? "";
  }

  Future<bool> _setMobileToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(_storageKeyMobileToken, token);
  }

  /// ----------------------------------------------------------
  /// Http Handshake
  ///
  /// At application start up, the application needs to synchronize
  /// with the server.
  /// How does this work?
  ///   - A. If a previous token exists, the latter is sent to
  ///   -   the server to be validated.  If the validation is Ok,
  ///   -   the user is re-authenticated and a new token is returned
  ///   -   to the application.  The application then stores it.
  ///
  ///   - B. If no token exists, the application sends a request
  ///   -   for a new token to the server, which returns the
  ///   -   the requested token.  This token will be saved.
  /// ----------------------------------------------------------
  Future<String> handShake() async {
    String _status = "ERROR";
    return ajaxGet("handshake").then((String responseBody) async {
      Map response = json.decode(responseBody);
      _status = response["status"];
      switch (_status) {
        case "AUTHENTICATED":
          await _setMobileToken(response["data"]);
          break;
        case "INVALID":
          await _setMobileToken("");
          break;
      }
    });
  }
  Future<String> ajaxGet(String serviceUrl) async {
    var responseBody = '{"data": "", "status": "NOK"}';
    try {
      var response = await http.get(_baseUrl + serviceUrl, 
        headers: {
          "X-DEVICE-ID": await _getDeviceIdentity(),
          "X-TOKEN": await _getMobileToken(),
          "X-APP-ID": _applicationId
      },);
      if (response.statusCode == 200) {
        responseBody = response.body;
      }
    } catch (e) {
      throw Exception("AJAX ERROR");
    }
    return responseBody;
  }
  Future<Map> ajaxPost(String serviceUrl, Map data) async {
    var responseBody = json.decode('{"data": "", "status": "NOK"}');
    try {
      var response = await http.post(_baseUrl + serviceUrl, 
        body: json.encode(data), 
        headers: {
          "X-DEVICE-ID": await _getDeviceIdentity(),
          "X-TOKEN": await _getMobileToken(),
          "X-APP-ID": _applicationId,
          "Content-Type": 'application/json; charset=utf-8'
        });
      if (response.statusCode == 200) {
        responseBody = json.decode(response.body);
        if (responseBody["status"] == "TOKEN") {
          await _setMobileToken(responseBody["data"]);
        }
      }
    } catch (e) {
      throw Exception("AJAX ERROR");
    }
    return responseBody;
  }

}
