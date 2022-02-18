class BrandListModel {
  String? status;
  String? message;
  List<BrandList>? brandList;

  BrandListModel({this.status, this.message, this.brandList});

  BrandListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['brand_list'] != null) {
      brandList = <BrandList>[];
      json['brand_list'].forEach((v) {
        brandList!.add(new BrandList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.brandList != null) {
      data['brand_list'] = this.brandList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandList {
  String? id;
  String? bikeCompanyName;
  String? status;
  String? createdAt;

  BrandList({this.id, this.bikeCompanyName, this.status, this.createdAt});

  BrandList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bikeCompanyName = json['bike_company_name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bike_company_name'] = this.bikeCompanyName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
