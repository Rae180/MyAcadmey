class SignInModelTeacher {
  Teacher? teacher;
  String? token;

  SignInModelTeacher({this.teacher, this.token});

  SignInModelTeacher.fromJson(Map<String, dynamic> json) {
    teacher =
    json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Teacher {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Teacher(
      {this.firstName,
        this.lastName,
        this.phoneNumber,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Teacher.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}