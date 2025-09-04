part of 'signup_bloc.dart';

class SignupState {}

final class SignupInitial extends SignupState {}

final class SignUpLoading extends SignupState {}

final class SignupSuccess extends SignupState {}

final class SignupError extends SignupState {
  final String message;

  SignupError({required this.message});
}
