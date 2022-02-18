class ServiceListModel {
  String? status;
  String? message;
  String? vehicleUrl;
  List<ServiceList>? serviceList;

  ServiceListModel(
      {this.status, this.message, this.vehicleUrl, this.serviceList});

  ServiceListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vehicleUrl = json['vehicle_url'];
    if (json['service_list'] != null) {
      serviceList = <ServiceList>[];
      json['service_list'].forEach((v) {
        serviceList!.add( ServiceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['status'] = status;
    data['message'] = message;
    data['vehicle_url'] = vehicleUrl;
    if (serviceList != null) {
      data['service_list'] = serviceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceList {
  String? id;
  String? type;
  String? serviceName;
  String? videoFile;
  String? status;
  String?  image;
  String? createdAt;

  ServiceList(
      {this.id,
      this.type,
      this.serviceName,
      this.videoFile,
      this.image,
      this.status,
      this.createdAt});

  ServiceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    serviceName = json['service_name'];
    videoFile = json['video_file'];
    status = json['status'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    data['service_name'] = serviceName;
    data['video_file'] = videoFile;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
