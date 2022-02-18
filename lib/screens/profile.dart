import 'package:carzen/common/utils.dart';
import 'package:carzen/services/profile_update.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../common/common_styles.dart';
import '../services/apiservices.dart';
import '../services/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    initialize();
    if (context.read<ProfileApiResponseUpdateProvider>().profileResponseModel ==
        null) {
      context.read<ProfileApiResponseUpdateProvider>().fetchData;
    }
    super.initState();
  }

  final nameController = TextEditingController();
  final email = TextEditingController();
  final mobileController = TextEditingController();

  initialize() {
    if (context.read<ProfileApiResponseProvider>().profileResponseModel ==
        null) {
      context.read<ProfileApiResponseProvider>().fetchData;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider =
        Provider.of<ProfileApiResponseProvider>(context);
    final userprofileDetails = userProfileProvider.profileResponseModel!;
    mobileController.text = userProfileProvider.profileResponseModel!.userDetails!.mobile;
    nameController.text = userProfileProvider.profileResponseModel!.userDetails!.firstName;
  email.text = userProfileProvider.profileResponseModel!.userDetails!.email;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(80.0), // here the desired height
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: AppBar(
                centerTitle: true,
                title: const Text('My Profile'),
                actions: [
                  _profileUpdate(context),
                ]),
          )),
      body: userProfileProvider.showLoading ? uninitializedBody() : body(),
    );
  }

  Widget uninitializedBody() {
    return const Center(
        child: SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        strokeWidth: 1,
      ),
    ));
  }

  Widget body() {
    final userProfileProvider =
        Provider.of<ProfileApiResponseProvider>(context);
    final userprofileDetails = userProfileProvider.profileResponseModel!;
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          Card(
            elevation: 10,
            color: const Color.fromARGB(255, 7, 7, 7),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                userprofileDetails.userDetails!.firstName,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  'Mobile:'.toUpperCase(),
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  userprofileDetails.userDetails!.mobile,
                  style: const TextStyle(fontSize: 15),
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  'Email:'.toUpperCase(),
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  userprofileDetails.userDetails!.email,
                  style: TextStyle(fontSize: 15),
                ),
              ]),
            ),
          )
        ]));
  }

  _profileUpdate(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    ApiServices apiServices = ApiServices();
    //  final userProfileUpdateAPIProvider = Provider.of<ProfileApiResponseUpdateProvider>(context);
    //   final user = userProfileUpdateAPIProvider.profileResponseModel!;
    //   print('profile-------------------------------');
    final userProfileUpdateAPIProvider =
        Provider.of<ProfileApiResponseProvider>(context);
    final user = userProfileUpdateAPIProvider.profileResponseModel!;

    bool edit = false;

    return user.userDetails!.firstName == null ||
            user.userDetails!.firstName == "" && edit
        ? InkWell(
            onTap: () {
            },
            highlightColor: Colors.blue.withOpacity(0.6),
            splashColor: Colors.blue.withOpacity(0.6),
            child: Center(
                child: Text(
              "Edit Profile",
              style: CommonStyles.whiteText12BoldW500(),
            )))
        : InkWell(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Text(
                    'EDIT',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 17.0, color: Colors.blue[900]),
                  ),
                  Icon(Icons.edit,size: 17,color: Colors.blue[900])
                ],
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: IconButton(
                              icon: const Icon(
                                Icons.clear,
                                size: 20,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            title: Text(
                              'EDIT PROFILE',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize: 17.0, color: Colors.blueAccent),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.check,
                                  size: 20, color: Colors.black),
                              onPressed: () async {
                                _formKey.currentState!.save();
                                Utils.showLoaderDialog(context);
                                if (_formKey.currentState!.validate()) {
                              print("--------------------- mobile controller -----"+mobileController.text);
                              print("--------------------- name controller -----"+nameController.text);

                              print("--------------------- email controller -----"+email.text);

                                  await apiServices
                                      .editProfile(
                                    userId: userProfileUpdateAPIProvider
                                        .profileResponseModel!.userDetails!.id,
                                    deviceToken: userProfileUpdateAPIProvider
                                        .profileResponseModel!
                                        .userDetails!
                                        .deviceToken,
                                    email: email.text,
                                    mobileNo: mobileController.text,
                                    otp: userProfileUpdateAPIProvider
                                        .profileResponseModel!
                                        .userDetails!
                                        .getOtp,
                                    userName: nameController.text,
                                  )
                                      .then((value) {
                                    context
                                        .read<ProfileApiResponseProvider>()
                                        .fetchData;


                                    Navigator.pop(context);

                                    Navigator.pop(context);
                                  });
                                } else {
                                  if (kDebugMode) {
                                    print("validation failed");
                                  }
                                }
                              },
                            ),
                          ),
                          FormBuilder(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextFormField(
                                      // name: 'user_name',
                                      // initialValue: user.userDetails!.firstName,
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "User name",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextFormField(
                                      // name: 'email',
                                      controller: email,
                                      // initialValue: user.userDetails!.email,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Email",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextFormField(
                                      // name: 'mobile',
                                      controller: mobileController,
                                      // initialValue: user.userDetails!.mobile,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Mobile",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            });
  }
}
