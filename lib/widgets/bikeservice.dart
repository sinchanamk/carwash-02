// import 'package:carzen/common/location_shared_preference.dart';
// import 'package:carzen/screens/addressScreen.dart';
// import 'package:carzen/services/apiservices.dart';
// import 'package:carzen/services/placeservices_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';

// import '../services/brand_list_provider.dart';

// class BikeService extends StatefulWidget {
//   final String type;
//    final String? brand;
//   final String? model;
//   final String? bookDate;
//   final String? bookTime;
//   final String? email;
//   final String? address;
//   const BikeService({Key? key, required this.type, this.brand, this.model, this.bookDate, this.bookTime, this.email, this.address}) : super(key: key);
//   @override
//   _BikeServiceState createState() => _BikeServiceState();
// }

// class _BikeServiceState extends State<BikeService> {
 
//   final List<String> Bikes = [
//     "Tvs",
//     "Hero",
//     "Bajaj",
//     "Honda",
//     "Jawa",
//     "Royal Enfield",
//     "Yamaha",
//     "Suzuki",
//     "KTM",
//     "Mahindra",
//     "Harley Davidson",
//     "Ducati"
//   ];
//   String? SelectedBikes;
//   String? SelectedModels;
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   SharedPreference sharedPreference = SharedPreference();

//   @override
//   void initState() {
//     print("------------BikeService TYPE ID--${widget.type}");
//     //  getBrandList();
//        sharedPreference;
//     _controller = VideoPlayerController.asset("assets/carwashvideo.mp4");
//     _initializeVideoPlayerFuture = _controller.initialize();
//     _controller.setLooping(true);
//     _controller.setVolume(2);
//     _controller.play();
//     super.initState();
//   }

//   String selectedId = "";
//   List<String>? brand_name = [];
//   List<String>? id = [];

//   Future getBrandList() async {
//     final result = await getAPI.getBrands(widget.type);
//     print("---BikeService Brand Length-----------${result!.brandList!.length}");
//     setState(() {
//       result.brandList!.forEach((element) {
//         brand_name!.add(element.bikeCompanyName!);
//         id!.add(element.id!);
//       });
//     });

//     print("+++++++++++++++++ BikeService   Brand Length${brand_name!.length}");
//     return brand_name;
//   }

//   String selctedModelId = "";
//   List<String>? model_name = [];
//   List<String>? modelId = [];

//   Future getModelList() async {
//     final result = await getAPI.getModel(widget.type, selectedId);
//     print("--- BikeService Model Length-----------${result!.modelList!.length}");
//     setState(() {
//       result.modelList!.forEach((element) {
//         model_name!.add(element.bikeModel!);
//         modelId!.add(element.id!);
//       });
//     });
//     print(
//         "--------------=========-=-Bike Model Length  ${model_name!.length}");
//     return model_name;
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   bool _isTimeSelected = false;
//   bool _isDateSelected = false;
//   TimeOfDay currentTime = TimeOfDay.now();
//   DateTime currentDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     final placeServicesProvider = Provider.of<PlaceServicesProvider>(context);
//     final placeServicesDetails =
//         placeServicesProvider.placeServiceModel!.userDetails;
//     ApiServices apiServices = ApiServices();
//      final brandController = TextEditingController();
//   final modelController = TextEditingController();
//   final dateController = TextEditingController();
//   final timeController = TextEditingController();
//   final addresscontroller = TextEditingController();
//   final emailController = TextEditingController();
//    @override
//   void dispose() {
//     super.dispose();
//     brandController.clear();
//     modelController.clear();
//     dateController.clear();
//     timeController.clear();
//     addresscontroller.clear();
//     emailController.clear();
//   }
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Bike Service"),
//         ),
//         body: SingleChildScrollView(
//             child: Column(children: [
//           FutureBuilder(
//             future: _initializeVideoPlayerFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (_controller.value.isPlaying) {
//                           _controller.pause();
//                         } else {
//                           _controller.play();
//                         }
//                       });
//                     },
//                     child: VideoPlayer(_controller),
//                   ),
//                 );
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 25.0),
//             child: Column(
//               children: [
//                 DropdownButton<String>(
                  
//                   borderRadius: BorderRadius.circular(10),
//                   hint: const Text(
//                     "Select Bikes",
//                     style: TextStyle(fontFamily: "Brand-Bold"),
//                   ),
//                   isExpanded: true,
//                   value: SelectedBikes,
//                   items: Bikes.map((e) {
//                     return DropdownMenuItem<String>(
//                       value: e,
//                       child: Text("$e"),
//                     );
//                   }).toList(),
//                   onChanged: (val) {
//                     setState(() {
//                       SelectedBikes = val;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10.0),
//             child: SizedBox(
//               height: 50.0,
//               width: 300.0,
//               child: ListView(
//                 children: [
//                   Card(
//                     child: ListTile(
//                       title: _isDateSelected
//                           ? Text('${placeServicesDetails!.bookDate}')
//                           //Text("${currentDate.day} / ${currentDate.month} / ${currentDate.year}")
//                           : const Text("Select your Date"),
//                       trailing: const Icon(
//                         Icons.edit,
//                         color: Colors.redAccent,
//                       ),
//                       leading: const Icon(
//                         Icons.today,
//                         color: Colors.redAccent,
//                       ),
//                       onTap: () {
//                         _selectDate(context);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 15.0, left: 5.0),
//             child: SizedBox(
//               height: 50.0,
//               width: 300.0,
//               child: ListView(
//                 children: [
//                   Card(
//                     child: ListTile(
//                       title: _isTimeSelected
//                           ? Text(
//                               "${placeServicesDetails!.bookTime}") //Text(currentTime.format(context).toString())
//                           : const Text("Select your Time"),
//                       trailing: const Icon(
//                         Icons.edit,
//                         color: Colors.redAccent,
//                       ),
//                       leading: const Icon(
//                         Icons.schedule,
//                         color: Colors.redAccent,
//                       ),
//                       onTap: () {
//                         _selectTime(context);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 100.0,
//           ),
//           RaisedButton(
//             onPressed: () {
//               print("Brand Id ---------------- ${placeServicesDetails!.id}");
//                print("Model ID ---------------- ${placeServicesDetails.brand}");
//               print("Model ID ---------------- ${placeServicesDetails.id}");
//               print("Model Name ---------------- ${placeServicesDetails.model}");
//               print("Selected Date---------------- ${placeServicesDetails.bookDate}");
//               print("Selected Time---------------- ${placeServicesDetails.bookTime}");
//  apiServices.confirmBooking(context, placeServicesDetails.id,
//                   placeServicesDetails.brand,
//                   placeServicesDetails.model,
//                   placeServicesDetails.bookDate,
//                   placeServicesDetails.bookTime,
//                   placeServicesDetails.address,
//                   placeServicesDetails.email,
//                   SharedPreference.latitudeValue,
//                   SharedPreference.longitudeValue,)
//                   .then((value) {
              
//               //  .then((value) {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>  AddressScreen(  
//                        )));
//             },);},
//             color: Colors.redAccent,
//             textColor: Colors.white,
//             child: const SizedBox(
//               height: 50.0,
//               child: Center(
//                 child: Text(
//                   "Confirm Booking",
//                   style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
//                 ),
//               ),
//             ),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(24.0),
//             ),
//           ),
//         ])));
//   }

//   //time functions
//   TimeOfDay? selectTime;

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: currentTime,

//       //you may change text and input
//       initialEntryMode: TimePickerEntryMode.input,
//       helpText: "Choose your Time",
//       confirmText: "Choose Now",
//       cancelText: "Later",
//     );

//     //if function is to update and picked time
//     if (pickedTime != null && pickedTime != currentTime) {
//       setState(() {
//         currentTime = pickedTime;
//         _isTimeSelected = true;
//       });
//     }
//     print("Picked Time === == = = = = = ${pickedTime}");
//     selectTime = pickedTime!;
//     print("Select Time === == = = = = = ${selectTime}");
//   }

// //date function
//   DateTime? selectDate;

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: currentDate,
//       firstDate: DateTime(2022, 1, 1),
//       lastDate: DateTime(2050, 12, 31),

//       //you may change text and input
//       // initialEntryMode: TimePickerEntryMode.input,
//       helpText: "Choose your Date",
//       confirmText: "Choose Now",
//       cancelText: "Later",
//     );

//     //if function is to update and picked time
//     if (pickedDate != null && pickedDate != currentDate) {
//       setState(() {
//         currentDate = pickedDate as DateTime;
//         _isDateSelected = true;
//       });
//     }
//     print("Picked Date === == = = = = = ${pickedDate}");
//     selectDate = pickedDate!;
//     print("Select Date === == = = = = = ${selectDate}");
//   }
// }
