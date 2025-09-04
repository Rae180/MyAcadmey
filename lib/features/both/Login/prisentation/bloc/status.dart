import '../../data/login_model.dart';

abstract class LoginScreenStatus {}
class LoginScreenInitializeState extends LoginScreenStatus{}
class LoginScreenSuccessState extends LoginScreenStatus{
  final LoginModel loginModel;

  LoginScreenSuccessState(this.loginModel);
}
class LoginScreenLoadingState extends LoginScreenStatus{}
class LoginScreenErrorState extends LoginScreenStatus{
  // final String error;
  // LoginScreenErrorState(this.error);
}
class LoginChangePasswordVisibilityState extends LoginScreenStatus{}