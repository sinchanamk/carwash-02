import 'package:carzen/Auth/registerscreen.dart';
import 'package:carzen/common/utils.dart';
import 'package:carzen/services/firebase_auth_services.dart';
import 'package:carzen/services/login_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../services/apiservices.dart';
import 'LoginPage/verifyScreen.dart';

enum MobileVerificationState {
  // ignore: constant_identifier_names
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  verifyPhone(BuildContext context) async {
   

    final firebaseAuthServiceProvider =
        Provider.of<FirebaseAuthService>(context, listen: false);

    print("The phone number is  - -- - " + phoneController.text);

    try {
      Utils.showSendingOTP(context);
  
      await firebaseAuthServiceProvider
          .signInWithPhoneNumber(
              "+91", "+91" + phoneController.text.toString(), context,
              pushWidget: const LoginUsingUserId())
          .then((value) => () {})
          .catchError((e) {
        print("eroor" + e.toString());
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }
        Utils.showErrorDialog(context, errorMsg);
      });
      Navigator.of(context).pop(); 
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerifyScreen(
                phoneNumber: phoneController.text,
              )));
    } catch (e) {
      Utils.showErrorDialog(context, e.toString());
    }
  }

  final phoneController = TextEditingController();
  final phoneKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  bool showLoading = false;

  getMobileFormWidget(context) {
    final verifyUserLoginAPIProvider =
        Provider.of<VerifyUserLoginAPIProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const Image(
              image: AssetImage("assets/carbike.jpg"),
              width: 350.0,
              height: 250.0,
            ),
            const SizedBox(
              height: 1.0,
            ),
            Text(
              "Login",
              style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 24.0,
                  fontFamily: "Brand Bold"),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 1.0,
                  ),
                  Form(
                    key: phoneKey,
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          return "Enter a valid Phone Number";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                          fontSize: 15.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FlatButton(
                      onPressed: () {
                       // final sharedPreferencesProvider =
                            // Provider.of<SharedPreferencesProvider>(context,
                            //     listen: false);

                         if (phoneKey.currentState!.validate()) {
                        /// if (verifyUserLoginAPIProvider.error) {
                        //         Navigator.of(context).pop();
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(SnackBar(
                        //                 behavior: SnackBarBehavior.floating,
                        //                 content: Text(
                        //                   "Something went wrong!!",
                        //                   style: CommonStyles.whiteText12BoldW500(),
                        //                 )));
                        //       } else if (verifyUserLoginAPIProvider
                        //               .loginResponse!.status ==
                        //           '0') {
                        //  Navigator.of(context).pop();

                        verifyPhone(context);
                        //  sharedPreferencesProvider.isUserLoggedIn = true;
                        //       sharedPreferencesProvider.userId =
                        //           verifyUserLoginAPIProvider
                        //               .loginResponse!.userDetails!.id!;
                        //       ApiServices.userId = verifyUserLoginAPIProvider
                        //           .loginResponse!.userDetails!.id;

                        ApiServices.userId = "1";
                       } },

                      /*     Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OTPScreen()));*/

                      child: const Text("GET OTP"),
                      color: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              child: const Text(
                "Do not have an Account? Register Here",
              ),
            ),
          ],
        ),
      ),
    );
  }

  getOtpFormWidget(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          const Image(
            image: AssetImage("images/hydee.jpeg"),
            width: 350.0,
            height: 250.0,
          ),
          const SizedBox(
            height: 1.0,
          ),
          const Text(
            "Rider Login",
            style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 1.0,
                ),
                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Enter OTP",
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                    ),
                  ),
                  style: const TextStyle(fontSize: 15.0),
                ),
                const SizedBox(
                  height: 1.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    onPressed: () async {},
                    child: const Text("VERIFY"),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: showLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context),
    );
  }
}
