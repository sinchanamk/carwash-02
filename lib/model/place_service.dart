class PlaceServiceModel {
 late String status;
 late String message;
  UserDetails? userDetails;

  PlaceServiceModel({required this.status, required this.message, this.userDetails});

  PlaceServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userDetails = json['user_details'] != null
        ?  UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (userDetails != null) {
      data['user_details'] = userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
 late String id;
 late String firstName;
 late String mobile;
 late String address;
 late String userLat;
 late String userLong;
 late String landmark;
 late String typeService;
 late String brand;
 late String model;
 late String serviceId;
 late String serviceName;
 late String email;
 late String bookDate;
 late String bookTime;
 late String orderStatus;
 late String status;
 late String deviceType;
 late String deviceToken;
 late String createdAt;
 UserDetails(
      {
     required this.id,
     required this.firstName,
     required this.mobile,
     required this.address,
     required this.userLat,
     required this.userLong,
     required this.landmark,
     required this.typeService,
     required this.brand,
     required this.model,
     required this.serviceId,
     required this.serviceName,
     required this.email,
     required this.bookDate,
     required this.bookTime,
     required this.orderStatus,
     required this.status,
     required this.deviceType,
     required this.deviceToken,
     required this.createdAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    mobile = json['mobile'];
    address = json['address'];
    userLat = json['user_lat'];
    userLong = json['user_long'];
    landmark = json['landmark'];
    typeService = json['type_service'];
    brand = json['brand'];
    model = json['model'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    email = json['email'];
    bookDate = json['book_date'];
    bookTime = json['book_time'];
    orderStatus = json['order_status'];
    status = json['status'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['mobile'] = mobile;
    data['address'] = address;
    data['user_lat'] = userLat;
    data['user_long'] = userLong;
    data['landmark'] = landmark;
    data['type_service'] = typeService;
    data['brand'] = brand;
    data['model'] = model;
    data['service_id'] = serviceId;
    data['service_name'] = serviceName;
    data['email'] = email;
    data['book_date'] = bookDate;
    data['book_time'] = bookTime;
    data['order_status'] = orderStatus;
    data['status'] = status;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['created_at'] = createdAt;
    return data;
  }
}