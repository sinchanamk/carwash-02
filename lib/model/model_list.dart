class ModelListModel {
  String? status;
  String? message;
  List<ModelList>? modelList;

  ModelListModel({this.status, this.message, this.modelList});

  ModelListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['model_list'] != null) {
      modelList = <ModelList>[];
      json['model_list'].forEach((v) {
        modelList!.add( ModelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] =message;
    if (modelList != null) {
      data['model_list'] = modelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModelList {
  String? id;
  String? companyNameId;
  String? bikeModel;
  String? status;
  String? createdAt;
  String? updatedAt;

  ModelList(
      {this.id,
      this.companyNameId,
      this.bikeModel,
      this.status,
      this.createdAt,
      this.updatedAt});

  ModelList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyNameId = json['company_name_id'];
    bikeModel = json['bike_model'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['id'] = id;
    data['company_name_id'] =companyNameId;
    data['bike_model'] =bikeModel;
    data['status'] =status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
