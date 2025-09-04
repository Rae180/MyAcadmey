import 'dart:io';
import 'dart:ui';

class SearchOfferStudentModel {
  int? status;
  String? message;
  List<Data>? data;

  SearchOfferStudentModel({this.status, this.message, this.data});

  SearchOfferStudentModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? price;
  String? hours;
  String? startDate;
  String? endDate;
  String? description;
  File? image;
  int? seats;
  Academy? academy;

  Data(
      {this.id,
        this.name,
        this.price,
        this.hours,
        this.startDate,
        this.endDate,
        this.description,
        this.image,
        this.seats,
        this.academy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    hours = json['hours'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    image = File(json['image']);
    seats = json['seats'];
    academy =
    json['academy'] != null ? new Academy.fromJson(json['academy']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['hours'] = this.hours;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['image'] = this.image;
    data['seats'] = this.seats;
    if (this.academy != null) {
      data['academy'] = this.academy!.toJson();
    }
    return data;
  }
}

class Academy {
  int? id;
  String? name;
  String? description;
  String? location;
  String? licenseNumber;
  int? english;
  int? germany;
  int? spanish;
  int? french;
  File? image;
  int? deleteTime;
  int? academyAdminstratorId;
  String? createdAt;
  String? updatedAt;

  Academy(
      {this.id,
        this.name,
        this.description,
        this.location,
        this.licenseNumber,
        this.english,
        this.germany,
        this.spanish,
        this.french,
        this.image,
        this.deleteTime,
        this.academyAdminstratorId,
        this.createdAt,
        this.updatedAt});

  Academy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    location = json['location'];
    licenseNumber = json['license_number'];
    english = json['english'];
    germany = json['germany'];
    spanish = json['spanish'];
    french = json['french'];
    image = File(json['image']);
    deleteTime = json['delete_time'];
    academyAdminstratorId = json['academy_adminstrator_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    data['license_number'] = this.licenseNumber;
    data['english'] = this.english;
    data['germany'] = this.germany;
    data['spanish'] = this.spanish;
    data['french'] = this.french;
    data['image'] = this.image;
    data['delete_time'] = this.deleteTime;
    data['academy_adminstrator_id'] = this.academyAdminstratorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}