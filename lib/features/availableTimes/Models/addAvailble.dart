
class AddAvilable {
    List<Availabilities>? availabilities;

    AddAvilable({this.availabilities});

    AddAvilable.fromJson(Map<String, dynamic> json) {
        availabilities = json["availabilities"] == null ? null : (json["availabilities"] as List).map((e) => Availabilities.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(availabilities != null) {
            _data["availabilities"] = availabilities?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Availabilities {
    String? dayOfWeek;
    String? startTime;
    String? endTime;

    Availabilities({this.dayOfWeek, this.startTime, this.endTime});

    Availabilities.fromJson(Map<String, dynamic> json) {
        dayOfWeek = json["day_of_week"];
        startTime = json["start_time"];
        endTime = json["end_time"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["day_of_week"] = dayOfWeek;
        _data["start_time"] = startTime;
        _data["end_time"] = endTime;
        return _data;
    }
}