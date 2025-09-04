import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/colors.dart';
import '../data/show_lessons_student_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class ShowLessonsStudent extends StatelessWidget {
   ShowLessonsStudent({Key? key,required this.id}) : super(key: key);
final int id;
ShowLessonStudentModel ?showLessonStudentModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>CourseStudentCubit()..getLessons(id),

    child:BlocConsumer<CourseStudentCubit,CourseStudentStatus>(
      listener: (context,state){
        if(state is ShowLessonStudentSuccessState)
          showLessonStudentModel=state.showLessonStudentModel;
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: fillColorInTextFormField,
            foregroundColor: mainColor,
            title: Text("Lessons",style: TextStyle(
                fontSize: 24.sp,fontWeight: FontWeight.bold,color: mainColor
            ),),
          ),
          body:showLessonStudentModel?.data==null?Center(child: CircularProgressIndicator(),): ListView.builder(
              itemCount: showLessonStudentModel!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 350.w,
                    height: 270.h,
                    decoration: BoxDecoration(
                        color: fillColorInTextFormField,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: borderContainer,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${showLessonStudentModel!.data![index].name}",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          ),
                          SizedBox(height: 15.h,),
                          Text(
                            "${showLessonStudentModel!.data![index].lesson}",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.normal,
                                color: mainColor),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            "${showLessonStudentModel!.data![index].lesson}",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.normal,
                                color: mainColor),
                          ),
                          SizedBox(height: 10.h,),
                          // Text(
                          //   "${showLessonStudentModel!.data![index].title3}",
                          //   style: TextStyle(
                          //       fontSize: 18.sp,
                          //       fontWeight: FontWeight.normal,
                          //       color: mainColor),
                          // ),
                          // SizedBox(height: 10.h,),
                          // Text(
                          //   "${showLessonStudentModel!.data![index].title4}",
                          //   style: TextStyle(
                          //       fontSize: 18.sp,
                          //       fontWeight: FontWeight.normal,
                          //       color: mainColor),
                          // ),
                          // SizedBox(height: 10.h,),
                          // Text(
                          //   "${showLessonStudentModel!.data![index].title5}",
                          //   style: TextStyle(
                          //       fontSize: 18.sp,
                          //       fontWeight: FontWeight.normal,
                          //       color: mainColor),
                          // ),
                          // SizedBox(height: 10.h,),
                          // Text(
                          //   "${showLessonStudentModel!.data![index].title6}",
                          //   style: TextStyle(
                          //       fontSize: 18.sp,
                          //       fontWeight: FontWeight.normal,
                          //       color: mainColor),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    ) ,
    );
  }
}
