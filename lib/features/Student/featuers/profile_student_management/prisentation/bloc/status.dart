import '../../../../../teacher/features/profile_teacher_management/prisentation/bloc/status.dart';
import '../../data/profile_model.dart';
import '../../data/show_certificate_model.dart';


abstract class ProfileStudentStatus{}
///show profile status
 class ProfileStudentInitialState extends ProfileStudentStatus{}
 class ProfileStudentLoadingState extends ProfileStudentStatus{}
 class ProfileStudentSuccessState extends ProfileStudentStatus
 {
   final ProfileStudentModel profileStudentModel;
   ProfileStudentSuccessState(this.profileStudentModel);
 }
 class ProfileStudentErrorState extends ProfileStudentStatus{}
///show certificate status
class ShowCertificateStudentLoadingState extends ProfileStudentStatus{}
class ShowCertificateStudentSuccessState extends ProfileStudentStatus
{
  final ShowCertificateModel showCertificateModel;
  ShowCertificateStudentSuccessState(this.showCertificateModel);
}
class ShowCertificateStudentErrorState extends ProfileStudentStatus{}
///edit profile Student state--------------------
class EditProfileStudentLoadingState extends ProfileStudentStatus{}
class EditProfileStudentSuccessState extends ProfileStudentStatus
{

}
class EditProfileStudentErrorState extends ProfileStudentStatus{}
///change password state ---------------------
class ChangePasswordStudentLoadingState extends ProfileStudentStatus{}
class ChangePasswordStudentSuccessState extends ProfileStudentStatus
{
ChangePasswordModel changePasswordModel;

ChangePasswordStudentSuccessState(this.changePasswordModel);
}
class ChangePasswordStudentErrorState extends ProfileStudentStatus{}