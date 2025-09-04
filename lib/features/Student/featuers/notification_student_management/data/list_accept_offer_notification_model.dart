class ListAcceptOfferNotificationModel {
  int? status;
  String? message;
  List<Data>? data;

  ListAcceptOfferNotificationModel({this.status, this.message, this.data});

  ListAcceptOfferNotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  int? studentId;
  int? offerId;
  int? read;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.title,
        this.studentId,
        this.offerId,
        this.read,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    studentId = json['student_id'];
    offerId = json['offer_id'];
    read = json['read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['student_id'] = this.studentId;
    data['offer_id'] = this.offerId;
    data['read'] = this.read;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}