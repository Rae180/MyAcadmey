import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/Orders/Models/DeliveryOrdersModel.dart';
import 'package:start/features/Orders/Models/OrdersSvheduleModel.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final BaseApiService client;
  OrdersBloc({required this.client}) : super(OrdersInitial()) {
    on<GetOrdersScheduleEvent>(((event, emit) async {
      final result = await BaseRepo.repoRequest(request: () async {
        final response =
            await client.getRequestAuth(url: ApiConstants.getschedules);
        final data = jsonDecode(response.body);
        final pros = OrdersScheduleModel.fromJson(data);
        return pros;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(GetOrdersScheduleSuccess(schedules: responseData));
      });
    }));
    on<GetOrdersEvent>(((event, emit) async {
      final result = await BaseRepo.repoRequest(request: () async {
        final response =
            await client.getRequestAuth(url: ApiConstants.getorders);
        final data = jsonDecode(response.body);
        final pros = DeliveryOrdersModel.fromJson(data);
        return pros;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(GetOrdersSuccess(orders: responseData));
      });
    }));
    on<UpdateOrderStatueEvent>((event, emit) async {
      final result = await BaseRepo.repoRequest(request: () async {
        final response = await client.putRequestAuth(
            url: ApiConstants.updtestatue + event.id.toString(), jsonBody: {});
        return response;
      });
      result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) {
        emit(UpdateOrderStatueSuccess());
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return OrdersError(message: 'No internet');

      case NetworkErrorFailure:
        return OrdersError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return OrdersError(
          message: 'Error',
        );
    }
  }
}
