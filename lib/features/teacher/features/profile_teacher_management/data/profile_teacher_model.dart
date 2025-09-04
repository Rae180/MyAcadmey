
class ProfileTeacherModel {
  int? status;
  String? message;
  Data? data;

  ProfileTeacherModel({this.status, this.message, this.data});

  ProfileTeacherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['teacher'] != null ? new Data.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['teacher'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? phoneNumber;
  String? photo;
  String? email;
  List<Posts>? posts;

  Data(
      {this.id,
        this.name,
        this.phoneNumber,
        this.photo,
        this.email,
        this.posts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone'];
    photo = json['photo'];
    email = json['email'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phoneNumber;
    data['photo'] = this.photo;
    data['email'] = this.email;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  int? id;
  String? post;
  // String? image;

  Posts({this.id, this.post});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    post = json['post'];
    // image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post'] = this.post;
    // data['image'] = this.image;
    return data;
  }
}