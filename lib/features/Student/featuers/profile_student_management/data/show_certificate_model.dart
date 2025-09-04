import 'dart:io';

class ShowCertificateModel {
  int? studentId;
  List<Certificates>? certificates;

  ShowCertificateModel({this.studentId, this.certificates});

  ShowCertificateModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    if (json['certificates'] != null) {
      certificates = (json['certificates'] as List).map((v) => Certificates.fromJson(v)).toList();


    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_id'] = this.studentId;
    if (this.certificates != null) {
      data['certificates'] = this.certificates?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Certificates {
  int? id;
  int? studentId;
  int? courseId;
  String? level;
  int? mark;
  String? description;
  String? date;
  File? image;
  String? createdAt;
  String? updatedAt;

  Certificates(
      {this.id,
        this.studentId,
        this.courseId,
        this.level,
        this.mark,
        this.description,
        this.date,
        this.image,
        this.createdAt,
        this.updatedAt});

  Certificates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    courseId = json['course_id'];
    level = json['level'];
    mark = json['mark'];
    description = json['description'];
    date = json['date'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['course_id'] = this.courseId;
    data['level'] = this.level;
    data['mark'] = this.mark;
    data['description'] = this.description;
    data['date'] = this.date;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}