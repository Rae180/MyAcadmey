import 'dart:io';

class ShowDetailsInstituteStudentModel {
  AcademyDetails? academyDetails;

  ShowDetailsInstituteStudentModel({this.academyDetails});

  ShowDetailsInstituteStudentModel.fromJson(Map<String, dynamic> json) {
    academyDetails = json['academy_details'] != null
        ?  AcademyDetails.fromJson(json['academy_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.academyDetails != null) {
      data['academy_details'] = this.academyDetails?.toJson();
    }
    return data;
  }
}

class AcademyDetails {
  int? id;
  String? academyName;
  String? address;
  String? description;
  File? image1;
  File? image2;
  File? image3;
  File? image4;
  int? approve;
  int? english;
  int? spanish;
  int? french;
  int? germany;
  int? numberOfLikes;
  int? numberOfDislikes;
  int? managerId;
  int? rateId;
  String? createdAt;
  String? updatedAt;

  AcademyDetails(
      {this.id,
        this.academyName,
        this.address,
        this.description,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.approve,
        this.english,
        this.spanish,
        this.french,
        this.germany,
        this.numberOfLikes,
        this.numberOfDislikes,
        this.managerId,
        this.rateId,
        this.createdAt,
        this.updatedAt});

  AcademyDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    academyName = json['Academy_name'];
    address = json['address'];
    description = json['description'];
    image1 = File(json['image1']);
    image2 = File(json['image2']);
    image3 = File(json['image3']);
    image4 = File(json['image4']);
    approve = json['approve'];
    english = json['english'];
    spanish = json['spanish'];
    french = json['french'];
    germany = json['germany'];
    numberOfLikes = json['number_of_likes'];
    numberOfDislikes = json['number_of_dislikes'];
    managerId = json['manager_id'];
    rateId = json['rate_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Academy_name'] = this.academyName;
    data['address'] = this.address;
    data['description'] = this.description;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['approve'] = this.approve;
    data['english'] = this.english;
    data['spanish'] = this.spanish;
    data['french'] = this.french;
    data['germany'] = this.germany;
    data['number_of_likes'] = this.numberOfLikes;
    data['number_of_dislikes'] = this.numberOfDislikes;
    data['manager_id'] = this.managerId;
    data['rate_id'] = this.rateId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}