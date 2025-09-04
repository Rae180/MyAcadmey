class ShowCoursesAndOffersModel {
  List<Courses>? courses;

  ShowCoursesAndOffersModel({this.courses});

  ShowCoursesAndOffersModel.fromJson(Map<String, dynamic> json) {
    if (json['Courses'] != null) {
      courses = (json['Courses'] as List).map((v) => Courses.fromJson(v)).toList();


      // json['Courses'].forEach((v) {
      //   courses?.add(new Courses.fromJson(v));
      //});
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['Courses'] = this.courses?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  int? id;
  int? teacherId;
  String? name;
  String? level;
  int? setsNumber;
  String? startDate;
  String? endDate;
  int? price;
  String? language;
  int? isOffer;
  int? active;
  String? createdAt;
  String? updatedAt;

  Courses(
      {this.id,
        this.teacherId,
        this.name,
        this.level,
        this.setsNumber,
        this.startDate,
        this.endDate,
        this.price,
        this.language,
        this.isOffer,
        this.active,
        this.createdAt,
        this.updatedAt});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherId = json['teacher_id'];
    name = json['name'];
    level = json['level'];
    setsNumber = json['sets_number'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    price = json['price'];
    language = json['language'];
    isOffer = json['is_offer'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teacher_id'] = this.teacherId;
    data['name'] = this.name;
    data['level'] = this.level;
    data['sets_number'] = this.setsNumber;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['price'] = this.price;
    data['language'] = this.language;
    data['is_offer'] = this.isOffer;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}