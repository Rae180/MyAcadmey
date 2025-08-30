part of 'orders_bloc.dart';

class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class GetOrdersSuccess extends OrdersState {
  final DeliveryOrdersModel orders;

  GetOrdersSuccess({required this.orders});
}

final class GetOrdersScheduleSuccess extends OrdersState {
  final OrdersScheduleModel schedules;

  GetOrdersScheduleSuccess({required this.schedules});
}

final class UpdateOrderStatueSuccess extends OrdersState {}

final class OrdersError extends OrdersState {
  final String message;

  OrdersError({required this.message});
}
