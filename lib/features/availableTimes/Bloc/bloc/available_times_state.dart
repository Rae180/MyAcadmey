part of 'available_times_bloc.dart';

class AvailableTimesState {}

final class AvailableTimesInitial extends AvailableTimesState {}

final class AvailableTimesLoading extends AvailableTimesState {}

final class GetAvailbleTimesSuccess extends AvailableTimesState {
  final AavailableTimesModel times;

  GetAvailbleTimesSuccess({required this.times});
}

final class AddAvailableSuccess extends AvailableTimesState {}

final class UpdateAvailableSuccess extends AvailableTimesState {}

final class AvailableTimesError extends AvailableTimesState {
  final String message;

  AvailableTimesError({required this.message});
}
