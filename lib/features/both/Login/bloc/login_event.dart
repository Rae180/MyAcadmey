part of 'login_bloc.dart';

class LoginEvent {}

final class LoginingEvent extends LoginEvent {
  final String email;
  final String paassword;

  LoginingEvent({required this.email, required this.paassword});

}
