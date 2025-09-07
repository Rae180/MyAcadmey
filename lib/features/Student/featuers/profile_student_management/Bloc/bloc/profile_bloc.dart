import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/Student/featuers/profile_student_management/Models/profile_model.dart';
import 'package:start/features/Student/featuers/profile_student_management/Models/show_certificate_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final BaseApiService client;
  ProfileBloc({required this.client}) : super(ProfileInitial()) {
    on<GetCertificatesEvent>(((event, emit) async {
      emit(ProfileLoading());
      final result = await BaseRepo.repoRequest(request: () async {
        final response =
            await client.getRequestAuth(url: ApiConstants.certificate);
        final data = jsonDecode(response.body);
        final pros = CertificatedModel.fromJson(data);
        return pros;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(ShowCertficatedSuccess(certificates: responseData));
      });
    }));
    on<ChangePasswordEvent>(((event, emit) async {
      emit(ProfileLoading());
      final result = await BaseRepo.repoRequest(request: () async {
        final response = await client.postRequestAuth(
            url: ApiConstants.changepass,
            jsonBody: {
              "current_password": event.current,
              "new_password": event.newPass
            });
        return response;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(ChangePasswordSuccess());
      });
    }));
    on<UpdateProfileEvent>(((event, emit) async {
      emit(ProfileLoading());
      final result = await BaseRepo.repoRequest(request: () async {
        final response =
            await client.postRequestAuth(url: ApiConstants.getPro, jsonBody: {
          "first_name": event.firstName,
          "last_name": event.lastName,
          "phone_number": event.phone,
          "photo": null
        });
        return response;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(UpdateProfileStuSuccess());
      });
    }));
    on<GetProfileStuEvent>((event, emit) async {
      emit(ProfileLoading());
      final result = await BaseRepo.repoRequest(request: () async {
        final response = await client.getRequestAuth(url: ApiConstants.getPro);
        final data = jsonDecode(response.body);
        final pros = ProfileStudentModel.fromJson(data);
        return pros;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(GetProfileStuSuccess(profileStu: responseData));
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return ProfileError(message: 'No internet');

      case NetworkErrorFailure:
        return ProfileError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return ProfileError(
          message: 'Error',
        );
    }
  }
}
