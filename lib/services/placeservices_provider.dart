import 'dart:convert';
import 'package:carzen/model/place_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'apiservices.dart';

class PlaceServicesProvider with ChangeNotifier {
  bool _error = false;
  String _errormessage = "";
  PlaceServiceModel? _placeServiceModel;

  PlaceServiceModel? get placeServiceModel => _placeServiceModel;

  bool get error => _error;
  String get errormessage => _errormessage;
  bool get ifLoading =>_placeServiceModel == null && _error == false;

   Future<void> get getService async {
   Uri url =
        Uri.parse("https://chillkrt.in/car_wash/index.php/Api/buy_order");

     print('Userid is:${ApiServices.userId}');   
 Response response = await post(url, body: {"user_id": ApiServices.userId,// "type":ApiServices.type,//"service_id":ApiServices.service_id,"brand_id":ApiServices.brand_id,
//  "model_id":ApiServices.model_id,//"lat":ApiServices.lat,"long"ApiServices.long,
//  "landmark":ApiServices.landmark,
//  "date":ApiServices.date,"time":ApiServices.time,"address":ApiServices.address,
 });
       if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _placeServiceModel = PlaceServiceModel.fromJson(jsonResponse);
        print("------------");
        print("PlaceOrderModel API Executed Successfully");
        print("----------------------------------");
        print("Json Response --- ${jsonResponse.toString()}");
      } catch (e) {
        _error = true;
        _errormessage = e.toString();
        _placeServiceModel = null;
        print("------------");
        print("PlaceOrderModel API Execution Failed");
        print("----------------------------------");
      }
    } else {
      _error = true;
      _errormessage =
          "Error response status code " + response.statusCode.toString();
      _placeServiceModel = null;
      print("------------");
      print("PlaceOrderModel API Execution Failed");
      print("----------------------------------");
    }
    notifyListeners();
  }
}
