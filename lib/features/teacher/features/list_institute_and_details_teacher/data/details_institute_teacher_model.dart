
// class DetailsInstituteTeacherModel {
//   int? status;
//   String? message;
//   Data? data;
//
//   DetailsInstituteTeacherModel({this.status, this.message, this.data});
//
//   DetailsInstituteTeacherModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
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
//   int? rate;
//
//   Data(
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
//         this.rate});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     location = json['location'];
//     licenseNumber = json['license_number'];
//     english = json['english'];
//     germany = json['germany'];
//     spanish = json['spanish'];
//     french = json['french'];
//     image = json['image'];
//     deleteTime = json['delete_time'];
//     rate = json['rate'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['location'] = this.location;
//     data['license_number'] = this.licenseNumber;
//     data['english'] = this.english;
//     data['germany'] = this.germany;
//     data['spanish'] = this.spanish;
//     data['french'] = this.french;
//     data['image'] = this.image;
//     data['delete_time'] = this.deleteTime;
//     data['rate'] = this.rate;
//     return data;
//   }
// }


class DetailsInstituteTeacherModel {
  Data? data;

  DetailsInstituteTeacherModel({this.data});

  DetailsInstituteTeacherModel.fromJson(Map<String, dynamic> json) {
    data =
    json['course'] != null ? new Data.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['course'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  String? location;
  String? image1;
  String ?image2;
  String? image3;
  String? image4;
  double? rate;
  List<String>? languages;

  Data(
      {this.id,
        this.name,
        this.description,
        this.location,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.rate,
        this.languages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    location = json['location'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    rate = json['rate'];
    languages = json['languages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['rate'] = this.rate;
    data['languages'] = this.languages;
    return data;
  }
}
