
import '../../data/profile_teacher_model.dart';

abstract class ProfileTeacherStatus{}
class ProfileTeacherInitializeState extends ProfileTeacherStatus{}
class ProfileTeacherLoadingState extends ProfileTeacherStatus{}
class ProfileTeacherSuccessState extends ProfileTeacherStatus{
ProfileTeacherModel profileTeacherModel;

ProfileTeacherSuccessState(this.profileTeacherModel);
}
class ProfileTeacherErrorState extends ProfileTeacherStatus{}
///
class UpdateProfileTeacherLoadingState extends ProfileTeacherStatus{}
class UpdateProfileTeacherSuccessState extends ProfileTeacherStatus{

}
class UpdateProfileTeacherErrorState extends ProfileTeacherStatus{}
///
class AddPostProfileTeacherLoadingState extends ProfileTeacherStatus{}
class AddPostProfileTeacherSuccessState extends ProfileTeacherStatus{

}
class AddPostProfileTeacherErrorState extends ProfileTeacherStatus{}
///
class ChangePasswordProfileTeacherLoadingState extends ProfileTeacherStatus{}
class ChangePasswordProfileTeacherSuccessState extends ProfileTeacherStatus{
ChangePasswordModel changePasswordModel;

ChangePasswordProfileTeacherSuccessState(this.changePasswordModel);
}
class ChangePasswordProfileTeacherErrorState extends ProfileTeacherStatus{}

///////////////////////
class DeletePostProfileTeacherLoadingState extends ProfileTeacherStatus{}
class DeletePostProfileTeacherSuccessState extends ProfileTeacherStatus{

}
class DeletePostProfileTeacherErrorState extends ProfileTeacherStatus{}

class ChangePasswordModel {
  int? status;
  String? message;

  ChangePasswordModel({this.status, this.message});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}