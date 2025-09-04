import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../util/colors.dart';
import '../../../util/details_container.dart';

Widget ShowDaysAndTime(
{
  required String day,
  required  bool chickBoxValue,
  required  String startTime,
  required String endTime,
}
    ) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        day,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.sp),
      ),
      Checkbox(value: chickBoxValue,
          checkColor: mainColor,
          fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                // Custom color when button is pressed
                return Colors.red;
              }
              // Default color
              return fillColorInTextFormField;
            },
          ),
          onChanged: null),
      detailsContainer(text: startTime, width: 95.w,sizedbox: 5),
      SizedBox(
        width: 5.w,
      ),
      detailsContainer(text: endTime, width: 95.w,sizedbox: 5),
    ],
  );
}
