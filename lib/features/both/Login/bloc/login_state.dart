part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  get loginModel => null;
}

final class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}
