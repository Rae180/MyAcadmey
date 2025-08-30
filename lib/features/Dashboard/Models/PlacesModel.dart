
class PlacesModel {
    List<Places>? places;

    PlacesModel({this.places});

    PlacesModel.fromJson(Map<String, dynamic> json) {
        places = json["places"] == null ? null : (json["places"] as List).map((e) => Places.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(places != null) {
            _data["places"] = places?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Places {
    String? place;
    int? price;

    Places({this.place, this.price});

    Places.fromJson(Map<String, dynamic> json) {
        place = json["place"];
        price = json["price"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["place"] = place;
        _data["price"] = price;
        return _data;
    }
}