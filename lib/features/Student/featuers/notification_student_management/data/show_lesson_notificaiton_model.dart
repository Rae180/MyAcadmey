class ShowLessonNotificationModel {
  int? status;
  String? message;
  List<Data>? data;

  ShowLessonNotificationModel({this.status, this.message, this.data});

  ShowLessonNotificationModel.fromJson(Map<String, dynamic> json) {
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
  String? title1;
  String? title2;
  String? title3;
  String? title4;
  String? title5;
  String? title6;
  int? courseId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.title1,
        this.title2,
        this.title3,
        this.title4,
        this.title5,
        this.title6,
        this.courseId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title1 = json['title1'];
    title2 = json['title2'];
    title3 = json['title3'];
    title4 = json['title4'];
    title5 = json['title5'];
    title6 = json['title6'];
    courseId = json['course_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title1'] = this.title1;
    data['title2'] = this.title2;
    data['title3'] = this.title3;
    data['title4'] = this.title4;
    data['title5'] = this.title5;
    data['title6'] = this.title6;
    data['course_id'] = this.courseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}