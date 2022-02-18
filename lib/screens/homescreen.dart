import 'package:carzen/screens/data.dart';
import 'package:carzen/screens/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import '../common/utils.dart';
import '../services/service_list_provider.dart';
import '../widgets/drawer.dart';
import 'interiorpolishingScreen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    if (context.read<ServiceListApiProvider>().serviceListModel == null) {
      context.read<ServiceListApiProvider>().getService();
    }
    super.initState();
  }

  String vechileType = "";
  String typeId = "";
  @override
  Widget build(BuildContext context) {
 final serviceListApi = Provider.of<ServiceListApiProvider>(context);
    print("=============-------------------Work");
    print("=============----------2222222---------Work");
     if (serviceListApi.ifLoading) {
      print("Loading Details");
      return Center(
        child: Utils.showLoading(),
      );
    } else if (serviceListApi.error) {
      print("Error Found");

      return Utils.showErrorMessage(serviceListApi.errormessage);
    } else if (serviceListApi.serviceListModel != null &&
        serviceListApi.serviceListModel!.status == '0') {
      print("Status is 0");

      return Utils.showErrorMessage(
          serviceListApi.serviceListModel!.message!);
    } else {
      print("Success Status");

      return body();
    }
  }
  
  body(){ final serviceListApi =
        Provider.of<ServiceListApiProvider>(context);
  
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Carzen")),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
            },
            icon: const Icon(
              Icons.notifications,
            ),
          ),
          
        ]),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: DrawerWidget(),
      ),
      body:serviceListApi.ifLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ))
                        :  Column(
        children: [
          SizedBox(
            height: 220,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Swiper(
                autoplay: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  );
                },
                viewportFraction: 0.8,
                scale: 0.9,
                pagination: const SwiperPagination(),
              ),
            ),
          ),
          const Padding(
            padding:  EdgeInsets.only(top: 25.0, left: 0.0),
            child: Text(
              "Carzen",
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.redAccent),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              itemCount:serviceListApi.serviceListModel!.serviceList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                
              ),
              itemBuilder: (BuildContext context, int index) {
                print("len Work");
                return InkWell(
                  onTap: () async{
                  
                    vechileType = serviceListApi
                        .serviceListModel!.serviceList![index].id
                        .toString();

                    typeId = serviceListApi
                        .serviceListModel!.serviceList![index].type
                        .toString();

                    print(
                        "-------id-----${serviceListApi.serviceListModel!.serviceList![index].id}");
                    print("-------vechile id  =---090 id-----${vechileType}");
                    print("-------Type Id  =---090 id-----${typeId}");
                    print(
                        "-------Type-----${serviceListApi.serviceListModel!.serviceList![index].type}");

                  await  Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InteriorPolishing(
                              type: typeId,
                              typeName: "${serviceListApi.serviceListModel!.serviceList![index].serviceName}", addressController: null,
                            )));
                          
                  },
                  child: Card(
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 5,
                    child:
                     serviceListApi.ifLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ))
                        :
                         Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:  [
                               Image.network("${serviceListApi.serviceListModel!.vehicleUrl}+ ${serviceListApi.serviceListModel!.serviceList![index].image}",
                        
                              ),
                              Padding(
                                padding:  const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  "${serviceListApi.serviceListModel!.serviceList![index].serviceName}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 22.0,
                                      fontFamily: "Brand Bold",
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                  ),
                );
              },
            ),
          )
        ]));}
  }