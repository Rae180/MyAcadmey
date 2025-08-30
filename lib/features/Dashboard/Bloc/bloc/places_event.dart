part of 'places_bloc.dart';

class PlacesEvent {}

final class AddNewPlaceEvent extends PlacesEvent {
  final String placeName;
  final String price;

  AddNewPlaceEvent({required this.placeName, required this.price});
}

final class UpdatePlaceEvent extends PlacesEvent {
  final String place;
  final String price;

  UpdatePlaceEvent({required this.place, required this.price});
}

final class GetPlacesEvent extends PlacesEvent {}
