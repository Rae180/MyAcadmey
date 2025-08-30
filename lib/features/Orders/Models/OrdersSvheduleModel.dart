
class OrdersScheduleModel {
    List<Data>? data;

    OrdersScheduleModel({this.data});

    OrdersScheduleModel.fromJson(Map<String, dynamic> json) {
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
    String? reciveDate;
    String? deliveryTime;

    Data({this.id, this.reciveDate, this.deliveryTime});

    Data.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        reciveDate = json["recive_date"];
        deliveryTime = json["delivery_time"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["recive_date"] = reciveDate;
        _data["delivery_time"] = deliveryTime;
        return _data;
    }
}