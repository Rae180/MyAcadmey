part of 'places_bloc.dart';

class PlacesState {}

final class PlacesInitial extends PlacesState {}

final class PlacesLoading extends PlacesState {}

final class GetPlacesSuccess extends PlacesState {
  final PlacesModel places;

  GetPlacesSuccess({required this.places});
}

final class AddNewPlaceSuccess extends PlacesState {}

final class UpdatePlaceSuccess extends PlacesState {}

final class PlacesError extends PlacesState {
  final String message;

  PlacesError({required this.message});
}
