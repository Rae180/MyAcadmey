part of 'courses_bloc.dart';

class CoursesState {}

final class CoursesInitial extends CoursesState {}

final class CoursesLoading extends CoursesState {}

final class GetCoursesSuccess extends CoursesState {
  final CoursesModel courses;

  GetCoursesSuccess({required this.courses});
}

final class CoursesError extends CoursesState {
  final String message;

  CoursesError({required this.message});
}
