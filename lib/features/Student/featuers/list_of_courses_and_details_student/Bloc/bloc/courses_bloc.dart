import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/Student/featuers/list_of_courses_and_details_student/Models/courses_and_offers_model.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final BaseApiService client;
  CoursesBloc({required this.client}) : super(CoursesInitial()) {
    on<GetCoursesEvent>((event, emit) async {
      emit(CoursesLoading());
      final result = await BaseRepo.repoRequest(request: () async {
        final response =
            await client.getRequestAuth(url: ApiConstants.getcourses);
        final data = jsonDecode(response.body);
        final pros = CoursesModel.fromJson(data);
        return pros;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(GetCoursesSuccess(courses: responseData));
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return CoursesError(message: 'No internet');

      case NetworkErrorFailure:
        return CoursesError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return CoursesError(
          message: 'Error',
        );
    }
  }
}
