import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/Dashboard/Models/PlacesModel.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final BaseApiService client;
  PlacesBloc({required this.client}) : super(PlacesInitial()) {
    on<GetPlacesEvent>(((event, emit) async {
      final result = await BaseRepo.repoRequest(request: () async {
        final response =
            await client.getRequestAuth(url: ApiConstants.getPlaces);
        final data = jsonDecode(response.body);
        final places = PlacesModel.fromJson(data);
        return places;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(GetPlacesSuccess(places: responseData));
      });
    }));
    on<UpdatePlaceEvent>(((event, emit) async {
      final result = await BaseRepo.repoRequest(request: () async {
        final response = await client.putRequestAuth(
            url: ApiConstants.updatePlce + event.place,
            jsonBody: {"price": event.price});
        return response;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(UpdatePlaceSuccess());
      });
    }));
    on<AddNewPlaceEvent>((event, emit) async {
      final result = await BaseRepo.repoRequest(request: () async {
        final response = await client.postRequestAuth(
            url: ApiConstants.addplace,
            jsonBody: {"place": event.placeName, "price": event.price});
        return response;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(AddNewPlaceSuccess());
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return PlacesError(message: 'No internet');

      case NetworkErrorFailure:
        return PlacesError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return PlacesError(
          message: 'Error',
        );
    }
  }
}
