import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/features/util/colors.dart';

import 'details_container.dart';

Widget timeOfWor({
  required String day,
  required bool value,
  required String startOf,
  required String endOf,
}){
  return Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Text('Saturday',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 24.sp,color: mainColor),),
  Checkbox(value: true, onChanged: (value){}),
  detailsContainer(text: '9:45',width: 95.w),
  SizedBox(width:15.w ,),
  detailsContainer(text: '9:45',width: 95.w)
],);
}