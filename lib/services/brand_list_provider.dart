import 'dart:convert';
import 'package:carzen/model/brand_list_model.dart';
import 'package:carzen/model/model_list.dart';
import 'package:http/http.dart' as http;

APIService getAPI = APIService();

class APIService {
  Future<BrandListModel?> getBrands(String type) async {
    final response = await http.post(
        Uri.parse('https://chillkrt.in/car_wash/index.php/Api/brand_list'),
        body: {"type": type});

    print("Response body ____)-----" + response.body);

    if (response.statusCode == 200) {
      var searchRes = BrandListModel.fromJson(jsonDecode(response.body));
      if (searchRes.status == "1") {
        print(response.body);
        return searchRes;
      } else {
        print("1 st If ");
      }
    } else {
      print("error");
      throw Exception('Failed to load album');
    }
  }

  Future<ModelListModel?> getModel(String type, String brandId) async {
    final response = await http.post(
        Uri.parse('https://chillkrt.in/car_wash/index.php/Api/model_list'),
        body: {"type": type, "brand_id": brandId});

    print("Response body ____)-----" + response.body);

    if (response.statusCode == 200) {
      var searchRes = ModelListModel.fromJson(jsonDecode(response.body));
      if (searchRes.status == "1") {
        print(response.body);
        return searchRes;
      } else {
        print("1 st If ");
      }
    } else {
      print("error");
      throw Exception('Failed to load album');
    }
  }
}
