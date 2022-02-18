import 'package:carzen/screens/homescreen.dart';
import 'package:carzen/Auth/loginscreen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController nameTextEditingController = TextEditingController();
  final nameKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  final emailKey = GlobalKey<FormState>();
  TextEditingController phoneTextEditingController = TextEditingController();
  final phoneKey = GlobalKey<FormState>();
  TextEditingController passwordTextEditingController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 45.0,
              ),
              const Image(
                image: AssetImage("assets/carbike.jpg"),
                width: 280.0,
                height: 200.0,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 1.0,
              ),
              const Text(
                "Register",
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
                    Form(
                      key: nameKey,
                      child: TextFormField(
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Form(
                      key: emailKey,
                      child: TextFormField(
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    Form(
                      key: phoneKey,
                      child: TextFormField(
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "Phone",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextFormField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Enter OTP",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      child: const SizedBox(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Get OTP",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text(
                  "Already have an Account? Login Here",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
