

import '../../data/sign_in_model_teacher.dart';

abstract class SignInScreenStatesTeacher{}

class SignInInitialStateTeacher extends SignInScreenStatesTeacher{}
class SignInLoadingStateTeacher extends SignInScreenStatesTeacher{}
class SignInSuccessStateTeacher extends SignInScreenStatesTeacher
{
  final SignInModelTeacher signInModel;

  SignInSuccessStateTeacher(this.signInModel);
}
class SignInErrorStateTeacher extends SignInScreenStatesTeacher{

}
class SignInChangePasswordVisibilityStateTeacher extends SignInScreenStatesTeacher{}
