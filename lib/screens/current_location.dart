import 'package:carzen/common/location_shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {
  final dynamic latitude;
  final dynamic longitude;
  final bool isProceed;
  CurrentLocation(
      {Key? key, this.latitude, this.longitude, this.isProceed = false})
      : super(key: key);

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  GoogleMapController? mapController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CameraPosition? _initialLocation;
  dynamic currentAddress,
      currentAddressNew,
      myaddress,
      newlatvalue,
      newlongvalue;
  List<Placemark>? placemarks;
  Placemark? place;
  double? newlat, newlang, newlats, cameraMovenewlat, cameraMovenewlong;
  CameraPosition? cameraMove;

  _setLocation(dynamic lat, dynamic long) async {
    _initialLocation = CameraPosition(
        target: LatLng(
          SharedPreference.latitude,
          SharedPreference.longitude,
        ),
        zoom: 15);
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    Placemark place = placemarks[0];

    setState(() {
      currentAddress = "${place.subLocality}";
      currentAddressNew = "${place.name},${place.locality},${place.country}";
    });
    print("${currentAddress} ");
  }

  var textController = TextEditingController();

  @override
  void initState() {
    _setLocation(
      widget.latitude,
      widget.longitude,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: true,
            // hide location button
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            //  camera position
            initialCameraPosition: _initialLocation!,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            onCameraMoveStarted: () {
              // notify map is moving
              // mapPickerController.mapMoving();
            },
            onCameraMove: (cameraPosition) async {
              this._initialLocation = cameraPosition;
              cameraMovenewlat = cameraPosition.target.latitude;
              cameraMovenewlong = cameraPosition.target.longitude;
              setState(() {
                _setLocation(
                  cameraMovenewlat,
                  cameraMovenewlong,
                );
              });
              print("${currentAddress} ");
            },
            onCameraIdle: () async {
              // notify map stopped moving
              // mapPickerController.mapFinishedMoving();
              //get address name from camera position
              List<Placemark> addresses = await GeocodingPlatform.instance
                  .placemarkFromCoordinates(_initialLocation!.target.latitude,
                      _initialLocation!.target.longitude);
              // update the ui with the address
              textController.text =
                  '${addresses.first.subAdministrativeArea ?? ''}';
            },
          ),
        ],
      ),
    );
  }
}
