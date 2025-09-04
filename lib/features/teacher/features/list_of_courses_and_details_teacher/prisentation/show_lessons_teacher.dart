import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/colors.dart';
import '../data/show_lessons_teacher_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class ShowLessonsTeacher extends StatelessWidget {
   ShowLessonsTeacher({Key? key ,required this.id}) : super(key: key);
final int? id;
   ShowLessonsTeacherModel? showLessonsTeacherModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => CourseTeacherCubit()..getLessons(id!),
      child: BlocConsumer<CourseTeacherCubit, CourseTeacherStatus>(
        listener: (context, state) {
          if(state is ShowLessonsSuccessState)
            showLessonsTeacherModel=state.showLessonsTeacherModel;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: fillColorInTextFormField,
              foregroundColor: mainColor,
              title: Text("Lessons", style: TextStyle(
                  fontSize: 24.sp, fontWeight: FontWeight.bold, color: mainColor
              ),),
            ),
            body:showLessonsTeacherModel?.data == null ? Center(child: CircularProgressIndicator(),): ListView.builder(
                itemCount: showLessonsTeacherModel?.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 350.w,
                      height: 250.h,
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
                              "${showLessonsTeacherModel!.data?[index].name}",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor),
                            ),
                            SizedBox(height: 15.h,),
                            Text(
                              "${showLessonsTeacherModel!.data?[index].name}",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  color: mainColor),
                            ),
                            SizedBox(height: 10.h,),
                            Text(
                              "${showLessonsTeacherModel!.data?[index].name}",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  color: mainColor),
                            ),
                            SizedBox(height: 10.h,),
                            Text(
                              "${showLessonsTeacherModel!.data?[index].name}",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  color: mainColor),
                            ),
                            SizedBox(height: 10.h,),
                            Text(
                              "${showLessonsTeacherModel!.data?[index].name}",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  color: mainColor),
                            ),
                            SizedBox(height: 10.h,),
                            // Text(
                            //   "${showLessonsTeacherModel!.data?[5]}",
                            //   style: TextStyle(
                            //       fontSize: 18.sp,
                            //       fontWeight: FontWeight.normal,
                            //       color: mainColor),
                            // ),
                            // SizedBox(height: 10.h,),
                            // Text(
                            //   "${showLessonsTeacherModel!.data?[6]}",
                            //   style: TextStyle(
                            //       fontSize: 18.sp,
                            //       fontWeight: FontWeight.normal,
                            //       color: mainColor),
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //
                            //     // Padding(
                            //     //   padding: const EdgeInsets.all(8.0),
                            //     //   child: Text("delete lesson", style: TextStyle(
                            //     //       fontSize: 18.sp,
                            //     //       fontWeight: FontWeight.bold,
                            //     //       color: Colors.red),),
                            //     // ),
                            //   ],
                            // )
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
