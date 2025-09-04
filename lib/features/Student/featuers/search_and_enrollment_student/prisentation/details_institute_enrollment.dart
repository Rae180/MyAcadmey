import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/features/Student/featuers/search_and_enrollment_student/prisentation/bloc/cubit.dart';
import 'package:start/features/Student/featuers/search_and_enrollment_student/prisentation/bloc/status.dart';
import 'package:start/features/teacher/features/home/prisentation/widget/checkboxLanguge.dart';
import 'package:start/features/teacher/features/home/prisentation/widget/rate_and_like_and_dislike.dart';
import 'package:start/features/teacher/features/list_institute_and_details_teacher/prisentation/widget/drop_button.dart';
import 'package:start/features/util/colors.dart';
import 'package:start/features/util/summary.dart';

import '../../../../util/defaultbutton.dart';
import '../../../../util/details_container.dart';
import '../data/search_institute_student_mode.dart';

class DetailsInstituteEnrollment extends StatelessWidget {
  DetailsInstituteEnrollment({Key? key, required this.dat}) : super(key: key);
  Data? dat;
  final String description =
      "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line";
  final List<String> items = [
    'English',
    'french',
    'Spanish',
    'Germany',
  ];
  String? selectedValue = "English";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchStudentCubit(),
      child: BlocConsumer<SearchStudentCubit, SearchStudentStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'institute details',
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
                      backgroundImage: NetworkImage('${dat!.image}'),
                      radius: 110.r,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Institute rate',
                          style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ShowRateInstituteAndTeacher(rate: 3),
                      ],
                    ),
                    detailsContainer(text: '${dat!.name}'),
                    detailsContainer(text: '${dat!.location}'),
                    SizedBox(
                      height: 15.h,
                    ),
                    LanguageInDetailsInstitute(
                        english: dat!.english!.isOdd,
                        french: dat!.french!.isOdd,
                        spanish: dat!.spanish!.isOdd,
                        germany: dat!.germany!.isOdd),
                    SizedBox(
                      height: 15.h,
                    ),
                    ShowMoreShowLess(text: dat!.description),
                    SizedBox(
                      height: 15.h,
                    ),
                    defaultbutton(
                        function: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage()));
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => Center(
                                    child: Dialog(
                                      backgroundColor: fillColorInTextFormField,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      //this right here
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 150.h,
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                  "Please visit us within a maximum of four days",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 20.sp,
                                                      color: mainColor)),
                                              DropListItem(
                                                  item: selectedValue,
                                                  s: items),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        'cancel',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20.sp,
                                                            color: mainColor),
                                                      )),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        //SearchStudentCubit.get(context).enrollInInstitute(dat!.id!,);
                                                      },
                                                      child: Text(
                                                        'Enroll',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20.sp,
                                                            color: mainColor),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                        },
                        text: 'Enroll',
                        //textColor: Colors.white,
                        width: 128.w,
                        height: 41.h,
                        fontSizeText: 18.sp,
                        textColor: fillColorInTextFormField,
                        backround: mainColor),
                    SizedBox(
                      height: 30.h,
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
