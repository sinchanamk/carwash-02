import 'dart:convert';import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

import '../model/profile_model.dart';
import 'apiservices.dart';
class ProfileApiResponseProvider extends ChangeNotifier {
  ProfileResponseModel? _profileResponseModel;
  bool _error = false;
  String _errorMessage = "";
  bool get showLoading => _error == false && _profileResponseModel == null;
  Future<void> get fetchData async {
    Uri url =
        Uri.parse("https://chillkrt.in/car_wash/index.php/Api/profile");
print(ApiServices.userId.toString()+"Profole id from order model------------------------------------------------------");
    Response response = await post(url, body: {"user_id": ApiServices.userId});
    print("The http post response is ---- "+ response.body)
;    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        _profileResponseModel = ProfileResponseModel.fromJson(jsonResponse);
        print(_profileResponseModel.toString());
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _profileResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Error: someting went wrong status code ${response.statusCode}";
      _profileResponseModel = null;
    }
    print(_error);
    print("Error Message is" + _errorMessage);
    notifyListeners();
  }

ProfileResponseModel? get profileResponseModel => _profileResponseModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  void initialValue() {
    _error = false;
    _errorMessage = "";
  //0  _deliveredOrderModel = null;
    notifyListeners();
  } 
}
