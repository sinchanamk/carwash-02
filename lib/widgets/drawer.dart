import 'package:carzen/screens/homescreen.dart';
import 'package:carzen/screens/notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Auth/loginscreen.dart';
import '../common/utils.dart';
import '../screens/profile.dart';
import '../services/profile_provider.dart';
import 'dividerwidget.dart';
class DrawerWidget extends StatefulWidget {
  const DrawerWidget({ Key? key }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

     @override
  void initState() {
  initialize();
    super.initState();
  }

  initialize() async {
    if (context.read<ProfileApiResponseProvider>().profileResponseModel== null) {
      await context.read<ProfileApiResponseProvider>().fetchData;
    }
   }

  @override
  Widget build(BuildContext context) {
      final userProfileProvider =
        Provider.of<ProfileApiResponseProvider>(context);
          print("=============-------------------Work");
    print("=============----------2222222---------Work");
     if (userProfileProvider.showLoading) {
      print("Loading Details");
      return Center(
        child: Utils.showLoading(),
      );
    } else if (userProfileProvider.error) {
      print("Error Found");

      return Utils.showErrorMessage(userProfileProvider.errorMessage);
    } else if (userProfileProvider.profileResponseModel!= null &&
        userProfileProvider.profileResponseModel!.status == '0') {
      print("Status is 0");

      return Utils.showErrorMessage(
          userProfileProvider.profileResponseModel!.message);
    } else {
      print("Success Status");

      return body();
    }
  }
 
  body(){
     final userProfileProvider =
        Provider.of<ProfileApiResponseProvider>(context);
    
     final userprofileDetails = userProfileProvider.profileResponseModel!;
 //("userprofileDetails${userprofileDetails.userDetails!.email}");
    return  Drawer(
          child: ListView(
            children: [
              // Drawer Header
              SizedBox(
                height: 165.0,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset("assets/user_icon.png", height: 65.0, width: 65.0,),
                      const SizedBox(width: 16.0,),
                       InkWell(onTap: (){
                       
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        ProfileScreen()));
                    
                       },
                         child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Text(userprofileDetails.userDetails!.firstName, style: TextStyle(fontSize: 16.0, fontFamily: "Brand-Bold"),),
                              SizedBox(height: 6.0,),
                              Text("Visit Profile"),
                            ],
                          ),
                       ),
                      
                    ],
                  ),
                ),
              ),

               const DividerWidget(),

              const SizedBox(height: 30.0,),

              //Drawer Body Controllers
            
            ListTile(
                leading:const Icon(Icons.person),
                title:const Text("Visit Profile", style: TextStyle(fontSize: 16.0),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                   ProfileScreen()));
                },
              ),

              ListTile(
                leading:const Icon(Icons.info),
                title:const Text("Services", style: TextStyle(fontSize: 15.0),),
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                },
              ),
               ListTile(
                leading:const Icon(Icons.notifications),
                title:const Text("Notification", style: TextStyle(fontSize: 15.0),),
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationScreen()));
                },
              ),
              ListTile(
                leading:const Icon(Icons.logout),
                title:const Text("Logout", style: TextStyle(fontSize: 15.0),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
              ),

            ],
          ),
        );
  }
  }