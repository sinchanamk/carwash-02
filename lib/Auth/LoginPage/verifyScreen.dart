import 'dart:async';
import 'package:carzen/common/common_styles.dart';
import 'package:carzen/common/rounded_button.dart';
import 'package:carzen/common/screen_width_and_height.dart';
import 'package:carzen/common/utils.dart';
import 'package:carzen/screens/homescreen.dart';
import 'package:carzen/services/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../main.dart';
class VerifyScreen extends StatefulWidget {
  final String phoneNumber;
  const VerifyScreen({required this.phoneNumber, Key? key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final controller = TextEditingController();

  final String _comingSms = 'Unknown';

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  void initState() {
    initializeMessage();
    _listenOTP();
    super.initState();
  }

  _listenOTP() async {
    await SmsAutoFill().listenForCode();
    // final signature = await SmsAutoFill().getAppSignature;
    // print("The app signature is  - - -- - - - " + signature);
  }

  // Future<void> initSmsListener() async {
  //   String comingSms;
  //   try {
  //     comingSms = await AltSmsAutofill().listenForSms;
  //   } on PlatformException {
  //     comingSms = 'Failed to get Sms.';
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _comingSms = comingSms;
  //     print("====>Message: ${_comingSms}");
  //     print("${_comingSms[32]}");
  //     textEditingController1.text = _comingSms[32] +
  //         _comingSms[33] +
  //         _comingSms[34] +
  //         _comingSms[35] +
  //         _comingSms[36] +
  //         _comingSms[
  //             37]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
  //   });
  // }

  initializeMessage() async {}

  final key = GlobalKey<FormState>();

  showSnackBar(msg, color, context) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content:  Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration:  const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        elevation: 3.0,
        backgroundColor: color,
      ),
    );
  }

  String _code = "";
  String signature = "{{ app signature }}";

  Future verifyOTP(BuildContext context) async {
    print("verify otp called");
    try {
      await Provider.of<FirebaseAuthService>(context, listen: false)
          .verifyOTP(controller.text.toString())
          .then((_) {
            
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const  LoginUsingUserId()));
      }).catchError((e) {
        String errorMsg = 'Cant authentiate you Right now, Try again later!';
        if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
          errorMsg = "Session expired, please resend OTP!";
        } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
          errorMsg = "You have entered wrong OTP!";
        }
        Utils.showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      Utils.showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(0xffebebeb)));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
        leading: Row(
          children: const [
            SizedBox(
              height: 50,
              width: 50,
              child: InkWell(
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.black,
                ),
              ),
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
        title: Text(
          "OTP Verification",
          style: CommonStyles.blackw54s20Thin(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: deviceHeight(context),
            child: Column(
              children: [
                // Align(
                //     alignment: Alignment.centerLeft,
                //     child: Padding(
                //       padding: const EdgeInsets.all(10.0),
                //       child: Text(
                //         'PickUp',
                //         style: Theme.of(context).textTheme.headline6,
                //       ),
                //     )),
                Utils.getSizedBox(height: 50),
                Column(
                  children: [
                    Text("We have sent a verification code to",
                        style: CommonStyles.otpVerificationMessage()),
                    Text(
                      "+91 ${widget.phoneNumber}",
                      style: CommonStyles.otpVerificationMessage(),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.33,
                //   alignment: Alignment.centerLeft,
                //   padding: EdgeInsets.all(15),
                //   child: Text(
                //     'Please enter 6 digit verification code sent to your mobile number',
                //     style: CommonStyles.enterYourNumberTextStyle(),
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: PinFieldAutoFill(
                    // smsCodeRegexPattern: ,
                    decoration: UnderlineDecoration(
                        textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                        colorBuilder:
                            FixedColorBuilder(Colors.black.withOpacity(0.3)),
                        gapSpace: 10),
                    currentCode: _code,

                    onCodeSubmitted: (code) async {
                      print("Code submittd =++++_---------___- -  - - - -+");
                      verifyOTP(context);
                    },

                    onCodeChanged: (code) {
                      print(code);
                      controller.text = code.toString();
                      print(controller.text);
                      if (code!.length == 6) {
                        // FocusScope.of(context).requestFocus(FocusNode());
                        verifyOTP(context);
                      }
                    },
                  ),
                ),
                // Spacer(),
                Utils.getSizedBox(height: 12),
                ResendOTPTimer(phoneNumber: widget.phoneNumber,),
                Utils.getSizedBox(height: 12),
                RoundedButton(
                  title: 'Verify OTP',
                  onpressed: () async {
                    verifyOTP(context);
                  },
                ),
                // TextFieldPinAutoFill(
                //   currentCode: _code,
                // ),
                // Spacer(),
                // ElevatedButton(
                //   child: Text('Listen for sms code'),
                //   onPressed: () async {
                //     await SmsAutoFill().listenForCode;
                //   },
                // ),
                // ElevatedButton(
                //   child: Text('Set code to 123456'),
                //   onPressed: () async {
                //     setState(() {
                //       _code = '123456';
                //     });
                //   },
                // ),
                // SizedBox(height: 8.0),
                // Divider(height: 1.0),
                // SizedBox(height: 4.0),
                // Text("App Signature : $signature"),
                // SizedBox(height: 4.0),
                // ElevatedButton(
                //   child: Text('Get app signature'),
                //   onPressed: () async {
                //     signature = await SmsAutoFill().getAppSignature;
                //     setState(() {});
                //   },
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Navigator.of(context).push(MaterialPageRoute(builder: (_) => CodeAutoFillTestPage()));
                //   },
                //   child: Text("Test CodeAutoFill mixin"),
                // )
                // Align(
                //   alignment: Alignment.center,
                //   child: Form(
                //     key: key,
                //     child: UserTextField(
                //       titleLabel: 'Enter 6 digit Code',
                //       maxLength: 6,
                //       icon: Icons.dialpad,
                //       controller: controller,
                //       inputType: TextInputType.phone,
                //     ),
                //   ),
                // ),
                // ,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ResendOTPTimer extends StatefulWidget {
  const ResendOTPTimer({ Key? key, required this.phoneNumber }) : super(key: key);
  final String phoneNumber;

  @override
  _ResendOTPTimerState createState() => _ResendOTPTimerState();
}

class _ResendOTPTimerState extends State<ResendOTPTimer> {
   @override
  void initState() {
  startTimer();
  }
  @override
  void dispose(){
  _timer!.cancel();
  
  }
  Timer? _timer;
  int _start = 60;

  void startTimer() {
    const oneSec =  Duration(seconds: 1);
    _timer =  Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return   Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextButton(
                          onPressed: _start != 0
                              ? () {
                                  context
                                      .read<FirebaseAuthService>()
                                      .signInWithPhoneNumber("+91",
                                          "+91" + widget.phoneNumber, context);
                                }
                              : () {
                                  Utils.showSnackBar(
                                      context: context,
                                      text:
                                          "Please wait for process to complete.");
                                },
                          child: _start != 0
                              ? Text(
                                  'Resend OTP in ' + _start.toString(),
                                  style: CommonStyles.blue12thin(),
                                )
                              : Text(
                                  "Resend OTP",
                                  style: CommonStyles.blue12thin(),
                                )),
                    )
                  ],
                );
              
  }
}

class CodeAutoFillTestPage extends StatefulWidget {
  const CodeAutoFillTestPage({Key? key}) : super(key: key);

  @override
  _CodeAutoFillTestPageState createState() => _CodeAutoFillTestPageState();
}

class _CodeAutoFillTestPageState extends State<CodeAutoFillTestPage>
    with CodeAutoFill {
  String? appSignature;
  String? otpCode;

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle =  TextStyle(fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        title:const Text("Listening for code"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Text(
              "This is the current app signature: $appSignature",
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Builder(
              builder: (_) {
                if (otpCode == null) {
                  return Text("Listening for code...", style: textStyle);
                }
                return Text("Code Received: $otpCode", style: textStyle);
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
