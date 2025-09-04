import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/features/Student/featuers/home_student/prisentation/bloc/states.dart';
import '../../../chatting_student_managemetn/prisentation/chatting_student.dart';
import '../../../list_institute_and_details_student/prisentation/lsit_of_institute_student.dart';
import '../../../list_of_courses_and_details_student/prisentation/list_of_courses_student.dart';
import '../../../notification_student_management/prisentation/notification_student.dart';
import '../../../profile_student_management/prisentation/profile_student.dart';



class HomeStudentCubit extends Cubit<HomeStudentStates>{
  HomeStudentCubit():super(HomeInitialState());
  static HomeStudentCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 2;

  List<Widget> screen = [

    ListOfInstituteStudent(),
    ProfileStudent(),
    ListOfCoursesStudent(),
    NotificationStudent(),
    ChattingStudent()



  ];

  void changeIndex(int index) {

    currentIndex = index;

    emit(HomeChangeBottomNavBarState());
  }

}