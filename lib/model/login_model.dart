class LoginResponse {
 late String status;
 late String message;
 late String userId;
 late UserDetails? userDetails;
late  String profileBaseurl;

  LoginResponse(
      {required this.status,
      required this.message,
      required this.userId,
      this.userDetails,
      required this.profileBaseurl});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    userDetails = json['user_details'] != null
        ?  UserDetails.fromJson(json['user_details'])
        : null;
    profileBaseurl = json['profile_baseurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['user_id'] = userId;
    if (userDetails != null) {
      data['user_details'] = userDetails!.toJson();
    }
    data['profile_baseurl'] = profileBaseurl;
    return data;
  }
}

class UserDetails {
 late String id;
 late String firstName;
 late String mobile;
 late String email;
 late String getOtp;
 late String status;
 late String deviceType;
 late String deviceToken;
 late String createdAt;
 late String updatedAt;

  UserDetails(
      {
      required this.id,
      required this.firstName,
      required this.mobile,
      required this.email,
      required this.getOtp,
      required this.status,
      required this.deviceType,
      required this.deviceToken,
      required this.createdAt,
      required this.updatedAt});
 
  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    mobile = json['mobile'];
    email = json['email'];
    getOtp = json['get_otp'];
    status = json['status'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data ={};
    data['id'] = id;
    data['first_name'] = firstName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['get_otp'] = getOtp;
    data['status'] = status;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}