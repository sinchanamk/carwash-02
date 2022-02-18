import 'package:carzen/common/common_styles.dart';
import 'package:carzen/services/apiservices.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../services/local_notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  ApiServices apiServices = ApiServices();
  String notificationMsg = "";
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);

    LocalNotificationService.initialize(context);

    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          notificationMsg =
              "${event.notification!.title} ${event.notification!.body}";
        });
      }
    });

    // Foregrand State
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body}";
      });
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notificationMsg =
            "${event.notification!.title} ${event.notification!.body} ";
      });
    });
  }

  bool onlineStatus = false;
  @override
  Widget build(BuildContext context) {
    //  FirebaseMessaging messaging = FirebaseMessaging.instance;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: Text('Notifications'),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top:280),
          child: SizedBox(height: 50,width: MediaQuery.of(context).size.width,
            child: Card(
              child: Column(
                children: [
                  Text('Notifications'),
                  Text( notificationMsg,
                                                  style: CommonStyles.enterYourNumberTextStyle(),
                                                  textAlign: TextAlign.center,
                                                ),
                ],
              ),
            ),
          ),
        ),
                                  
                               
    ));
  }
}
