part of 'available_times_bloc.dart';

class AvailableTimesEvent {}

final class GetAvailableTimesEvent extends AvailableTimesEvent {}

final class AddAvailableEvent extends AvailableTimesEvent {
  final AddAvilable avilable;

  AddAvailableEvent({required this.avilable});
}

final class UpdateAvailableEvent extends AvailableTimesEvent {
  final AddAvilable avilable;

  UpdateAvailableEvent({required this.avilable});
}
