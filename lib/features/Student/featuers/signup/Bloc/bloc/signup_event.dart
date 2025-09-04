part of 'signup_bloc.dart';

class SignupEvent {}

final class SigningupEvent extends SignupEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;

  SigningupEvent(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.phone});
}
