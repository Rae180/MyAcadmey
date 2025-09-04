import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart'as http;
import 'package:start/features/Student/featuers/list_of_courses_and_details_student/prisentation/bloc/status.dart';
import '../../../../../util/end_pointes.dart';
import '../../../../../util/shared_preferences.dart';
import '../../data/Question.dart';
import '../../data/courses_and_offers_model.dart';
import '../../data/show_lessons_student_model.dart';
import '../../data/show_ten_offers_model.dart';

class CourseStudentCubit extends Cubit<CourseStudentStatus>{
  CourseStudentCubit():super(CourseStudentInitializeState());

  ///show courses and offers
  ShowCoursesAndOffersModel ?showCoursesAndOffersModel;
  Future<ShowCoursesAndOffersModel?> getListCoursesAndOffers() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    final response = await http.get(
        Uri.parse('${URL}showAllCourse'),headers: headers);

    if (response.statusCode == 200) {
      print("institute details success");
       //print(response.body);
      final parsedJson = jsonDecode(response.body);
      // print(response.body);
      showCoursesAndOffersModel= ShowCoursesAndOffersModel.fromJson(parsedJson);
      //print(showCoursesAndOffersModel!.courses);
      emit(CourseStudentSuccessState(showCoursesAndOffersModel!));
    }else {
      print("certificate field");
      emit(CourseStudentErrorState());
      throw Exception('Failed to load profile data');
    }
  }
  ///ten offer -------------------------------------------------------------------------------------
 ShowTenOffersModel ?showTenOffersModel;
  Future<ShowCoursesAndOffersModel?> getTenOffer() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    final response = await http.get(
        Uri.parse('${URL}showOffers'),headers: headers);

    if (response.statusCode == 200) {
      print("ten  offers success");
     // print(response.body);
      final parsedJson = jsonDecode(response.body);
      // print(response.body);
      showTenOffersModel= ShowTenOffersModel.fromJson(parsedJson);
    //  print(showTenOffersModel.);
      emit(TenOffersSuccessState(showTenOffersModel!));
    }else {
      print("ten offers  field");
      emit(TenOffersErrorState());
      throw Exception('Failed to load profile data');
    }
  }
  ///get details course student----------------------------
  ShowLessonStudentModel ?showLessonStudentModel;
  Future<ShowLessonStudentModel?> getLessons(int id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    emit(ShowLessonStudentLoadingState());
    final response = await http.get(
        Uri.parse('${URL}showLessons/${id}'),headers: headers);

    if (response.statusCode == 200) {
    //print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
     // print(response.body);
      showLessonStudentModel= ShowLessonStudentModel.fromJson(parsedJson);

      emit(ShowLessonStudentSuccessState(showLessonStudentModel!));
    }else {
      print("certificate field");
      emit(ShowLessonStudentErrorState());
      throw Exception('Failed to load profile data');
    }
  }
  ///solve exam-------------------------------------------------
//   Future<void> solveExam(String email, String password) async {
//     // Define the API endpoint URL
//     final url = Uri.parse('${URL}login');
//
//     // Create a map with the request data
//     final data = {'email': 'ahm@gmail.com', 'password': 'password'};
//
//     try {
//       print("tryyy");
//       emit(LoginScreenLoadingState());
//
//       final response = await http.post(url, body: data);
//       // Check if the request was successful
//       if (response.statusCode == 200) {
//
//         // Request successful, do something with the response
//         print('Login successful');
//         print(response.body);
//         final responseData = jsonDecode(response.body);
//         // return UserModel.fromJson(responseData);
//         loginModel=LoginModel.fromJson(responseData);
//         emit(LoginScreenSuccessState(loginModel));

//       } else {
//         emit(LoginScreenErrorState());
//         // Request failed, handle the error
//         print('Login failed');
//         print('Status code: ${response.statusCode}');
//         print('Error message: ${response.body}');
//       }
//     } catch (e) {
// print(e);
//     }
//   }

///get question
 ShowExamQuestionModel? showExamQuestionModel;
  Future<ShowExamQuestionModel?> getQuestion(int id ) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    emit(ShowQuestionLoadingState());
    final response = await http.get(
        Uri.parse('${URL}student/courses/${id}/questions'),headers: headers);

    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      showExamQuestionModel= ShowExamQuestionModel.fromJson(parsedJson);
      emit(ShowQuestionSuccessState(showExamQuestionModel!));
    }else {
      print("certificate field");
      emit(ShowQuestionErrorState());
      throw Exception('Failed to load profile data');
    }
  }


}