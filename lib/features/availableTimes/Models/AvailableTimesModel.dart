
class AavailableTimesModel {
    List<Data>? data;

    AavailableTimesModel({this.data});

    AavailableTimesModel.fromJson(Map<String, dynamic> json) {
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
    String? dayOfWeek;
    String? startTime;
    String? endTime;
    String? createdAt;
    String? updatedAt;

    Data({this.id, this.dayOfWeek, this.startTime, this.endTime, this.createdAt, this.updatedAt});

    Data.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        dayOfWeek = json["day_of_week"];
        startTime = json["start_time"];
        endTime = json["end_time"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["day_of_week"] = dayOfWeek;
        _data["start_time"] = startTime;
        _data["end_time"] = endTime;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        return _data;
    }
}