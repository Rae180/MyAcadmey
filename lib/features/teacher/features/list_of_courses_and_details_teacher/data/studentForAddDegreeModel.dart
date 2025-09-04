class StudentForAddDegreeModel {
  int? status;
  String? message;
  List<Students>? students;

  StudentForAddDegreeModel({this.status, this.message, this.students});

  StudentForAddDegreeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(new Students.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Students {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;

  Students(
      {this.id, this.firstName, this.lastName, this.phoneNumber, this.email});

  Students.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    return data;
  }
}