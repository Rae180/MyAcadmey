class ShowOfferDetailsNotificationModel {
  bool? status;
  String? message;
  Data? data;

  ShowOfferDetailsNotificationModel({this.status, this.message, this.data});

  ShowOfferDetailsNotificationModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  int? price;
  String? hours;
  String? startDate;
  String? endDate;
  String? description;
  String? image;
  int? seats;

  Data(
      {this.id,
        this.name,
        this.price,
        this.hours,
        this.startDate,
        this.endDate,
        this.description,
        this.image,
        this.seats});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    hours = json['hours'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    image = json['image'];
    seats = json['seats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['hours'] = this.hours;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['image'] = this.image;
    data['seats'] = this.seats;
    return data;
  }
}