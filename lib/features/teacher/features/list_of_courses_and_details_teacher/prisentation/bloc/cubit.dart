import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:start/features/teacher/features/list_of_courses_and_details_teacher/prisentation/bloc/status.dart';

import '../../../../../util/end_pointes.dart';
import '../../../../../util/shared_preferences.dart';
import '../../data/all_courses_teacher_model.dart';
import '../../data/details_courses_teacher_model.dart';
import '../../data/show_lessons_teacher_model.dart';
import '../../data/studentForAddDegreeModel.dart';
class CourseTeacherCubit extends Cubit<CourseTeacherStatus>{
  CourseTeacherCubit():super(CourseTeacherInitializeState());
  static CourseTeacherCubit get(context)=>BlocProvider.of(context);
  AllCoursesTeacherModel ?allCoursesTeacherModel;
  Future<AllCoursesTeacherModel?> getAllCourses() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    emit(CourseTeacherLoadingState());
    final response = await http.get(
        Uri.parse('${URL}allCoursesTeacher'),headers: headers);

    if (response.statusCode == 200) {
      print("institute details success");
      // print(response.body);
      final parsedJson = jsonDecode(response.body);
      allCoursesTeacherModel= AllCoursesTeacherModel.fromJson(parsedJson);
      // print(allCoursesTeacherModel!.message);
      emit(CourseTeacherSuccessState(allCoursesTeacherModel!));
    }else {
      print("certificate field");
      emit(CourseTeacherErrorState());
      throw Exception('Failed to load profile data');
    }
  }
  ///get details course for teacher -----------------------------
  DetailsCoursesTeacherModel ?detailsCoursesTeacherModel;
  Future<AllCoursesTeacherModel?> getCourses(int id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    emit(CourseTeacherOneLoadingState());
    final response = await http.get(
        Uri.parse('${URL}detailsCourseTeacher/${id}'),headers: headers);

    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      // print(response.body);
      detailsCoursesTeacherModel= DetailsCoursesTeacherModel.fromJson(parsedJson);
      // print(detailsCoursesTeacherModel!.message);
      emit(CourseTeacherOneSuccessState(detailsCoursesTeacherModel!));
    }else {
      print("certificate field");
      emit(CourseTeacherOneErrorState());
      throw Exception('Failed to load profile data');
    }
  }
  ///show lessons teacher-----------------------------------------------------------
  ShowLessonsTeacherModel? showLessonsTeacherModel;
  Future<ShowLessonsTeacherModel?> getLessons(int id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    emit(ShowLessonsLoadingState());
    final response = await http.get(
        Uri.parse('${URL}showLessons/${id}'),headers: headers);

    if (response.statusCode == 200) {
      // print("institute details success");
      // print(response.body);
      final parsedJson = jsonDecode(response.body);
      // print(response.body);
      showLessonsTeacherModel= ShowLessonsTeacherModel.fromJson(parsedJson);

      emit(ShowLessonsSuccessState(showLessonsTeacherModel!));
    }else {
      print("certificate field");
      emit(ShowLessonsErrorState());
      throw Exception('Failed to load profile data');
    }
  }
  ///--------------add lesson--------------------------------
  Future<void> addLesson( int id ,String name, String title1,String title2,String title3,String title4,String title5,String title6) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    // Define the API endpoint URL
    final url = Uri.parse('${URL}teacher/courses/$id/add-lesson');

    // Create a map with the request data
    final data = {
      'name': name,
      'title1': title1,
      'title2': title2,
      'title3': title3,
      'title4':title4,
      'title5': title5,
      'title6': title6
    };

    try {
      print("tryyy");
      // emit(LoginScreenLoadingState());

      final response = await http.post(url, body: data,headers:headers);
      // Check if the request was successful
      if (response.statusCode == 200) {

        // Request successful, do something with the response
        print('Login successful');
        print(response.body);
        final responseData = jsonDecode(response.body);
        // return UserModel.fromJson(responseData);
        //  loginModel=LoginModel.fromJson(responseData);
        //emit(LoginScreenSuccessState(loginModel));
        // print(loginModel.role);
        // print(loginModel.token);
      } else {
        // emit(LoginScreenErrorState());
        // Request failed, handle the error
        print('Login failed');
        print('Status code: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      print(e);
      emit(state);
      print("An error occurred: $e");

    }
  }
///
  StudentForAddDegreeModel ?studentForAddDegreeModel;
  Future<StudentForAddDegreeModel?> getStudentForAddDegree(int id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    final response = await http.get(
        Uri.parse('${URL}teacher/courses/$id/students-marks'),headers: headers);

    if (response.statusCode == 200) {

      final parsedJson = jsonDecode(response.body);
      print(parsedJson);
      studentForAddDegreeModel= StudentForAddDegreeModel.fromJson(parsedJson);
      emit(GetStudentAddDegreeSuccessState(studentForAddDegreeModel!));
    }else {
      print("certificate field");
     emit(GetStudentAddDegreeErrorState());
      throw Exception('Failed to load profile data');
    }
  }

  AddDegreeModel? addDegreeModel;
  Future<void> AddDegree(int id,String data) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    final response = await http.post(
        Uri.parse('${URL}teacher/courses/$id/add-marks'),headers: headers,body: data);

    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      print(parsedJson);
      addDegreeModel= AddDegreeModel.fromJson(parsedJson);
      emit(AddDegreeSuccessState(addDegreeModel!));
    }else {
      print("certificate field");
      emit(AddDegreeErrorState());
      throw Exception('Failed to load profile data');
    }
  }
}