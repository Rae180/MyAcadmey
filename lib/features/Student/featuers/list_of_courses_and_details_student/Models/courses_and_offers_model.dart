class CoursesModel {
    List<Data>? data;

    CoursesModel({this.data});

    CoursesModel.fromJson(Map<String, dynamic> json) {
        data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(data != null) {
            _data["data"] = data?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Data {
    int? id;
    String? name;
    String? description;
    double? price;
    String? courseImage;
    int? seats;
    int? hours;
    String? startTime;
    String? endTime;
    Teacher? teacher;
    Academy? academy;
    List<AnnualSchedules>? annualSchedules;
    bool? isOffer;

    Data({this.id, this.name, this.description, this.price, this.courseImage, this.seats, this.hours, this.startTime, this.endTime, this.teacher, this.academy, this.annualSchedules, this.isOffer});

    Data.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        description = json["description"];
        price = json["price"];
        courseImage = json["course_image"];
        seats = json["seats"];
        hours = json["hours"];
        startTime = json["start_time"];
        endTime = json["end_time"];
        teacher = json["teacher"] == null ? null : Teacher.fromJson(json["teacher"]);
        academy = json["academy"] == null ? null : Academy.fromJson(json["academy"]);
        annualSchedules = json["annualSchedules"] == null ? null : (json["annualSchedules"] as List).map((e) => AnnualSchedules.fromJson(e)).toList();
        isOffer = json["is_offer"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        _data["description"] = description;
        _data["price"] = price;
        _data["course_image"] = courseImage;
        _data["seats"] = seats;
        _data["hours"] = hours;
        _data["start_time"] = startTime;
        _data["end_time"] = endTime;
        if(teacher != null) {
            _data["teacher"] = teacher?.toJson();
        }
        if(academy != null) {
            _data["academy"] = academy?.toJson();
        }
        if(annualSchedules != null) {
            _data["annualSchedules"] = annualSchedules?.map((e) => e.toJson()).toList();
        }
        _data["is_offer"] = isOffer;
        return _data;
    }
}

class AnnualSchedules {
    int? id;
    String? day;
    String? startTime;
    String? endTime;

    AnnualSchedules({this.id, this.day, this.startTime, this.endTime});

    AnnualSchedules.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        day = json["day"];
        startTime = json["start_time"];
        endTime = json["end_time"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["day"] = day;
        _data["start_time"] = startTime;
        _data["end_time"] = endTime;
        return _data;
    }
}

class Academy {
    int? id;
    String? name;

    Academy({this.id, this.name});

    Academy.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        return _data;
    }
}

class Teacher {
    int? id;
    String? firstName;
    String? lastName;

    Teacher({this.id, this.firstName, this.lastName});

    Teacher.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        firstName = json["first_name"];
        lastName = json["last_name"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["first_name"] = firstName;
        _data["last_name"] = lastName;
        return _data;
    }
}