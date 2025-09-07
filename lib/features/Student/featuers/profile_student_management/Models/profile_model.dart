import 'dart:io';

class ProfileStudentModel {
  Profile? profile;

  ProfileStudentModel({this.profile});

  ProfileStudentModel.fromJson(Map<String, dynamic> json) {
    profile = json['profile:'] != null
        ? new Profile.fromJson(json['profile:'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile:'] = this.profile?.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? role;
  String? phoneNumber;
  String? updatedAt;
  Student? student;

  Profile(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.role,
        this.phoneNumber,
        this.updatedAt,
        this.student});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    phoneNumber = json['phone_number'];
    updatedAt = json['updated_at'];
    student =
    json['student'] != null ? new Student.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role'] = this.role;
    data['phone_number'] = this.phoneNumber;
    data['updated_at'] = this.updatedAt;
    if (this.student != null) {
      data['student'] = this.student?.toJson();
    }
    return data;
  }
}

class Student {
  int? id;
  int? userId;
  File? image;
  String? createdAt;
  String? updatedAt;

  Student({this.id, this.userId, this.image, this.createdAt, this.updatedAt});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = File(json['image']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}