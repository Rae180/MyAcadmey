import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/base_repo.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:start/core/errors/failures.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final BaseApiService client;
  SignupBloc({required this.client}) : super(SignupInitial()) {
    on<SigningupEvent>((event, emit) async {
      final result = await BaseRepo.repoRequest(request: () async {
        final response =
            await client.postRequest(url: ApiConstants.register, jsonBody: {
          "first_name": event.firstName,
          "last_name": event.lastName,
          "email": event.email,
          "phone_number": event.phone,
          "password": event.password
        });
        return response;
      });
      await result.fold((f) {
        emit(_mapFailureToState(f));
      }, (responseData) async {
        final token = responseData['token'] as String;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print("Login token saved: $token");
        emit(SignupSuccess());
      });
    });
  }
  _mapFailureToState(Failure f) {
    switch (f.runtimeType) {
      case OfflineFailure:
        return SignupError(message: 'No internet');

      case NetworkErrorFailure:
        return SignupError(
          message: (f as NetworkErrorFailure).message,
        );

      default:
        return SignupError(
          message: 'Error',
        );
    }
  }
}
