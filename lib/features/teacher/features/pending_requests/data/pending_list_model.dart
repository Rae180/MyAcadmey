// class PendingListTeacherModel {
//   int? status;
//   String? message;
//   List<Data>? data;
//
//   PendingListTeacherModel({this.status, this.message, this.data});
//
//   PendingListTeacherModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? name;
//   String? location;
//   String? image;
//
//   Data({this.id, this.name, this.location, this.image});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     location = json['location'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['location'] = this.location;
//     data['image'] = this.image;
//     return data;
//   }
// }

import 'dart:io';

class PendingListTeacherModel {
  List<Data>? data;

  PendingListTeacherModel({this.data});

  PendingListTeacherModel.fromJson(Map<String, dynamic> json) {
    if (json['academies'] != null) {
      data = <Data>[];
      json['academies'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['academies'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String ?location;
  String? image;

  Data({this.id, this.name, this.location, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['image'] = this.image;
    return data;
  }
}
