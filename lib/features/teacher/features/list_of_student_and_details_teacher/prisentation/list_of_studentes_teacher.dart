import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/features/teacher/features/list_of_student_and_details_teacher/prisentation/students_in_teacher.dart';
import '../../../../util/colors.dart';
import '../../list_of_courses_and_details_teacher/data/all_courses_teacher_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class ListOfStudentTeacher extends StatelessWidget {
   ListOfStudentTeacher({Key? key}) : super(key: key);
  AllCoursesTeacherModel ?allCoursesTeacherModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>StudentInTeacherCubit()..getAllCourses(),
    child: BlocConsumer<StudentInTeacherCubit,StudentInTeacherState>(
      listener: (context,state){
        if(state is StudentInTeacherSuccessState)
          allCoursesTeacherModel=state.allCoursesTeacherModel;

      },
      builder: (context,state){
        return Scaffold(
          body:allCoursesTeacherModel?.courses==null?Center(child: CircularProgressIndicator(),):  ListView.builder(
              itemCount: allCoursesTeacherModel?.courses?.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StudentsDetailsInTeacher(id: allCoursesTeacherModel!.courses?[index].id,)));
                    // navigateTo(context, CourseDetails());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 109.h,

                    decoration: BoxDecoration(
                        color: fillColorInTextFormField,
                        borderRadius: BorderRadius.circular(0.r),
                        border: Border.all(
                          color: borderContainer,
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 10.w,),
                        CircleAvatar(
                          backgroundImage: AssetImage('${allCoursesTeacherModel!.courses?[index].courseImage}'),
                          radius: 45.r,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top :20,right: 0,bottom: 20),
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(' ${allCoursesTeacherModel!.courses?[index].name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp,color: mainColor),),
                              Text(' ${allCoursesTeacherModel!.courses?[index].studentNumber}',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14.sp,color: mainColor),),

                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1,top :25,right: 10,bottom: 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(' ${allCoursesTeacherModel!.courses?[index].academyName}',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14.sp,color: mainColor),),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }),
        );
      },
    ),
    );
  }
}
