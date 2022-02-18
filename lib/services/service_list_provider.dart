import 'dart:convert';
import 'package:carzen/model/service_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ServiceListApiProvider with ChangeNotifier {
  bool _error = false;
  String _errormessage = "";
  ServiceListModel? _serviceListModel;

  ServiceListModel? get serviceListModel => _serviceListModel;

  bool get error => _error;
  String get errormessage => _errormessage;
  bool get ifLoading => _serviceListModel == null && _error == false;

  Future getService() async {
    final uri =
        Uri.parse("https://chillkrt.in/car_wash/index.php/Api/service_list");

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _serviceListModel = ServiceListModel.fromJson(jsonResponse);
        print("------------");
        print("ServiceListModel API Executed Successfully");
        print("----------------------------------");
        print("Json Response --- ${jsonResponse.toString()}");
      } catch (e) {
        _error = true;
        _errormessage = e.toString();
        _serviceListModel = null;
        print("------------");
        print("ServiceListModel API Execution Failed");
        print("----------------------------------");
      }
    } else {
      _error = true;
      _errormessage =
          "Error response status code " + response.statusCode.toString();
      _serviceListModel = null;
      print("------------");
      print("ServiceListModel API Execution Failed");
      print("----------------------------------");
    }
    notifyListeners();
  }
}
