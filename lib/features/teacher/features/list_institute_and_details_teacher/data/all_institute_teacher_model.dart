class AllInstituteTeacherModel {
  int? status;
  String? message;
  List<Data>? data;

  AllInstituteTeacherModel({this.status, this.message, this.data});

  AllInstituteTeacherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['teacher_academies'] != null) {
      data = <Data>[];
      json['teacher_academies'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['teacher_academies'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? location;
  dynamic? rate;
  String? photo;

  Data({this.id, this.name, this.location, this.rate, this.photo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    rate = json['rate'];
    photo = json['image1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['rate'] = this.rate;
    data['image1'] = this.photo;
    return data;
  }
}