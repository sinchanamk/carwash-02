import 'dart:ui';

import 'package:carzen/common/common_styles.dart';
import 'package:carzen/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/location_shared_preference.dart';

class AddressScreen extends StatefulWidget {
   AddressScreen({Key? key,  this.brand, this.model, this.bookDate,
   this.bookTime, this.address, this.email, this.selectedaddress}) : super(key: key);
  final String? brand;
  final String? model;
  final String? bookDate;
  final String? bookTime;
  final String? address;
  final String? email;
  final String? selectedaddress;
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carzen"),
      ),

      body: Column(
        children: [
           Utils.getSizedBox(height: 20),
           
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:60),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      
                      Card(child: Text('Vehicle Brand'.toUpperCase(),style: CommonStyles.redText16BoldW500(),)),
                      Card(
                        child: Text('${widget.brand}'.toUpperCase(),
                        style: CommonStyles.blueText16BoldW500()),
                      )
                    ],
                  ),
                ),
             
            Utils.getSizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             Card(child: Text('Vehicle Model'.toUpperCase(),style: CommonStyles.redText16BoldW500(),)),
             // Text('Pulsar Ns', style: CommonStyles.blue12thin()),
            Card(child: Text("${widget.model}".toUpperCase(), style: CommonStyles.blueText16BoldW500())),
            ],),
                     Utils.getSizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Card(child: 
                Text('Total Price'.toUpperCase(),style: CommonStyles.redText16BoldW500(),),),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.rupeeSign,size: 15,color: Colors.green,), 
                      Text('1500', style: CommonStyles.blueText16BoldW500())
                   
                    ],
                  ),
                    
              
             ] ),           
                
                     // Text('10:00', style: CommonStyles.blue12thin())
                   //  Card(child: Text('${widget.bookTime}'.toUpperCase(), style: CommonStyles.blueText16BoldW500())),
                    ],),
                   Utils.getSizedBox(height: 10),
              
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Card(child: Text('Book Location'.toUpperCase(),style: CommonStyles.redText16BoldW500(),)),
            Padding(
            padding: const EdgeInsets.only(left:18,right: 18),
            child: Card(child: Text('${widget.selectedaddress}', style: CommonStyles.blueText16BoldW500())),
            ),
                     Utils.getSizedBox(height: 10),
            
      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
            Card(child: Text('Book Date'.toUpperCase(),style: CommonStyles.redText16BoldW500(),)),
            //Text('12/2/2022', style: CommonStyles.blue12thin())
            Card(child: Text('${widget.bookDate}', style: CommonStyles.blueText16BoldW500())),
                   ],),
            Utils.getSizedBox(height: 10),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Card(child: Text('Book Time'.toUpperCase(),style: CommonStyles.redText16BoldW500(),)),
                     // Text('10:00', style: CommonStyles.blue12thin())
                     Card(child: Text('${widget.bookTime}'.toUpperCase(),
                      style: CommonStyles.blueText16BoldW500())),
                    ],),
           
      ],),
         
      SizedBox(height: 60.0,),
          RaisedButton(
            color: Colors.redAccent,
            textColor: Colors.white,
            child: const SizedBox(
              height: 40.0,
              child: Center(
                child: Text(
                  "Pay Now",
                  style: TextStyle(
                      fontSize: 18.0, fontFamily: "Brand Bold"),
                ),
              ),
            ),
            shape:  RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(18.0),
            ),
            onPressed: () {
              Fluttertoast.showToast(msg: "Your Payment is done Successfully");
            },
          ),
        
    ]));
  }
}
