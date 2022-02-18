import 'package:carzen/services/apiservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../common/utils.dart';
/*
double latValue =
    cameraMovenewlat != null ? cameraMovenewlat! : widget.latitude;
double lngValue =
    cameraMovenewlat != null ? cameraMovenewlong! : widget.longitude;
List<Placemark> placemarks = await placemarkFromCoordinates(latValue, lngValue);

Placemark place = placemarks[0];*/
/*
var saveAddressField =
    "${place.street} ${place.subLocality},${place.locality},${place.subAdministrativeArea}";*/
/* await showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    context: context,
    builder: (BuildContext ctxt) {
      return AddressDetails();
    });*/

class AddressDetails extends StatefulWidget {
  final String address;
  final String lat;
  final String lng;
  const AddressDetails(
      {Key? key, required this.address, required this.lat, required this.lng})
      : super(key: key);

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  final _formKey = GlobalKey<FormState>();
  ApiServices apiServices=ApiServices();

  final _landMarkKey = GlobalKey<FormState>();
  final landMarkController = TextEditingController();

  final _doorNoKey = GlobalKey<FormState>();
  final doorNoController = TextEditingController();

  final _addressKey = GlobalKey<FormState>();
  final addressController = TextEditingController();

  String? typeId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 5),
              child: Text(
                'Enter address details',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 17.0),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your location".toUpperCase(),
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Utils.getSizedBox(height: 10),
                    Utils.getSizedBox(height: 10),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          widget.address,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        )),
                    Utils.getSizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Form(
                        key: _landMarkKey,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please insert correct value";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(
                                5), //  <- you can it to 0.0 for no space
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red[400]!)),
                            labelText: "Nearby landmark (Optional)",
                          ),
                          controller: landMarkController,
                        ),
                      ),
                    ),
                    Utils.getSizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Form(
                        key: _doorNoKey,
                        child: TextFormField(
// validator:
//     (value) {
//   if (value!
//       .isEmpty) {
//     return "Please insert correct value";
//   }
//   return null;
// },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(
                                5), //  <- you can it to 0.0 for no space
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red[400]!)),
                            labelText: "Door No (Optional)",
                          ),
                          controller: doorNoController,
                        ),
                      ),
                    ),
                    Utils.getSizedBox(height: 10),
                    FormBuilderChoiceChip(
                      selectedColor: Colors.greenAccent,
                      spacing: 10,
                      onChanged: (dynamic val) {
                        typeId = val;
                      },
                      validator: (val) {},
                      name: 'type',
                      decoration: InputDecoration(
                        labelText: 'Tag this location for later (Optional)',
                      ),
                      options: [
                        FormBuilderFieldOption(
                            value: '1',
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('Home'),
                            )),
                        FormBuilderFieldOption(
                            value: '2',
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('Work'),
                            )),
                        FormBuilderFieldOption(
                            value: '3',
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('Other'),
                            )),
                      ],
                    ),
                    GestureDetector(

                      onTap: () async {
                        print("TYPEID -------------------- ${typeId}");
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate() &&
                            typeId != null) {
                          Utils.showLoading();
                          var result = await apiServices.editSearchAddress(
                              userId: "${ApiServices.userId}",
                              type: typeId.toString(),
                              address: widget.address,
                              land_mark: landMarkController.text,
                              lat: widget.lat,
                              long: widget.lng );
                              print('result is=-----${result}');
                              print('radrees  esult is=-----${widget.address}');

                          if (result == "1") {
                            print("status --------------------- >>>>>");
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>))
                            Navigator.of(context).pop(widget.address);
                            Navigator.of(context).pop();
                          Navigator.of(context).pop();

                          } else {
                            Utils.getSnackBar(context,"something went wrong"
                                );
//Navigator.of(context).pop(widget.address);
                        //  Navigator.of(context).pop();
//Navigator.of(context).pop();             
                
                
                          }
                        }

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.yellow[900]),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                              child: Text(
                            "Save Address",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

