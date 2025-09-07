part of 'profile_bloc.dart';

class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class GetProfileStuSuccess extends ProfileState {
  final ProfileStudentModel profileStu;

  GetProfileStuSuccess({required this.profileStu});
}

final class UpdateProfileStuSuccess extends ProfileState {}

final class ChangePasswordSuccess extends ProfileState {}

final class ShowCertficatedSuccess extends ProfileState {
  final CertificatedModel certificates;

  ShowCertficatedSuccess({required this.certificates});
}

final class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}
