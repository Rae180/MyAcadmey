
import '../../data/sing_in_model.dart';

abstract class SignInScreenStates{}

class SignInInitialState extends SignInScreenStates{}
class SignInLoadingState extends SignInScreenStates{}
class SignInSuccessState extends SignInScreenStates
{
  final SignInModel signInModel;

  SignInSuccessState(this.signInModel);
}
class SignInErrorState extends SignInScreenStates{

}
class SignInChangePasswordVisibilityState extends SignInScreenStates{}
