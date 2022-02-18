// // import 'dart:async';
// // import 'package:carzen/common/utils.dart';
// // import 'package:carzen/services/apiservices.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_form_builder/flutter_form_builder.dart';
// // import 'package:geocoder/geocoder.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:map_pin_picker/map_pin_picker.dart';

// // import '../common/location_shared_preference.dart';
// // import 'interiorpolishingScreen.dart';

// // class MapSample extends StatefulWidget {
// //   final dynamic latitude;
// //   final dynamic longitude;
// //   final bool isProceed;
// //   final bool isCart;

// //   MapSample({this.latitude, this.longitude, this.isProceed = false,this.isCart = false});

// //   @override
// //   State<MapSample> createState() => MapSampleState();
// // }

// // class MapSampleState extends State<MapSample> {
// //  late GoogleMapController mapController;
// //   final _scaffoldKey = GlobalKey<ScaffoldState>();
// //  late CameraPosition _initialLocation;

// //   dynamic currentAddress, currentAddressNew, myaddress, newlatvalue, newlongvalue;
// //   late  List<Placemark> placemarks;
// //  late Placemark place;
// //  late double newlat, newlang, newlats, cameraMovenewlat, cameraMovenewlong;
// //  late CameraPosition cameraMove;
// //   MapPickerController mapPickerController = MapPickerController();

// //   final _formKey = GlobalKey<FormBuilderState>();

// //   TextEditingController addressController = TextEditingController();
// //   TextEditingController landmarkController = TextEditingController();
// // TextEditingController doorController = TextEditingController();
// // TextEditingController pincodeController = TextEditingController();

// //   TextEditingController stateController = TextEditingController();

// //   TextEditingController streetController = TextEditingController();
// // ApiServices apiServices=ApiServices();
// //   dynamic typeId;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _setLocation(
// //       widget.latitude,
// //       widget.longitude,
// //     );
// //   }

// //   _setLocation(dynamic lat, dynamic long) async {
// //     _initialLocation = CameraPosition(
// //         target: LatLng(
// //           lat,
// //           long,
// //         ),
// //         zoom: 15);
// //     List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

// //     Placemark place = placemarks[0];

// //     setState(() {
// //       currentAddress = "${place.subLocality}";
// //       currentAddressNew = "${place.name},${place.locality},${place.country}";
// //     });
// //     print("${currentAddress} ");
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     var height = MediaQuery.of(context).size.height;
// //     var width = MediaQuery.of(context).size.width;
// //     var textController = TextEditingController();

// //     return Container(
// //       height: height,
// //       width: width,
// //       child: Scaffold(
// //         key: _scaffoldKey,
// //         body: Stack(
// //           children: [
// //             MapPicker(
// //               // pass icon widget
// //               iconWidget: Icon(
// //                 Icons.location_pin,
// //                 size: 50,
// //                 color: Color(0xFF16264C),
// //               ),
// //               //add map picker controller
// //               mapPickerController: mapPickerController,
// //               child: GoogleMap(
// //                 zoomControlsEnabled: true,
// //                 zoomGesturesEnabled: true,
// //                 myLocationButtonEnabled: true,
// //                 mapType: MapType.normal,
// //                 initialCameraPosition: _initialLocation,
// //                 onMapCreated: (GoogleMapController controller) {
// //                   mapController = controller;
// //                 },
// //                 onCameraMoveStarted: () {
// //                   mapPickerController.mapMoving();
// //                 },
// //                 onCameraMove: (cameraPosition) async {
// //                   this._initialLocation = cameraPosition;
// //                   cameraMovenewlat = cameraPosition.target.latitude;
// //                   cameraMovenewlong = cameraPosition.target.longitude;
// //                   setState(() {
// //                     _setLocation(
// //                       cameraMovenewlat,
// //                       cameraMovenewlong,
// //                     );
// //                   });
// //                   print("${currentAddress} ");
// //                 },
// //                 onCameraIdle: () async {
// //                   mapPickerController.mapFinishedMoving();
// //                   List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(
// //                       Coordinates(_initialLocation.target.latitude, _initialLocation.target.longitude));
// //                   textController.text = addresses.first.addressLine ?? '';
// //                 },
// //               ),
// //             ),
// //             DraggableScrollableSheet(
// //               initialChildSize: .27,
// //               minChildSize: .27,
// //               maxChildSize: .6,
// //               builder: (BuildContext context, ScrollController scrollController) {
// //                 return StatefulBuilder(builder: (context, state) {
// //                   return Container(
// //                       color: Colors.white,
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(15.0),
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.start,
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               "SELECT DELIVERY LOCATION",
// //                               style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
// //                             ),
// //                         Utils.getSizedBox(height: 20),
// //                             Row(
// //                               children: [
// //                                 Icon(
// //                                   Icons.location_on,
// //                                   color: Colors.red,
// //                                 ),
                             
// //                                 Text(
// //                                   currentAddress,
// //                                   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
// //                                 ),
// //                               ],
// //                             ),  Utils.getSizedBox(height: 20),
                      
// //                             currentAddress != null ? Text(currentAddressNew) : Container(),
// //                               Utils.getSizedBox(height: 20),
                      
// //                             Padding(
// //                               padding: const EdgeInsets.only(left: 8.0, right: 8),
// //                               child: currentAddress != null
// //                                   ? widget.isProceed
// //                                       ? InkWell(
// //                                           onTap: ()  {
// //                                             double latValue =
// //                                                 cameraMovenewlat != null ? cameraMovenewlat : widget.latitude;
// //                                             double lngValue =
// //                                                 cameraMovenewlat != null ? cameraMovenewlong : widget.longitude;
// //                                             List<Placemark> placemarks =
// //                                                  placemarkFromCoordinates(latValue, lngValue) as List<Placemark>;

// //                                             Placemark place = placemarks[0];

// //                                             var saveAddressField =
// //                                                 "${place.street} ${place.subLocality},${place.locality},${place.subAdministrativeArea}";
// //                                             showModalBottomSheet(
// //                                                 isScrollControlled: true,
// //                                                 shape: RoundedRectangleBorder(
// //                                                   borderRadius: BorderRadius.circular(10.0),
// //                                                 ),
// //                                                 context: context,
// //                                                 builder: (builder) {
// //                                                   return Padding(
// //                                                     padding: EdgeInsets.only(
// //                                                         bottom: MediaQuery.of(context).viewInsets.bottom),
// //                                                     child: Wrap(
// //                                                       children: [
// //                                                         Padding(
// //                                                           padding: EdgeInsets.all(8),
// //                                                           child: Column(
// //                                                             crossAxisAlignment: CrossAxisAlignment.start,
// //                                                             mainAxisSize: MainAxisSize.min,
// //                                                             children: <Widget>[
// //                                                               Padding(
// //                                                                 padding:
// //                                                                     const EdgeInsets.only(top: 8.0, bottom: 8, left: 5),
// //                                                                 child: Text(
// //                                                                   'Enter address details',
// //                                                                   style: Theme.of(context)
// //                                                                       .textTheme
// //                                                                       .headline6!
// //                                                                       .copyWith(fontSize: 17.0),
// //                                                                 ),
// //                                                               ),
// //                                                               FormBuilder(
// //                                                                 key: _formKey,
// //                                                                 child: Padding(
// //                                                                   padding: const EdgeInsets.all(8.0),
// //                                                                   child: Column(
// //                                                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                                                     crossAxisAlignment: CrossAxisAlignment.start,
// //                                                                     children: [
// //                                                                       Text(
// //                                                                         "Your location".toUpperCase(),
// //                                                                         style:
// //                                                                             TextStyle(color: Colors.grey, fontSize: 13),
// //                                                                       ),
                                                                   
// //                                                                       Container(
// //                                                                           width:
// //                                                                               MediaQuery.of(context).size.width * 0.9,
// //                                                                           child: Text(
// //                                                                             saveAddressField,
// //                                                                             style: TextStyle(
// //                                                                                 fontWeight: FontWeight.bold,
// //                                                                                 fontSize: 14),
// //                                                                           )),
                                                                    
// //                                                                       Padding(
// //                                                                         padding: const EdgeInsets.all(5.0),
// //                                                                         child: FormBuilderTextField(
// //                                                                           name: 'address',
// //                                                                           decoration: InputDecoration(
// //                                                                             contentPadding: EdgeInsets.all(5),
// //                                                                             //  <- you can it to 0.0 for no space
// //                                                                             isDense: true,
// //                                                                             enabledBorder: UnderlineInputBorder(
// //                                                                                 borderSide:
// //                                                                                     BorderSide(color: Colors.grey)),
// //                                                                             focusedBorder: UnderlineInputBorder(
// //                                                                                 borderSide:
// //                                                                                     BorderSide(color: Colors.red)),
// //                                                                             labelText: "Complete Address",
// //                                                                           ),
// //                                                                           controller: addressController,
// //                                                                         ),
// //                                                                       ),
                                                                   
// //                                                                       Padding(
// //                                                                         padding: const EdgeInsets.all(5.0),
// //                                                                         child: FormBuilderTextField(
// //                                                                           name: 'land_mark',
// //                                                                           decoration: InputDecoration(
// //                                                                             contentPadding: EdgeInsets.all(5),
// //                                                                             //  <- you can it to 0.0 for no space
// //                                                                             isDense: true,
// //                                                                             enabledBorder: UnderlineInputBorder(
// //                                                                                 borderSide:
// //                                                                                     BorderSide(color: Colors.grey)),
// //                                                                             focusedBorder: UnderlineInputBorder(
// //                                                                                 borderSide:
// //                                                                                     BorderSide(color: Colors.red)),
// //                                                                             labelText: "Nearby landmark (Optional)",
// //                                                                           ),
// //                                                                           controller: landmarkController,
// //                                                                         ),
// //                                                                       ),
                                                                    
// //                                                                       Padding(
// //                                                                         padding: const EdgeInsets.all(5.0),
// //                                                                         child: FormBuilderTextField(
// //                                                                           name: 'floor',
// //                                                                           decoration: InputDecoration(
// //                                                                             contentPadding: EdgeInsets.all(5),
// //                                                                             //  <- you can it to 0.0 for no space
// //                                                                             isDense: true,
// //                                                                             enabledBorder: UnderlineInputBorder(
// //                                                                                 borderSide:
// //                                                                                     BorderSide(color: Colors.grey)),
// //                                                                             focusedBorder: UnderlineInputBorder(
// //                                                                                 borderSide:
// //                                                                                     BorderSide(color: Colors.red)),
// //                                                                             labelText: "Floor (Optional)",
// //                                                                           ),
// //                                                                           controller: doorController,
// //                                                                         ),
// //                                                                       ),
                                                                      
// //                                                                       Padding(
// //                                                                         padding: const EdgeInsets.all(5.0),
// //                                                                         child: FormBuilderTextField(
// //                                                                           name: 'reach',
// //                                                                           decoration: InputDecoration(
// //                                                                             contentPadding: EdgeInsets.all(5),
// //                                                                             //  <- you can it to 0.0 for no space
// //                                                                             isDense: true,
// //                                                                             enabledBorder: UnderlineInputBorder(
// //                                                                                 borderSide:
// //                                                                                     BorderSide(color: Colors.grey)),
// //                                                                             focusedBorder: UnderlineInputBorder(
// //                                                                                 borderSide:
// //                                                                                     BorderSide(color: Colors.red)),
// //                                                                             labelText: "How to reach (Optional)",
// //                                                                           ),
// //                                                                           controller: streetController,
// //                                                                         ),
// //                                                                       ),
// //                                                                       FormBuilderChoiceChip(
// //                                                                         onChanged: (val) {
// //                                                                           typeId = val;
// //                                                                         },
// //                                                                         name: 'type',
// //                                                                         decoration: InputDecoration(
// //                                                                           labelText: 'Tag this location for later',
// //                                                                         ),
// //                                                                         options: [
// //                                                                           FormBuilderFieldOption(
// //                                                                               value: '1',
// //                                                                               child: Padding(
// //                                                                                 padding: const EdgeInsets.all(5.0),
// //                                                                                 child: Text('Home'),
// //                                                                               )),
// //                                                                           FormBuilderFieldOption(
// //                                                                               value: '2',
// //                                                                               child: Padding(
// //                                                                                 padding: const EdgeInsets.all(5.0),
// //                                                                                 child: Text('Work'),
// //                                                                               )),
// //                                                                           FormBuilderFieldOption(
// //                                                                               value: '3',
// //                                                                               child: Padding(
// //                                                                                 padding: const EdgeInsets.all(5.0),
// //                                                                                 child: Text('Other'),
// //                                                                               )),
// //                                                                         ],
// //                                                                       ),
// //                                                                       GestureDetector(
// //                                                                         onTap: () {
// //                                                                           _formKey.currentState!.save();
// //                                                                           if (_formKey.currentState!.validate()) {
// //                                                                             double lat = cameraMovenewlat != null
// //                                                                                 ? cameraMovenewlat
// //                                                                                 : widget.latitude;

// //                                                                             double long = cameraMovenewlong != null
// //                                                                                 ? cameraMovenewlong
// //                                                                                 : widget.longitude;

// //                                                                             apiServices
// //                                                                                 .editSearchAddress(
// //                                                                                     type: typeId,
// //                                                                                     address: addressController.text,
// //                                                                                     land_mark: landmarkController.text,
// //                                                                                     door: doorController.text,
// //                                                                                     street: streetController.text,
                                                                                    
// //                                                                                     lat: lat,
// //                                                                                     long: long, pincode: null, state: null, userId: )
// //                                                                                 .then((value) {
// //                                                                               if (value['status'] == true) {
// //                                                                                 print(widget.isCart);
// //                                                                                 SharedPreference.setValues(lat: lat, long: long).whenComplete(() {
// //                                                                                   widget.isCart ?  Navigator.popAndPushNamed(
// //                                                                                       context, 'CartScreen') :
// //                                                                                   Navigator.popAndPushNamed(context, "Home");
// //                                                                                 });

// //                                                                               }
// //                                                                             });
// //                                                                           } else {
// //                                                                             print("validation failed");
// //                                                                           }
// //                                                                         },
// //                                                                         child: Container(
// //                                                                           width: MediaQuery.of(context).size.width,
// //                                                                           decoration: BoxDecoration(
// //                                                                               borderRadius: BorderRadius.circular(5),
// //                                                                               color: Colors.red),
// //                                                                           child: const Padding(
// //                                                                             padding: EdgeInsets.all(10.0),
// //                                                                             child: Center(
// //                                                                                 child: Text(
// //                                                                               "Save Address",
// //                                                                               style: TextStyle(
// //                                                                                   color: Colors.white,
// //                                                                                   fontWeight: FontWeight.bold,
// //                                                                                   fontSize: 17),
// //                                                                             )),
// //                                                                           ),
// //                                                                         ),
// //                                                                       )
// //                                                                     ],
// //                                                                   ),
// //                                                                 ),
// //                                                               )
// //                                                             ],
// //                                                           ),
// //                                                         )
// //                                                       ],
// //                                                     ),
// //                                                   );
// //                                                 });
// //                                           },
// //                                           child: Container(
// //                                               width: MediaQuery.of(context).size.width,
// //                                               decoration: BoxDecoration(
// //                                                   borderRadius: BorderRadius.circular(5.0), color: Colors.red),
// //                                               child: Padding(
// //                                                 padding: const EdgeInsets.all(8.0),
// //                                                 child: Center(
// //                                                     child: Text(
// //                                                   "Confirm Location & Proceed".toUpperCase(),
// //                                                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
// //                                                 )),
// //                                               )),
// //                                         )
// //                                       : InkWell(
// //                                           onTap: () async {
// //                                             // double latValue =
// //                                             //     cameraMovenewlat != null ? cameraMovenewlat : widget.latitude;
// //                                             // double lngValue =
// //                                             //     cameraMovenewlat != null ? cameraMovenewlong : widget.longitude;

// //                                             // SharedPreference.setValues(lat: latValue, long: lngValue).whenComplete(() {
                                          
// //                                           //  MaterialPageRoute(builder: (context)=>
// //                                           // InteriorPolishing( address: currentAddressNew, type: '', typeName: '',));
// //                                           Navigator.pop(context,currentAddressNew);                                           // });
// //                                           },
// //                                           child: Container(
// //                                               width: MediaQuery.of(context).size.width,
// //                                               decoration: BoxDecoration(
// //                                                   borderRadius: BorderRadius.circular(5.0), color: Colors.red),
// //                                               child: Padding(
// //                                                 padding: const EdgeInsets.all(8.0),
// //                                                 child: Center(
// //                                                     child: Text(
// //                                                   "Confirm Location".toUpperCase(),
// //                                                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
// //                                                 )),
// //                                               )),
// //                                         )
// //                                   : InkWell(
// //                                       onTap: () async {
// //                                         print("updatemap");
// //                                         // Navigator.pop(context);
// //                                       },
// //                                       child: Container(
// //                                           width: MediaQuery.of(context).size.width,
// //                                           decoration: BoxDecoration(
// //                                               borderRadius: BorderRadius.circular(5.0), color: Colors.red),
// //                                           child: Padding(
// //                                             padding: const EdgeInsets.all(8.0),
// //                                             child: Center(
// //                                                 child: Text(
// //                                               "Confirm Locationvbg".toUpperCase(),
// //                                               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
// //                                             )),
// //                                           )),
// //                                     ),
// //                             ),
// //                           ],
// //                         ),
// //                       ));
// //                 });
// //               },
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton.extended(
//           isExtended: true,
//           onPressed: _isWidgetLoading
//               ? () {}
//               : () async {
//                 //   Map<String, dynamic> mapValue = {
//                 //     'latitude': latLngCamera.latitude,
//                 //     'longitude': latLngCamera.longitude,
//                 //     'address': controllerAddress.text
//                 //   };
//                 //   Navigator.of(context).pop(mapValue);
//                 // print('mapValue is ${mapValue}');
                                          
//                   final popNavigation = await showModalBottomSheet(
//                     isScrollControlled: true,
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           topRight: Radius.circular(10)),
//                     ),
//                     context: context,
//                     builder: (BuildContext ctxt) {
//                       return AddressDetails(address: controllerAddress.text,
//                        lat: latLngCamera.latitude.toString(), lng:  latLngCamera.latitude.toString());
//                      },
//                   ); 
                
//                  },
                 
//           tooltip: 'Press to Select Location',
//           label: Text(
//             "Select Location",
//             style: CommonStyles.black12(),
//           ),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))));
//   }}
    
                  
   
     
   
