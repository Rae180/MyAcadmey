
class DeliveryOrdersModel {
    List<Data>? data;

    DeliveryOrdersModel({this.data});

    DeliveryOrdersModel.fromJson(Map<String, dynamic> json) {
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
    int? purchaseOrderId;
    int? customerId;
    String? customerName;
    String? customerPhone;
    String? deliveryAddress;

    Data({this.purchaseOrderId, this.customerId, this.customerName, this.customerPhone, this.deliveryAddress});

    Data.fromJson(Map<String, dynamic> json) {
        purchaseOrderId = json["purchase_order_id"];
        customerId = json["customer_id"];
        customerName = json["customer_name"];
        customerPhone = json["customer_phone"];
        deliveryAddress = json["delivery_address"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["purchase_order_id"] = purchaseOrderId;
        _data["customer_id"] = customerId;
        _data["customer_name"] = customerName;
        _data["customer_phone"] = customerPhone;
        _data["delivery_address"] = deliveryAddress;
        return _data;
    }
}