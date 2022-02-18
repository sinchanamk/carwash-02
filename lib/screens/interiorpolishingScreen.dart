import 'package:carzen/common/location_shared_preference.dart';
import 'package:carzen/common/utils.dart';
import 'package:carzen/model/place_service.dart';
import 'package:carzen/screens/addressScreen.dart';
import 'package:carzen/services/apiservices.dart';
import 'package:carzen/services/brand_list_provider.dart';
import 'package:carzen/widgets/appbar_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../common/common_styles.dart';
import '../widgets/pickup_location.dart';
import '../services/placeservices_provider.dart';

class InteriorPolishing extends StatefulWidget {
  final String type;
  final String typeName;
  final  addressController;
  const InteriorPolishing(
      {Key? key,
      required this.type,
      required this.typeName,
      required this.addressController});

  @override
  _InteriorPolishingState createState() => _InteriorPolishingState();
}

class _InteriorPolishingState extends State<InteriorPolishing> {
  String? SelectedCars;
  String? SelectedModels;
  List<String> models = [];
  PlaceServiceModel? placeServiceModel;
  String? selectedAddress;
   dynamic longitude;
   dynamic latitude;
  
  dynamic address;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  SharedPreference sharedPreference = SharedPreference();
  LocationPermission? permission;
  
   @override
  void initState() {
    print("------------TYPE ID--${widget.type}");

    print("------------TYPE name--${widget.typeName}");
    getBrandList();
    sharedPreference;
    print("============000000");
    _controller = VideoPlayerController.asset("assets/carwashvideo.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(2);
    _controller.play();
    if (context.read<PlaceServicesProvider>().placeServiceModel == null) {
      context.read<PlaceServicesProvider>().getService;
    }
    super.initState();
  }

  String selectedId = "";
  List<String>? brand = [];
  List<String>? id = [];

  Future getBrandList() async {
    final result = await getAPI.getBrands(widget.type);
    print("---Brand Length-----------${result!.brandList!.length}");
    setState(() {
      result.brandList!.forEach((element) {
        brand!.add(element.bikeCompanyName!);
        id!.add(element.id!);
      });
    });

    print("+++++++++++++++++    Brand Length${brand!.length}");
    return brand;
  }

  String selctedModelId = "";
  List<String>? model = [];
  List<String>? modelId = [];

  Future getModelList() async {
    final result = await getAPI.getModel(widget.type, selectedId);
    print("---Brand Length-----------${result!.modelList!.length}");
    setState(() {
      result.modelList!.forEach((element) {
        model!.add(element.bikeModel!);
        modelId!.add(element.id!);
      });
    });

    print(
        "--------------=========-=-0978766Model Length  ${model!.length}");
    return model;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isTimeSelected = false;
  bool _isDateSelected = false;
   bool _autovalidate = false;
  TimeOfDay currentTime = TimeOfDay.now();
  DateTime currentDate = DateTime.now();
  final _formkey = GlobalKey<FormState>();
 @override
  Widget build(BuildContext context) {
   final placeServicesProvider = Provider.of<PlaceServicesProvider>(context);
   print('placeServicesProvider1 is workingggpppp----------------');
   ApiServices apiServices = ApiServices();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarWidget(
            title: widget.typeName,
          )),
      body: Form(key: _formkey,
     
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          });
                        },
                        child: VideoPlayer(_controller),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
      
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: brand != null
                            ? DropdownSearch(
                                mode: Mode.BOTTOM_SHEET,
                                items: brand,
                                onChanged: (value) {  
               
                                  print(value.toString());
                                  int index =
                                      brand!.indexOf(value!.toString());
                                  print("Selected Index ID" + brand![index]);
                                  selectedId = id![index];
                                  getModelList();
                                  print("----" + selectedId);
                                },
                                validator: (value) =>
                                    value == null ? 'Please Choose Brand' : null,
                                showSearchBox: true,
                                enabled: true,
                                label: "Select Brand Name",
                              )
                            : const SizedBox(
                                width: 25,
                                height: 15,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                  ),
                                ),
                              )), //Car Models
      
                    const SizedBox(
                      height: 20,
                    ),
         
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: model != null
                          ? DropdownSearch(
                            
                              mode: Mode.BOTTOM_SHEET,
                              items: model,
                              onChanged: (value) {
                                print(value.toString());
                                int index =
                                    model!.indexOf(value!.toString());
                                print("Selected Index ID" + model![index]);
                                selctedModelId = modelId![index];
                                print("----" + selctedModelId);
                              },
                              validator: (value) =>
                                  value == null ? 'Please Choose Model' : null,
                              showSearchBox: true,
                              showClearButton: true,
                              showSelectedItems: true,
                              showAsSuffixIcons: true,
                              showFavoriteItems: true,
                              popupBarrierDismissible: true,
                              
                              enabled: true,
                              label: "Select Model Name",
                            )
                          : const SizedBox(
                              width: 25,
                              height: 15,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
      
              //Date and Time
      
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  height: 50.0,
                  width: 300.0,
                  child: ListView(
                    children: [
                      Card(
                        child: ListTile(
                          title: _isDateSelected
                               ?  Text(
                                  "${currentDate.day} / ${currentDate.month} / ${currentDate.year}")
                              : const Text("Select your Date"),
                          trailing: const Icon(
                            Icons.edit,
                            color: Colors.redAccent,
                          ),
                          leading: const Icon(
                            Icons.today,
                            color: Colors.redAccent,
                          ),
                          onTap: () {
                            _selectDate(context);


                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 5.0),
                child: SizedBox(
                  height: 50.0,
                  width: 300.0,
                  child: ListView(
                    children: [
                      Card(
                        child: ListTile(
                          title: _isTimeSelected
                              ? Text(currentTime.format(context).toString())
                              : const Text("Select your Time"),
                          trailing: const Icon(
                            Icons.edit,
                            color: Colors.redAccent,
                          ),
                          leading: const Icon(
                            Icons.schedule,
                            color: Colors.redAccent,
                          ),
                          onTap: () {
                            _selectTime(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () async {
              Utils.showLoaderDialog(context);
               permission = await Geolocator.requestPermission();
                              if (permission == LocationPermission.denied) {
                                permission = await Geolocator.requestPermission();
                                if (permission ==
                                    LocationPermission.deniedForever) {
                                  Utils.showSnackBar(
                                       context: context, text: "Oops!! Location Permission is denied",);
                                  return Future.error('Location Not Available');
                                }
                                Utils.getSnackBar(context,
                                    "Oops!! Location Permission is denied");
                              } //else {
                                // getSnackBar(
                                //    context: context, text:"Getting Locaiton");
                                final position =
                                    await Geolocator.getCurrentPosition();
              
                                         // await  SharedPreference.setValues();
                    Navigator.of(context).pop();
                       final Map<String, dynamic> currentLocation =
                                    await Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PickLocationGoogleMapsScreen(
                                                  latitude: position.latitude,
                                                  longitude: position.longitude,
                                                )));
                                setState(() {
                                    latitude = currentLocation['latitude'];
                                  longitude = currentLocation['longitude'];
                                  selectedAddress = currentLocation['address'];
                                  address = true;
                                });
                              }, child: Text('Current Address',style: CommonStyles.redText14BoldW500(),),),
                      
              Padding(
                padding: const EdgeInsets.only(left:25,right: 25,bottom: 15),
                child: Visibility(visible: selectedAddress!=null,
                  child: Column(
                      children: [
                      selectedAddress != null
                              ? Text(
                          '$selectedAddress'.toString(),
                          style: CommonStyles.black12(),
                        ):Container(child: CircularProgressIndicator(color: Color.fromARGB(255, 51, 49, 41),),),
                      ],
                    ),
                ),
              ),
                ]),
              // : Text(
              //     "Searching address......",
              //     style: TextStyle(color: Colors.black),
              //   ),

              RaisedButton(
                onPressed: () {
                  print("Brand Id ---------------- ${id}");
                  print("Brand Name ---------------- ${brand}");
                  print("Model ID ---------------- ${modelId}");
                //  print("Service ID ---------------- ${serviceId}");
                  print("Model Name ---------------- ${model}");
                  print("Selected Date---------------- ${selectDate}");
                  print("Selected Time---------------- ${selectTime}");
                  print("Selected Address---------------- ${selectedAddress}");
       
       
       apiServices.confirmBooking(//context:context, 
        brand_id: '${id}', date: '${selectDate}', time: '${selectDate}',
        landmark: "${selectedAddress}", lat: null, long: null, model_id: '${modelId}', service_id: '',
       
       )
                        .then((value) {
              //  print('dat)
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                       print("successful");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressScreen(
                                    brand: brand!.first,
                                    model: model!.first,
                                    address: widget.addressController,
                                    bookTime: selectTime.toString(),
                                    bookDate: selectDate.toString(),
                                    selectedaddress: selectedAddress.toString(),
                                  )));
                    } else {
                      print("UnSuccessfull");
                    }
                 
              });  },                   
                color: Colors.redAccent,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              
             child: const SizedBox(
                  height: 50.0,
                  child: Center(
                    child: Text(
                      "Confirm Booking",
                      style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                    ),
                  ),
                ),
               )],
          ),
        ),
      ),
    );
  }

  //time functions
  TimeOfDay? selectTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      //you may change text and input
      initialEntryMode: TimePickerEntryMode.input,
      helpText: "Choose your Time",
      confirmText: "Choose Now",
      cancelText: "Later",
    );

    //if function is to update and picked time
    if (pickedTime != null && pickedTime != currentTime) {
      setState(() {
        currentTime = pickedTime as TimeOfDay;
        _isTimeSelected = true;
      });
    }
    print("Picked Time === == = = = = = ${pickedTime}");
    selectTime = pickedTime!;
    print("Select Time === == = = = = = ${selectTime}");
  }

//date function
  DateTime? selectDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2050, 12, 31),

      //you may change text and input
      // initialEntryMode: TimePickerEntryMode.input,
      helpText: "Choose your Date",
      confirmText: "Choose Now",
      cancelText: "Later",
    );

    //if function is to update and picked time
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate as DateTime;
        _isDateSelected = true;
      });
    }
    print("Picked Date === == = = = = = ${pickedDate}");
    selectDate = pickedDate!;
    print("Select Date === == = = = = = ${selectDate}");
  }
}
