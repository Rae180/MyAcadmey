class AllCoursesTeacherModel {
  // int? status;
  // String? message;
  List<Courses>? courses;

  AllCoursesTeacherModel({ this.courses});

  AllCoursesTeacherModel.fromJson(Map<String, dynamic> json) {
    // status = json['status'];
    // message = json['message'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['status'] = this.status;
    // data['message'] = this.message;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  int? id;
  String? name;
  int? price;
  int? hours;
  String? courseImage;
  int? seats;
  // String? description;
  int? hasExam;
  String? startTime;
  String? endTime;
  String? academyName;
  int? studentNumber;

  Courses(
      {this.id,
        this.name,
        this.price,
        this.hours,
        this.courseImage,
        this.seats,
        // this.description,
        this.hasExam,
        this.startTime,
        this.endTime,
        this.academyName,
        this.studentNumber});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    hours = json['hours'];
    courseImage = json['courseImage'];
    seats = json['sets_number'];
    // description = json['description'];
    hasExam = json['hasExam'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    academyName = json['Academy_name'];
    studentNumber = json['number_of_students'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['hours'] = this.hours;
    data['courseImage'] = this.courseImage;
    data['sets_number'] = this.seats;
    // data['description'] = this.description;
    data['hasExam'] = this.hasExam;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['Academy_name'] = this.academyName;
    data['number_of_students'] = this.studentNumber;
    return data;
  }
}