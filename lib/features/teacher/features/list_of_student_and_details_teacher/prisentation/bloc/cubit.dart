import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:start/features/teacher/features/list_of_student_and_details_teacher/prisentation/bloc/status.dart';
import '../../../../../util/end_pointes.dart';
import '../../../../../util/shared_preferences.dart';
import '../../../list_of_courses_and_details_teacher/data/all_courses_teacher_model.dart';
import 'package:http/http.dart'as http;

import '../../data/list_of_student_in_course.dart';
class StudentInTeacherCubit extends Cubit<StudentInTeacherState>{
  StudentInTeacherCubit():super(StudentInTeacherInitializeState());
  AllCoursesTeacherModel ?allCoursesTeacherModel;





  Future<AllCoursesTeacherModel?> getAllCourses() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    emit(StudentInTeacherLoadingState());
    final response = await http.get(
        Uri.parse('${URL}allCoursesTeacher'),headers: headers);

    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      // print(response.body);
      allCoursesTeacherModel= AllCoursesTeacherModel.fromJson(parsedJson);
      // print(allCoursesTeacherModel!.message);
      emit(StudentInTeacherSuccessState(allCoursesTeacherModel!));
    }else {
      // print("student success suc66666666666666666666666cess");

      emit(StudentInTeacherErrorState());
      throw Exception('Failed to load profile data');
    }
  }
  ///student --------------------------in course

  ListOfStudentInCourseModel ?listOfStudentInCourseModel;
  Future<AllCoursesTeacherModel?> getAllStudentInCourse(int id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    emit(StudentInTeacherDetailsLoadingState());
    final response = await http.get(
        Uri.parse('${URL}ListOfStudentInCourse/${id}'),headers: headers);
    print("student success suc66666666666666666666666cess");
    if (response.statusCode == 200) {
      print("student success success");
      // print(response.body);
      final parsedJson = jsonDecode(response.body);
      // print(response.body);
      listOfStudentInCourseModel= ListOfStudentInCourseModel.fromJson(parsedJson);
      print(listOfStudentInCourseModel);
      emit(StudentInTeacherDetailsSuccessState(listOfStudentInCourseModel!));
    }else {
      print('student field');
      // print("certificate field");
      emit(StudentInTeacherDetailsErrorState());
      throw Exception('Failed to load profile data');
    }
  }

}
