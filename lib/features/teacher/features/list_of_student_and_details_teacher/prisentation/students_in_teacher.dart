import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/colors.dart';
import '../data/list_of_student_in_course.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class StudentsDetailsInTeacher extends StatelessWidget {
   StudentsDetailsInTeacher({Key? key,required this.id}) : super(key: key);
final int? id ;

   ListOfStudentInCourseModel ?listOfStudentInCourseModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StudentInTeacherCubit()..getAllStudentInCourse(id!),
      child: BlocConsumer<StudentInTeacherCubit, StudentInTeacherState>(
        listener: (context, state) {
          if(state is StudentInTeacherDetailsSuccessState)
            listOfStudentInCourseModel=state.listOfStudentInCourseModel;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Student details',
                style: TextStyle(color: mainColor),
              ),
              backgroundColor: fillColorInTextFormField,
              iconTheme: IconThemeData(color: mainColor),
            ),
            body:listOfStudentInCourseModel?.students==null?Center(child: CircularProgressIndicator(),): GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.h,
                  mainAxisSpacing: 5.h),
              itemCount: listOfStudentInCourseModel?.students?.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('${listOfStudentInCourseModel!.students?[index].photo}'),
                      radius: 40.r,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      '${listOfStudentInCourseModel!.students?[index].name}',
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
