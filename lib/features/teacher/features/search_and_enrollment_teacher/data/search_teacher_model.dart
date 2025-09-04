// class SearchTeacherModel {
//   int? status;
//   String? message;
//   List<SearchTeacher>? searchTeacher;
//
//   SearchTeacherModel({this.status, this.message, this.searchTeacher});
//
//   SearchTeacherModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       searchTeacher = <SearchTeacher>[];
//       json['data'].forEach((v) {
//         searchTeacher!.add(new SearchTeacher.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.searchTeacher != null) {
//       data['data'] =
//           this.searchTeacher!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class SearchTeacher {
//   int? id;
//   String? name;
//   String? description;
//   String? location;
//   String? licenseNumber;
//   int? english;
//   int? germany;
//   int? spanish;
//   int? french;
//   String? image;
//   int? deleteTime;
//   String? Academy_name;
//   String? createdAt;
//   String? updatedAt;
//   dynamic ? rate;
//
//   SearchTeacher(
//       {this.id,
//         this.name,
//         this.description,
//         this.location,
//         this.licenseNumber,
//         this.english,
//         this.germany,
//         this.spanish,
//         this.french,
//         this.image,
//         this.deleteTime,
//         this.Academy_name,
//         this.createdAt,
//         this.updatedAt,
//         this.rate});
//
//   SearchTeacher.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     location = json['address'];
//     licenseNumber = json['license_number'];
//     english = json['english'];
//     germany = json['germany'];
//     spanish = json['spanish'];
//     french = json['french'];
//     image = json['image1'];
//     deleteTime = json['delete_time'];
//     Academy_name = json['Academy_name'];
//     // createdAt = json['created_at'];
//     // updatedAt = json['updated_at'];
//     rate = json['rate'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['address'] = this.location;
//     data['license_number'] = this.licenseNumber;
//     data['english'] = this.english;
//     data['germany'] = this.germany;
//     data['spanish'] = this.spanish;
//     data['french'] = this.french;
//     data['image1'] = this.image;
//     data['delete_time'] = this.deleteTime;
//     data['Academy_name'] = this.Academy_name;
//     // data['created_at'] = this.createdAt;
//     // data['updated_at'] = this.updatedAt;
//     data['rate'] = this.rate;
//     return data;
//   }
// }


class SearchTeacherModel {
  int? status;
  String? message;
  List<SearchTeacher>? searchTeacher;

  SearchTeacherModel({this.status, this.message, this.searchTeacher});

  SearchTeacherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      searchTeacher = <SearchTeacher>[];
      json['data'].forEach((v) {
        searchTeacher!.add(new SearchTeacher.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.searchTeacher != null) {
      data['data'] =
          this.searchTeacher!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchTeacher {
  int? id;
  String? academyName;
  String? address;
  int? approve;
  double? rate;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? description;
  int? english;
  int? spanish;
  int? french;
  int? germany;
  int? numberOfLikes;
  int? numberOfDislikes;

  SearchTeacher(
      {this.id,
        this.academyName,
        this.address,
        this.approve,
        this.rate,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.description,
        this.english,
        this.spanish,
        this.french,
        this.germany,
        this.numberOfLikes,
        this.numberOfDislikes});

  SearchTeacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    academyName = json['Academy_name'];
    address = json['address'];
    approve = json['approve'];
    rate = json['rate'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    description = json['description'];
    english = json['english'];
    spanish = json['spanish'];
    french = json['french'];
    germany = json['germany'];
    numberOfLikes = json['number_of_likes'];
    numberOfDislikes = json['number_of_dislikes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Academy_name'] = this.academyName;
    data['address'] = this.address;
    data['approve'] = this.approve;
    data['rate'] = this.rate;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['description'] = this.description;
    data['english'] = this.english;
    data['spanish'] = this.spanish;
    data['french'] = this.french;
    data['germany'] = this.germany;
    data['number_of_likes'] = this.numberOfLikes;
    data['number_of_dislikes'] = this.numberOfDislikes;
    return data;
  }
}