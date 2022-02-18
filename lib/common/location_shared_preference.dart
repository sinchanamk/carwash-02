import 'package:carzen/common/location_helper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static late LocationHelper locationHelper;
  static dynamic latitudeValue;
  static dynamic longitudeValue;
  static dynamic devicetoken;
  static dynamic latitude;
  static dynamic longitude;
  static dynamic address;
  static dynamic currentAddress;
  static late SharedPreferences sharedPreference;

  static Future<void> getLocationData(dynamic lat, dynamic long) async {
    locationHelper = LocationHelper();

    await locationHelper.getCurrentLocation();
    if (locationHelper.longitude == null || locationHelper.latitude == null) {
      print("data not fetched!");
    } else {
      latitude = lat;
      longitude = long;
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      Placemark place = placemarks[0];

      currentAddress =
          "${place.street} ${place.subLocality},${place.locality},${place.subAdministrativeArea}";
    }
  }

  static Future<void> setValues({dynamic lat, dynamic long}) async {
    locationHelper = LocationHelper();

    await locationHelper.getCurrentLocation();
    await getLocationData(locationHelper.latitude, locationHelper.longitude)
        .then((value) async {
      sharedPreference = await SharedPreferences.getInstance();
      sharedPreference.setDouble("LATITUDE", latitude ?? 27.2046);
      sharedPreference.setDouble("LONGITUDE", longitude ?? 77.4977);
      sharedPreference.setString("ADDRESS", currentAddress ?? "NA");
      await getValues();
    });
  }

  static Future<void> getValues() async {
    sharedPreference = await SharedPreferences.getInstance();
    latitudeValue = sharedPreference.getDouble("LATITUDE") ?? 27.2046;
    longitudeValue = sharedPreference.getDouble("LONGITUDE") ?? 77.4977;
    address = sharedPreference.getString("ADDRESS") ?? "NA";
    print(
        "value get in share pref +${latitudeValue} ${longitudeValue} ${address}");
  }
}
