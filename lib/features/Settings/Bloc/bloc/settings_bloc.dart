import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/Settings/Models/AllOrdersModel.dart';
import 'package:start/features/Settings/Models/ManagerInfo.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final BaseApiService client;
  SettingsBloc({required this.client}) : super(SettingsInitial()) {}
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return SettingsError(message: 'No internet');

      case NetworkErrorFailure:
        return SettingsError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return SettingsError(
          message: 'Error',
        );
    }
  }
}
