import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/colors.dart';
import 'List_of_institute_notification.dart';
import 'list_of_lesson_notificatoin.dart';
import 'list_of_offer_notification.dart';


class NotificationStudent extends StatelessWidget {
  const NotificationStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ListOfLessonNotification()));
            },
            child: Container(
              height: 70.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: fillColorInTextFormField,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Text("show new lessons",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.sp,
                        color: mainColor)),
              ),),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ListOfInstituteNotification()));

              },
              child: Container(
                height: 70.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: fillColorInTextFormField,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Text("show new institutes",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20.sp,
                          color: mainColor)),
                ),),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ListOfOffersNotification()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: fillColorInTextFormField,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Text("show new offers",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20.sp,
                          color: mainColor)),
                ),),
            ),
          ),
      ],),
    );
  }
}
