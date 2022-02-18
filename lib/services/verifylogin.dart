
import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart';

import '../model/login_model.dart';
class VerifyUserLoginAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  LoginResponse? _loginResponse;

  bool get isLoading => _error == false && _loginResponse == null;

  Future<void> getUser(
      {required String deviceToken,
      required String userFirebaseID,
      required String phoneNumber}) async {
    final uri = Uri.parse(
        "https://chillkrt.in/car_wash/index.php/Api/signIn");

    final response = await post(uri, body: {
      'user_fid': userFirebaseID,
      'device_token': deviceToken,
      // 'phone_number': phoneNumber
    });

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        _loginResponse = LoginResponse.fromJson(jsonResponse);
        print(_loginResponse!.message);
        print("------------------");
        print("Login Success");
        print("-------------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Status code of response " + response.statusCode.toString();
        _loginResponse = null;
        print("------------------");
        print("Login Failed");
        print("-------------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Status code of response " + response.statusCode.toString();
      _loginResponse = null;
      print("------------------");
      print("Login Failed");
      print("-------------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  LoginResponse? get loginResponse => _loginResponse;
}
