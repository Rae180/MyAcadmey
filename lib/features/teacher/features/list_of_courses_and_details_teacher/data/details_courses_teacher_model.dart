class DetailsCoursesTeacherModel {
  int? status;
  String? message;
  Course? course;

  DetailsCoursesTeacherModel({this.status, this.message, this.course});

  DetailsCoursesTeacherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    course =
    json['course'] != null ? new Course.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    return data;
  }
}

class Course {
  int? id;
  String? name;
  int? price;
  int? hours;
  String? courseImage;
  int? seats;
  String? description;
  int? hasExam;
  String? startTime;
  String? endTime;

  Course(
      {this.id,
        this.name,
        this.price,
        this.hours,
        this.courseImage,
        this.seats,
        this.description,
        this.hasExam,
        this.startTime,
        this.endTime});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    hours = json['hours'];
    courseImage = json['courseImage'];
    seats = json['sets_number'];
    description = json['description'];
    hasExam = json['hasExam'];
    startTime = json['start_date'];
    endTime = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['hours'] = this.hours;
    data['courseImage'] = this.courseImage;
    data['sets_number'] = this.seats;
    data['description'] = this.description;
    data['hasExam'] = this.hasExam;
    data['start_date'] = this.startTime;
    data['end_date'] = this.endTime;
    return data;
  }
}