import 'package:carzen/screens/addressScreen.dart';
import 'package:carzen/screens/homescreen.dart';
import 'package:carzen/Auth/loginscreen.dart';
import 'package:carzen/services/apiservices.dart';
import 'package:carzen/services/auth_widget_builder.dart';
import 'package:carzen/services/firebase_auth_services.dart';
import 'package:carzen/services/login_api_provider.dart';
import 'package:carzen/services/placeservices_provider.dart';
import 'package:carzen/services/profile_provider.dart';
import 'package:carzen/services/profile_update.dart';
import 'package:carzen/services/service_list_provider.dart';
import 'package:carzen/services/shared_preferences.dart';
import 'package:carzen/screens/interiorpolishingScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/common_styles.dart';
import 'common/utils.dart';

Future<void> backroundHandler(RemoteMessage message) async {
  print(" This is message from background");
  print(message.notification!.title);
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backroundHandler);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SharedPreferencesProvider>(
            create: (_) => SharedPreferencesProvider()),
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        ChangeNotifierProvider<ServiceListApiProvider>(
            create: (_) => ServiceListApiProvider()),
        ChangeNotifierProvider<VerifyUserLoginAPIProvider>(
            create: (_) => VerifyUserLoginAPIProvider()),
        ChangeNotifierProvider<ProfileApiResponseProvider>(
            create: (_) => ProfileApiResponseProvider()),
             ChangeNotifierProvider<ProfileApiResponseUpdateProvider>(
            create: (_) => ProfileApiResponseUpdateProvider()),
        ChangeNotifierProvider<PlaceServicesProvider>(
            create: (_) => PlaceServicesProvider()),
      ],
      child: AuthWidgetBuilder(
          builder: (context, AsyncSnapshot<LoggedInUser?> loggedInUser) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          routes: {
            'Address': (context) => AddressScreen(),
            'Interiorpolishing': (context) => InteriorPolishing(
                  type: '',
                  typeName: '', addressController: null,
              
                ),
          },
          home: LoginCheck(loginSnapshot: loggedInUser),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}

class LoginCheck extends StatefulWidget {
  const LoginCheck({Key? key, required this.loginSnapshot}) : super(key: key);

  final AsyncSnapshot<LoggedInUser?> loginSnapshot;

  @override
  State<LoginCheck> createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  @override
  void initState() {
    super.initState();
    // ApiServices.userId="1";
  }

  @override
  Widget build(BuildContext context) {
    print("the is logged in +++++   " + widget.loginSnapshot.toString());

    if (widget.loginSnapshot.connectionState == ConnectionState.waiting) {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              const CircularProgressIndicator(
                strokeWidth: 0.5,
                color: Colors.blue,
              ),
              Text(
                'Loading',
                style: CommonStyles.blueText12BoldW500(),
              )
            ],
          ),
        ),
      );
    } else {
      if (widget.loginSnapshot.data != null) {
        // final sharedPreferencesProvider =
        //   Provider.of<SharedPreferencesProvider>(context, listen: false);
        // ApiServices.userId=sharedPreferencesProvider.profileuserId;
        // print('ApiServices userId----+${ApiServices.userId}');
        // LoginUsingUserId();
          //  final sharedPreferencesProvider =
          //   Provider.of<SharedPreferencesProvider>(context, listen: false);
        // sharedPreferencesProvider.getUserId();
       ApiServices.userId="1";
      // return const HomeScreen();
       return LoginUsingUserId();
      }
      return const LoginScreen();
    }
    // return VerifyScreen(phoneNumber: "123123123");
    // return VerifyScreen();
  }
}

class LoginUsingUserId extends StatefulWidget {
  const LoginUsingUserId({Key? key}) : super(key: key);

  @override
  _LoginUsingUserIdState createState() => _LoginUsingUserIdState();
}

class _LoginUsingUserIdState extends State<LoginUsingUserId> {
  @override
  void initState() {
    final loggedInUser = Provider.of<LoggedInUser>(context, listen: false);
    print("asdfasdfasdfasd" +
        loggedInUser.phoneNo.substring(3, loggedInUser.phoneNo.length));
    if (context.read<VerifyUserLoginAPIProvider>().loginResponse == null) {
      context
          .read<VerifyUserLoginAPIProvider>()
          .getUser(
              deviceToken: "deviceToken", userFirebaseID: context.read<LoggedInUser>().uid,
              phoneNumber: loggedInUser.phoneNo
                  .substring(3, loggedInUser.phoneNo.length),)
          .then((value) {
        setUserID();
        print("User id assigned for user  - - -- - - " +
            context
                .read<VerifyUserLoginAPIProvider>()
                .loginResponse!
                .userDetails!
                .id);
      });
    }
    super.initState();
  }

  setUserID() async {
    // await SharedPreferences.getInstance().then((value) {
    //   value.setString(
    //       "userID",
    //       context
    //           .read<VerifyUserLoginAPIProvider>()
    //           .loginResponse!
    //           .userDetails!
    //           .id!);
    // });
    ApiServices.userId = context
        .read<VerifyUserLoginAPIProvider>()
        .loginResponse!
        .userDetails!
        .id;
  }

  @override
  Widget build(BuildContext context) {
    final verifyLoginApi = Provider.of<VerifyUserLoginAPIProvider>(context);
    return  Scaffold(
      body: Center(
          child: 
          verifyLoginApi.isLoading
               ? ifLoading()
          //     : verifyLoginApi.error
          //         ? Utils.showErrorDialog(context, verifyLoginApi.errorMessage)
          //         : verifyLoginApi.loginResponse!.status == "0"
          //             ? Utils.showErrorDialog(
          //                 context, verifyLoginApi.loginResponse!.message)
                       :
                       HomeScreen()),
    );
  }

  ifLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          strokeWidth: 0.5,
          color: Colors.blue,
        ),
        Utils.getSizedBox(height: 10),
        Text(
          'Loading',
          style: CommonStyles.blueText12BoldW500(),
        )
      ],
    );
  }
}
