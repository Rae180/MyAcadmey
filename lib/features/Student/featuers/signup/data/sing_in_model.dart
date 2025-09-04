class SignInModel {
  String ?message;
  String ?token;
  String? imageUrl;

  SignInModel({this.message, this.token, this.imageUrl});

  SignInModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
// class Data {
//   String? name;
//   String? phoneNumber;
//   int? userId;
//   String? updatedAt;
//   String? createdAt;
//   int? id;
//
//   Data(
//       {this.name ,
//
//         this.phoneNumber,
//         this.userId,
//         this.updatedAt,
//         this.createdAt,
//         this.id});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     name  = json['name'];
//     phoneNumber = json['phone_number'];
//     userId = json['user_id'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['phone_number'] = this.phoneNumber;
//     data['user_id'] = this.userId;
//     data['updated_at'] = this.updatedAt;
//     data['created_at'] = this.createdAt;
//     data['id'] = this.id;
//     return data;
//   }
// }