import 'dart:async';

import 'package:carzen/widgets/edit_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import '../common/common_styles.dart';
import '../common/screen_width_and_height.dart';

class PickLocationGoogleMapsScreen extends StatefulWidget {
  const PickLocationGoogleMapsScreen({Key? key, this.latitude, this.longitude})
      : super(key: key);

  final double? latitude, longitude;

  @override
  _PlacePickGoogleMapsState createState() => _PlacePickGoogleMapsState();
}

class _PlacePickGoogleMapsState extends State<PickLocationGoogleMapsScreen> {
  //Location location = Location();

  TextEditingController controllerAddress = TextEditingController();

  late LatLng latLngCamera;
   double? latitude, longitude;
  
  List<Placemark>? placemarks;

  Placemark? place;
 bool _latLongCameraInitialized = true;

  double? newlat, newlang, newlats, cameraMovenewlat, cameraMovenewlong;

  CameraPosition? cameraMove;

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;

  @override
  void initState() {
    print("Init state pronted");
    super.initState();
    // if (widget.latitude == null || widget.longitude == null) {
    //   latLngCamera =
    //       LatLng(SharedPreference.latitude!, SharedPreference.longitude!);
    // } else {
    // }
    latLngCamera = LatLng(widget.latitude!, widget.longitude!);

    print(latLngCamera.latitude.toString() +
        "Lat long camera" +
        latLngCamera.longitude.toString());
    // context.read<ProfileApiProvder>().profileModel!.userDetails!.latitude;
  }

  // Future<void> initializeMaps() async {
  //   var serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       serviceEnabled = await location.requestService();
  //     }
  //   }
  // }

  // initializeInitialLocation() async {
  //   if (context.read<ProfileApiProvder>().profileModel == null) {
  //     await context.read<ProfileApiProvder>().fetchProfileDetails();
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  bool _isWidgetLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SizedBox(
            height: deviceHeight(context),
            width: deviceWidth(context),
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              // padding: const EdgeInsets.only(top: 180),
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(latLngCamera.latitude, latLngCamera.longitude),
                  zoom: 15),
              onMapCreated: (GoogleMapController controller) {
                getJsonFile("assets/mapStyle.json")
                    .then((value) => controller.setMapStyle(value));
                _controller.complete(controller);
                mapController = controller;
              },
              onCameraIdle: () {
                setState(() {
                  _isWidgetLoading = false;
                });
              },
              onCameraMove: (value) {
                latLngCamera = value.target;
              },
              onCameraMoveStarted: () {
                setState(() {
                  _isWidgetLoading = true;
                });
              },
            ),
          ),
          Positioned(
            top: (deviceHeight(context) - 35) / 2,
            right: (deviceWidth(context) - 35) / 2,
            child: const Align(
              alignment: Alignment.center,
              child: Icon(
                FontAwesomeIcons.mapPin,
                color: Colors.blue,
                size: 35,
              ),
            ),
          ),
          Positioned(
              top: 50.0,
              right: 15.0,
              left: 15.0,
              child: _isWidgetLoading
                  ? Container(
                      height: 100,
                      width: deviceWidth(context) * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: Colors.amber),
                          color: Colors.blue),
                      child: const Center(
                        child: SizedBox(
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Colors.white,
                          ),
                          width: 25,
                        ),
                      ),
                    )
                  : ReverseGeoCodingTextFormField(
                      latitude: latLngCamera.latitude,
                      longitude: latLngCamera.longitude,
                      controllerAddress: controllerAddress,
                    ))
        ],
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          isExtended: true,
          onPressed: _isWidgetLoading
              ? () {}
              : () async {
                //   Map<String, dynamic> mapValue = {
                //     'latitude': latLngCamera.latitude,
                //     'longitude': latLngCamera.longitude,
                //     'address': controllerAddress.text
                //   };
                //   Navigator.of(context).pop(mapValue);
                // print('mapValue is ${mapValue}');
                                          
                  final popNavigation = await showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    context: context,
                    builder: (BuildContext ctxt) {
                      return AddressDetails(address: controllerAddress.text,
                       lat: latLngCamera.latitude.toString(), lng:  latLngCamera.longitude.toString());
                     }, 
                  ); Navigator.of(context).pop();
                 },
                 
          tooltip: 'Press to Select Location',
          label: Text(
            "Select Location",
            style: CommonStyles.black12(),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))));
  }}
    
                  
   
     
   

  final globalFormKey = GlobalKey<FormState>();

  enterNameAndPhoneNumber() {
    return Form(
      key: globalFormKey,
      child: Column(
        children: [
          TextFormField(),
          TextFormField(),
        ],
      ),
    );
  }


class ReverseGeoCodingTextFormField extends StatefulWidget {
  const ReverseGeoCodingTextFormField(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.controllerAddress})
      : super(key: key);
  final double latitude, longitude;
  final TextEditingController controllerAddress;
  @override
  _ReverseGeoCodingTextFormFieldState createState() =>
      _ReverseGeoCodingTextFormFieldState();
}

class _ReverseGeoCodingTextFormFieldState
    extends State<ReverseGeoCodingTextFormField> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    await geocoding.GeocodingPlatform.instance
        .placemarkFromCoordinates(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: deviceWidth(context) * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Colors.amber),
          color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Location From Map",
              style: CommonStyles.whiteText15BoldW500(),
            ),
          ),
          FutureBuilder<List<geocoding.Placemark>>(
              future: geocoding.GeocodingPlatform.instance
                  .placemarkFromCoordinates(widget.latitude, widget.longitude),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  );
                }
                if (snapshot.data != null) {
                  widget.controllerAddress.text = snapshot.data!.first.street! +
                      ", " +
                      snapshot.data!.first.subLocality! +
                      ", " +
                      snapshot.data!.first.locality! +
                      ", " +
                      snapshot.data!.first.postalCode! +
                      ", " +
                      snapshot.data!.first.administrativeArea!;
                  final url = "https://www.google.co.in/maps/@" +
                      widget.latitude.toString() +
                      "," +
                      widget.longitude.toString() +
                      ",19z";
                  print(url);
                } else {
                  widget.controllerAddress.text = "No Address Found";
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.controllerAddress.text,
                          style: CommonStyles.whiteText12BoldW500(),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
