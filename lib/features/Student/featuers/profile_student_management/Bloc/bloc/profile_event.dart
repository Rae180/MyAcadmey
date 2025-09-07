part of 'profile_bloc.dart';

class ProfileEvent {}

final class GetProfileStuEvent extends ProfileEvent {}

final class UpdateProfileEvent extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String phone;

  UpdateProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.phone,
  });
}

final class ChangePasswordEvent extends ProfileEvent {
  final String current;
  final String newPass;

  ChangePasswordEvent({required this.current, required this.newPass});
}

final class GetCertificatesEvent extends ProfileEvent {}
