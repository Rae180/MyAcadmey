
class CertificatedModel {
    List<Data>? data;

    CertificatedModel({this.data});

    CertificatedModel.fromJson(Map<String, dynamic> json) {
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
    String? academyName;
    String? studentName;
    String? courseLevel;
    String? mark;
    String? image;
    String? receiveDate;

    Data({this.id, this.academyName, this.studentName, this.courseLevel, this.mark, this.image, this.receiveDate});

    Data.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        academyName = json["academy_name"];
        studentName = json["student_name"];
        courseLevel = json["course_level"];
        mark = json["mark"];
        image = json["image"];
        receiveDate = json["receive_date"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["academy_name"] = academyName;
        _data["student_name"] = studentName;
        _data["course_level"] = courseLevel;
        _data["mark"] = mark;
        _data["image"] = image;
        _data["receive_date"] = receiveDate;
        return _data;
    }
}