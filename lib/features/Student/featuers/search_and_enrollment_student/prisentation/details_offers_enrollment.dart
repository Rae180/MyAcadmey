import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/features/Student/featuers/home_student/prisentation/home_student.dart';
import 'package:start/features/Student/featuers/search_and_enrollment_student/prisentation/bloc/cubit.dart';
import 'package:start/features/Student/featuers/search_and_enrollment_student/prisentation/bloc/status.dart';
import 'package:start/features/util/colors.dart';
import 'package:start/features/util/defaultbutton.dart';
import 'package:start/features/util/show_message_on_screen.dart';
import 'package:start/features/util/summary.dart';
import '../data/search_offer_student_model.dart';



class DetailsOffersEnrollment extends StatelessWidget {
   DetailsOffersEnrollment({Key? key,required this.data}) : super(key: key);
  final String description =
      "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line";
 Data? data;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>SearchStudentCubit(),
    child: BlocConsumer<SearchStudentCubit,SearchStudentStatus>(
      listener: (context,state){
        if(state is EnrollOfferSuccessState)
          {
            showMessageOnScreen(context: context, titleText: "Enroll Success", messageText: "Enrolled Successfully",backgroundColor: Colors.red);
          }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: fillColorInTextFormField,
            foregroundColor: mainColor,
            title: Text(
              "details offers",
              style: TextStyle(
                  fontSize: 24.sp, fontWeight: FontWeight.bold, color: mainColor),
            ),
          ),
          body:data==null?Center(child: CircularProgressIndicator(),): SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    width: 217.w,
                    height: 183.h,
                    decoration: BoxDecoration(
                        color: fillColorInTextFormField,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '${data!.image}',
                            )),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all()),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    width: 290.w,
                    height: 226.h,
                    decoration: BoxDecoration(
                        color: fillColorInTextFormField,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all()),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${data!.name}",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          ),
                          Text(
                            "${data!.academy!.name}",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          ),
                          Text(
                            "${data!.academy!.location} ",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: mainColor),
                          ),
                          Text(
                            "Start in: ${data!.startDate}",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.normal,
                                color: mainColor),
                          ),
                          Text(
                            "end in: ${data!.endDate}",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.normal,
                                color: mainColor),
                          ),
                          Text(
                            "Number of hour :${data!.hours} hour",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.normal,
                                color: mainColor),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15.h,
                  ),
                  ShowMoreShowLess(text: data!.description),
                  SizedBox(
                    height: 15.h,
                  ),
                  defaultbutton(
                      function: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext ccontext) => Center(
                              child: Dialog(
                                backgroundColor: fillColorInTextFormField,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                //this right here
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 120.h,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            "Please visit us within a maximum of ${data!.academy!.deleteTime} days",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20.sp,
                                                color: mainColor)),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
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
                                                  SearchStudentCubit.get(context).enrollInOffer(data!.id!);
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeStudent()));
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
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage()));
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
