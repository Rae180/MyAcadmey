class EnrollmentTeacherModel {
  int? status;
  String? message;
  Data? data;

  EnrollmentTeacherModel({this.status, this.message, this.data});

  EnrollmentTeacherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? saturday;
  String? startSaturday;
  String? endSaturday;
  String? sunday;
  String? startSunday;
  String? endSunday;
  String? monday;
  String? startMonday;
  String? endMonday;
  String? tuesday;
  String? startTuesday;
  String? endTuesday;
  String? wednsday;
  String? startWednsday;
  String? endWednsday;
  String? thursday;
  String? startThursday;
  String? endThursday;
  String? friday;
  String? startFriday;
  String? endFriday;
  int? academyTeacherId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.saturday,
        this.startSaturday,
        this.endSaturday,
        this.sunday,
        this.startSunday,
        this.endSunday,
        this.monday,
        this.startMonday,
        this.endMonday,
        this.tuesday,
        this.startTuesday,
        this.endTuesday,
        this.wednsday,
        this.startWednsday,
        this.endWednsday,
        this.thursday,
        this.startThursday,
        this.endThursday,
        this.friday,
        this.startFriday,
        this.endFriday,
        this.academyTeacherId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    saturday = json['saturday'];
    startSaturday = json['start_saturday'];
    endSaturday = json['end_saturday'];
    sunday = json['sunday'];
    startSunday = json['start_sunday'];
    endSunday = json['end_sunday'];
    monday = json['monday'];
    startMonday = json['start_monday'];
    endMonday = json['end_monday'];
    tuesday = json['tuesday'];
    startTuesday = json['start_tuesday'];
    endTuesday = json['end_tuesday'];
    wednsday = json['wednsday'];
    startWednsday = json['start_wednsday'];
    endWednsday = json['end_wednsday'];
    thursday = json['thursday'];
    startThursday = json['start_thursday'];
    endThursday = json['end_thursday'];
    friday = json['friday'];
    startFriday = json['start_friday'];
    endFriday = json['end_friday'];
    academyTeacherId = json['academy_teacher_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['saturday'] = this.saturday;
    data['start_saturday'] = this.startSaturday;
    data['end_saturday'] = this.endSaturday;
    data['sunday'] = this.sunday;
    data['start_sunday'] = this.startSunday;
    data['end_sunday'] = this.endSunday;
    data['monday'] = this.monday;
    data['start_monday'] = this.startMonday;
    data['end_monday'] = this.endMonday;
    data['tuesday'] = this.tuesday;
    data['start_tuesday'] = this.startTuesday;
    data['end_tuesday'] = this.endTuesday;
    data['wednsday'] = this.wednsday;
    data['start_wednsday'] = this.startWednsday;
    data['end_wednsday'] = this.endWednsday;
    data['thursday'] = this.thursday;
    data['start_thursday'] = this.startThursday;
    data['end_thursday'] = this.endThursday;
    data['friday'] = this.friday;
    data['start_friday'] = this.startFriday;
    data['end_friday'] = this.endFriday;
    data['academy_teacher_id'] = this.academyTeacherId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}