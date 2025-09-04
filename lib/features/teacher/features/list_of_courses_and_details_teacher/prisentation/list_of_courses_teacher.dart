import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../util/colors.dart';
import '../../../../util/show_message_on_screen.dart';
import '../data/all_courses_teacher_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';
import 'courseDetailsTeacher.dart';

class ListOfCoursesTeacher extends StatelessWidget {
   ListOfCoursesTeacher({Key? key}) : super(key: key);
  AllCoursesTeacherModel ?allCoursesTeacherModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>CourseTeacherCubit()..getAllCourses(),
    child:  BlocConsumer<CourseTeacherCubit,CourseTeacherStatus>(
      listener: (context,state){
        if(state is CourseTeacherSuccessState)
          allCoursesTeacherModel=state.allCoursesTeacherModel;
        if(state is CourseTeacherErrorState)
          showMessageOnScreen(context: context,messageText: "connt show your courses",
            titleText: "error loaded"
                ,titleColor: Colors.red
          );
      },
      builder: (context,state){
        return Scaffold(
          body:allCoursesTeacherModel?.courses==null?Center(child: CircularProgressIndicator()): ListView.builder(
              itemCount: allCoursesTeacherModel?.courses?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CourseDetails(id: allCoursesTeacherModel!.courses?[index].id,)));
                      // navigateTo(context, CourseDetails());
                    },
                    child: Container(
                      width: 380.w,
                      height: 107.h,
                      decoration: BoxDecoration(
                          color: fillColorInTextFormField,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: borderContainer,
                          )),
                      child: Row(
                        children: [
                          Container(
                            height: 107.h,
                            width: 107.w,
                            decoration: BoxDecoration(
                              image:DecorationImage(fit: BoxFit.cover,image:  NetworkImage('${allCoursesTeacherModel!.courses?[index].courseImage}'), ),
                              color: fillColorInTextFormField,
                              borderRadius: BorderRadius.circular(10.r),
                              // border: Border.all(
                              //   color: borderContainer,
                              // )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${allCoursesTeacherModel!.courses?[index].name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: mainColor),),
                                Text('${allCoursesTeacherModel!.courses?[index].academyName}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,color: mainColor),),
                                Text("${allCoursesTeacherModel!.courses?[index].startTime}",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16.sp,color: mainColor),)
                              ],
                            ),
                          )
                        ],
                      ),
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
