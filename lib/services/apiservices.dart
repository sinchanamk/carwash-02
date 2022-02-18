import 'dart:convert';
import 'package:carzen/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServices {
  static String? userId;
  static String? type;
  static String? service_id;
  static String? brand_id;
  static String? model_id;
  static String? address;
  static String? date;
  static String? time;
  static dynamic lat;
  dynamic long;
  dynamic landmark;

  final String baseUrl = "https://chillkrt.in/car_wash/index.php/Api/buy_order";

  selectAddress(String typeId) {
    
  }

  ProfileResponseModel? _profileResponseModel;
  Future<Map<String, dynamic>> confirmBooking({
    //   BuildContext context,
    required String service_id,
    required String brand_id,
    required String model_id,
    required String date,
    required String time,
    required dynamic lat,
    required dynamic long,
    required dynamic landmark,
  }) async {
    Uri url = Uri.parse("https://chillkrt.in/car_wash/index.php/Api/buy_order");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "brand_id": "$brand_id",
      "service_id": "$service_id",
      "model_id": "$model_id",
      "date": "$date",
      "time": "$time",
      "lat": "$lat",
      "long": '$long',
      "landmark": '$landmark'
    });
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    if (jsonResponse["status"] == "1") {
      // Toast.show(
      //   jsonResponse['message'],
      //   context,
      //   duration: 1,
      // );
      return {
        "status": true,
        "msg": jsonResponse["message"],
      };
    } else {
      return {
        "status": false,
        "msg": jsonResponse["message"],
      };
    }
  }

  Future editSearchAddress(
      {
      required String userId,
      required String type,
      required dynamic address,
      required dynamic land_mark,
      dynamic lat,
      dynamic long}) async {
    Uri url = Uri.parse("https://chillkrt.in/car_wash/index.php/Api/edit_search_address");
    var request = MultipartRequest('POST', url);
    request.fields.addAll({
      "user_id": ApiServices.userId!,
      "type": type,
      "address": address,
      "land_mark": land_mark,
      "lat": "$lat",
      "long": "$long"
    });
    print("lat +${lat}");
    print("long +${long}");
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(respStr);
    print("param Edit address --- jsonResponse +${jsonResponse.toString()}");
    if (jsonResponse["status"] == "1") {
      return {
        "status": true,
        "msg": jsonResponse["message"],
      };
    } else {
      return {
        "status": false,
        "msg": jsonResponse["message"],
      };
    }
  }

  Future<Response> editProfile(
      {required String userId,
      required String userName,
      required String email,
      required String mobileNo,
      required String otp,
      required String deviceToken}) async {
    print("UPdate response body edit profile called ");

    final response = await http.post(
        Uri.parse("https://chillkrt.in/car_wash/index.php/Api/profile_update"),
        body: {
          "user_id": userId,
          "user_name": userName,
          "email": email,
          "mobile_no": mobileNo,
          "otp": otp,
          "device_token": deviceToken
        });
    print("UPdate response body" + response.body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load album');
    }
  }
  // Future editSearchAddress(
  //     { required String type,
  //       dynamic address,
  //       dynamic land_mark,
  //       dynamic floor,
  //       dynamic reach,
  //       dynamic lat,
  //       dynamic long
  //     }) async {
  //   Uri url = Uri.parse("$baseUrl/edit_search_address");
  //   var request = MultipartRequest('POST', url);

  //   request.fields.addAll({
  //     "user_id": ApiServices.userId!,
  //     "type": type,
  //     "address": address,
  //     "land_mark": land_mark,
  //     "floor": floor,
  //     "reach": reach,
  //     "lat":"$lat",
  //     "long":"$long"
  //   });

  //     }

}
