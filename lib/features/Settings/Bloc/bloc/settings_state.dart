part of 'settings_bloc.dart';

class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsError extends SettingsState {
  final String message;

  SettingsError({required this.message});
}
