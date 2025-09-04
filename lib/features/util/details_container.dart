import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

Widget detailsContainer({
  required String text,
  double width=290,
  double height=50,
  double sizedbox=20,
}){
  return    Column(
    children: [
      SizedBox(height: sizedbox.h,),
      Container(height:height.h ,width:width.w,
        decoration: BoxDecoration(
            color: fillColorInTextFormField,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: borderContainer,
            )
        ),
        child:Center(child: Text(text,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)),

      ),
    ],
  );

}