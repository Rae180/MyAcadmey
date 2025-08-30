part of 'orders_bloc.dart';

class OrdersEvent {}

final class GetOrdersEvent extends OrdersEvent {}

final class UpdateOrderStatueEvent extends OrdersEvent {
  final int id;

  UpdateOrderStatueEvent({required this.id});
}

final class GetOrdersScheduleEvent extends OrdersEvent {}
