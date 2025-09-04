import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/features/Student/featuers/signup/prisentation/bloc/states.dart';

import '../../../../../util/end_pointes.dart';
import 'package:http/http.dart' as http;

import '../../data/sing_in_model.dart';

class SignInCubit extends Cubit<SignInScreenStates> {
  // final DioHelper dioHelper;
  // late SignInModel signInModel;
  String? errorState;

  SignInCubit() : super(SignInInitialState());

// SignInCubit({required this.dioHelper}):super(SignInInitialState()) ;
  static SignInCubit get(context) => BlocProvider.of(context);
  late SignInModel signInModel;

  Future<void> userSignIn(String name,  String email,
      String phoneNumber, String password , String c_password ) async {
    // Define the API endpoint URL
    final url = Uri.parse('${URL}signup');
    //final url = Uri.parse('${URL}student/register');


    // Create a map with the request data
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'C_password': password,
      'phone_number': phoneNumber,
      'role' : "student"
    };

    try {
      emit(SignInLoadingState());
      final response = await http.post(url, body: data);

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Request successful, do something with the response
        print('Login successful');
        print(response.body);
        final responseData = jsonDecode(response.body);
        signInModel = SignInModel.fromJson(responseData);
        emit(SignInSuccessState(signInModel));
      } else {
        emit(SignInErrorState());
        print(response.body);
        // Request failed, handle the error
        print('singin Filed failed');
      }
    } catch (e) {
      emit(SignInErrorState());
      // An error occurred during the request
      print('Errorpppppp: $e');
    }
  }

  IconData suffix = Icons.visibility;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;

    suffix = isPasswordShow ? Icons.visibility : Icons.visibility_off;
    emit(SignInChangePasswordVisibilityState());
  }
}
