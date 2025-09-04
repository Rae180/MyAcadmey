import 'dart:io';

// class ShowTenOffersModel {
//   List<Offers>? offers;
//
//   ShowTenOffersModel({this.offers});
//
//   ShowTenOffersModel.fromJson(Map<String, dynamic> json) {
//     if (json['offer_details'] != null) {
//       offers = (json['offer_details'] as List).map((v) => Offers.fromJson(v)).toList();
//
//
//       // json['Courses'].forEach((v) {
//       //   courses?.add(new Courses.fromJson(v));
//       //});
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.offers != null) {
//       data['Courses'] = this.offers?.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Offers {
//   File? image;
//   int? id;
//   int? teacherId;
//   String? name;
//   String? level;
//   int? setsNumber;
//   String? startDate;
//   String? endDate;
//   int? price;
//   String? language;
//   int? isOffer;
//   int? active;
//   String? createdAt;
//   String? updatedAt;
//
//   Offers(
//       {
//         this.image,
//         this.id,
//         this.teacherId,
//         this.name,
//         this.level,
//         this.setsNumber,
//         this.startDate,
//         this.endDate,
//         this.price,
//         this.language,
//         this.isOffer,
//         this.active,
//         this.createdAt,
//         this.updatedAt});
//
//   Offers.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     teacherId = json['teacher_id'];
//     name = json['name'];
//     level = json['level'];
//     setsNumber = json['sets_number'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     price = json['price'];
//     language = json['language'];
//     isOffer = json['is_offer'];
//     active = json['active'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['teacher_id'] = this.teacherId;
//     data['name'] = this.name;
//     data['level'] = this.level;
//     data['sets_number'] = this.setsNumber;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['price'] = this.price;
//     data['language'] = this.language;
//     data['is_offer'] = this.isOffer;
//     data['active'] = this.active;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }



class ShowTenOffersModel {
  List<Offers>? offers;

  ShowTenOffersModel({this.offers});

  ShowTenOffersModel.fromJson(Map<String, dynamic> json) {
    if (json['offer_details'] != null) {
      offers = (json['offer_details'] as List).map((v) => Offers.fromJson(v)).toList();
      json['offer_details'].forEach((v) {
        offers?.add(new Offers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offers != null) {
      data['offer_details'] = this.offers?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offers {
  int? id;
  int? teacherId;
  int? academyId;
  String? name;
  String? level;
  int? setsNumber;
  String? startDate;
  String? endDate;
  int ?price;
  String? language;
  int? isOffer;
  int? active;
  File? courseImage;
  int ?hours;
  String? createdAt;
  String? updatedAt;

  Offers(
      {this.id,
        this.teacherId,
        this.academyId,
        this.name,
        this.level,
        this.setsNumber,
        this.startDate,
        this.endDate,
        this.price,
        this.language,
        this.isOffer,
        this.active,
        this.courseImage,
        this.hours,
        this.createdAt,
        this.updatedAt});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    academyId = json['academy_id'];
    name = json['name'];
    level = json['level'];
    setsNumber = json['sets_number'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    price = json['price'];
    language = json['language'];
    isOffer = json['is_offer'];
    active = json['active'];
    courseImage = json['courseImage'];
    hours = json['hours'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teacher_id'] = this.teacherId;
    data['academy_id'] = this.academyId;
    data['name'] = this.name;
    data['level'] = this.level;
    data['sets_number'] = this.setsNumber;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['price'] = this.price;
    data['language'] = this.language;
    data['is_offer'] = this.isOffer;
    data['active'] = this.active;
    data['courseImage'] = this.courseImage;
    data['hours'] = this.hours;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

