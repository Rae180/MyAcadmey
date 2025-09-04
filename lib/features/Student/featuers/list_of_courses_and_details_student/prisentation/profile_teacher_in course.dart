import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/features/Student/featuers/list_of_courses_and_details_student/prisentation/bloc/cubit.dart';
import 'package:start/features/util/colors.dart';
import 'bloc/status.dart';

class ProfileTeacherInCourse extends StatelessWidget {
  //const ProfileTeacherInCourse({Key? key,required this.teacher}) : super(key: key);
  //final Teacher teacher;
  final String description =
  "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(BuildContext context)=>CourseStudentCubit(),
    child: BlocConsumer<CourseStudentCubit,CourseStudentStatus>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Teacher profile',
              style: TextStyle(color: mainColor),
            ),
            backgroundColor: fillColorInTextFormField,
            iconTheme: IconThemeData(color: mainColor),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  CircleAvatar(
                    //backgroundImage: NetworkImage('${teacher.photo}'),
                    radius: 110.r,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),

                 // ShowRateInstituteAndTeacher(rate: 3),
                  SizedBox(height: 15.h,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'You rate:',
                  //       style: TextStyle(
                  //           color: mainColor,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 20.sp),
                  //     ),
                  //     RatingBar.builder(
                  //       initialRating: 3,
                  //       minRating: 1,
                  //       direction: Axis.horizontal,
                  //       allowHalfRating: true,
                  //       itemCount: 5,
                  //       itemSize: 28,
                  //       itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  //       itemBuilder: (context, _) => Icon(
                  //         Icons.star,
                  //         color: Colors.amber,
                  //       ),
                  //       onRatingUpdate: (rating) {
                  //         print(rating);
                  //       },
                  //     ),
                  //   ],
                  // ),
                 /* detailsContainer(text: '${teacher.firstName}+${teacher.lastName}'),
                  detailsContainer(text: '${teacher.phoneNumber}'),*/
                 // detailsContainer(text: '${teacher.email}'),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
    );
  }
}
