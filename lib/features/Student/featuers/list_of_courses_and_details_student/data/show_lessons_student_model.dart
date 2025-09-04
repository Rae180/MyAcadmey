class ShowLessonStudentModel {
  int? status;
  String? message;
  List<Data>? data;

  ShowLessonStudentModel({this.status, this.message, this.data});

  ShowLessonStudentModel.fromJson(Map<String, dynamic> json) {
    if (json['lessons'] != null) {
      data = <Data>[];
      json['lessons'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['lessons'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


// "lessons": [
// {
// "id": 7,
// "course_id": 30,
// "lesson": "Quos ipsam vel quis nihil ipsum praesentium exercitationem.",
// "created_at": "2024-05-25T09:42:30.000000Z",
// "updated_at": "2024-05-25T09:42:30.000000Z"
// }
// ]



class Data {
  int? id;
  String? name;
  String? lesson;
  int? courseId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.lesson,
        this.courseId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lesson = json['lesson'];
    courseId = json['course_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lesson'] = this.lesson;
    data['course_id'] = this.courseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}