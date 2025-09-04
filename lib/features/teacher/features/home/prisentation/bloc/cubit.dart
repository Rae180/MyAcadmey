import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/features/teacher/features/home/prisentation/bloc/states.dart';

import '../../../chatting_teacher_management/prisentation/chatting.dart';
import '../../../list_institute_and_details_teacher/prisentation/list_of_institute_teacher.dart';
import '../../../list_of_student_and_details_teacher/prisentation/list_of_studentes_teacher.dart';
import '../../../profile_teacher_management/prisentation/profile_teacher.dart';
import '../../../list_of_courses_and_details_teacher/prisentation/list_of_courses_teacher.dart';

class HomeTeacherCubit extends Cubit<HomeTeacherStates>{
  HomeTeacherCubit():super(HomeInitialState());
  static HomeTeacherCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 2;

  List<Widget> screen = [

    ListOfInstituteTeacher(),
    ProfileTeacher(),
    ListOfCoursesTeacher(),
    ListOfStudentTeacher(),
    Chatting(),



  ];

  void changeIndex(int index) {

    currentIndex = index;

    emit(HomeChangeBottomNavBarState());
  }

}