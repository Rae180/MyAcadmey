import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:start/features/both/Login/prisentation/bloc/status.dart';
import '../../../../util/end_pointes.dart';
import '../../data/login_model.dart';




class LoginScreenCubit extends Cubit<LoginScreenStatus>{
  LoginScreenCubit():super(LoginScreenInitializeState());

  static LoginScreenCubit get(context)=>BlocProvider.of(context);


  late LoginModel loginModel;
  Future<void> userLogin(String email, String password) async {
    // Define the API endpoint URL
    final url = Uri.parse('${URL}login');

    // Create a map with the request data
    final data = {'email': email, 'password': password};

    try {
      // print("tryyy");
      emit(LoginScreenLoadingState());

      final response = await http.post(url, body: data);
      // Check if the request was successful
      if (response.statusCode == 200) {

        // Request successful, do something with the response
        print('Login successful');
        print(response.body);
         final responseData = jsonDecode(response.body);
        // return UserModel.fromJson(responseData);
       loginModel=LoginModel.fromJson(responseData);
        emit(LoginScreenSuccessState(loginModel));
       // print(loginModel.role);
       // print(loginModel.token);
      } else {
        emit(LoginScreenErrorState());
        // Request failed, handle the error
        print('Login failed');
        print('Status code: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
    print(e);
      emit(LoginScreenErrorState());
      // An error occurred during the request
      if (e is TimeoutException) {
        print("Connection timed out");
      } else if (e is SocketException) {
        print("SocketException: ${e}");
      } else if (e is HttpException) {
        print("HttpException: Check server response");
      } else {
        print("An error occurred: $e");
      }
    }
  }

  IconData suffix=Icons.visibility;
  bool isPasswordShow=true;
  void changePasswordVisibility(){
    isPasswordShow=!isPasswordShow;

    suffix= isPasswordShow?
    Icons.visibility:Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }
}