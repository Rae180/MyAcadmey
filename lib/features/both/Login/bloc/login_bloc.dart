import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';
import 'package:start/features/both/Login/Models/login_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BaseApiService client;
  LoginBloc({required this.client}) : super(LoginInitial()) {
    on<LoginingEvent>((event, emit) async {
      final result = await BaseRepo.repoRequest(request: () async {
        final response = await client.postRequest(
            url: ApiConstants.login,
            jsonBody: {'email': event.email, 'password': event.paassword});
        return response;
      });
      await result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) async {
        // Extract token from response and save it
        final token = responseData['token'] as String;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print("Login token saved: $token");
        emit(LoginSuccess());
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return LoginError(message: 'No internet');

      case NetworkErrorFailure:
        return LoginError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return LoginError(
          message: 'Error',
        );
    }
  }
}
