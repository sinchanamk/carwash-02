import 'package:flutter/material.dart';
import 'common_styles.dart';

class Utils {
  static getSizedBox({double width = double.infinity, double height = 10}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static Widget showLoading() {
    return SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        strokeWidth: 1,
      ),
    );
  }

  static Widget showErrorMessage(String errMessage) {
    return Center(child: Text(errMessage));
  }

  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              padding: EdgeInsets.only(left: 10), child: Text("Loading...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showSendingOTP(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Sending OTP...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Widget dividerThin() {
    return Divider(
      color: Colors.black,
      height: 5,
      thickness: 0.5,
    );
  }

  static showSnackBar({required BuildContext context, required String text}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: CommonStyles.whiteText12BoldW500(),
      ),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Error Occured',
          style: TextStyle(letterSpacing: 0.1, fontWeight: FontWeight.w500),
        ),
        content: Text(
          message,
          style: CommonStyles.errorTextStyleStyle(),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK!'),
          )
        ],
      ),
    );
  }

  static void getSnackBar(BuildContext context, String s) {}
}
