import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/availableTimes/Models/AvailableTimesModel.dart';
import 'package:start/features/availableTimes/Models/addAvailble.dart';

part 'available_times_event.dart';
part 'available_times_state.dart';

class AvailableTimesBloc
    extends Bloc<AvailableTimesEvent, AvailableTimesState> {
  final BaseApiService client;
  AvailableTimesBloc({required this.client}) : super(AvailableTimesInitial()) {
    on<UpdateAvailableEvent>(((event, emit) async {
      final result = await BaseRepo.repoRequest(request: () async {
        final response = await client.postRequestAuth(
            url: ApiConstants.updateAvailable,
            jsonBody: event.avilable.toJson());
        return response;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(AddAvailableSuccess());
      });
    }));

    on<AddAvailableEvent>(((event, emit) async {
      final result = await BaseRepo.repoRequest(request: () async {
        final response = await client.postRequestAuth(
            url: ApiConstants.addAvailable, jsonBody: event.avilable.toJson());
        return response;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(AddAvailableSuccess());
      });
    }));
    on<AvailableTimesEvent>((event, emit) async {
      final result = await BaseRepo.repoRequest(request: () async {
        final response =
            await client.getRequestAuth(url: ApiConstants.gettimes);
        final data = jsonDecode(response.body);
        final pros = AavailableTimesModel.fromJson(data);
        return pros;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(GetAvailbleTimesSuccess(times: responseData));
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return AvailableTimesError(message: 'No internet');

      case NetworkErrorFailure:
        return AvailableTimesError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return AvailableTimesError(
          message: 'Error',
        );
    }
  }
}
