import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../util/colors.dart';

Widget ShowRateInstituteAndTeacher({

  required double rate,
}){
  return Container(height:40.h ,width: 142.w,
    decoration: BoxDecoration(
        color: fillColorInTextFormField,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: borderContainer,
        )
    ),
    child:Center(
      child: RatingBarIndicator(
        rating: rate,
        itemSize: 28,
        //initialRating: 3,
       // minRating: 1,
        direction: Axis.horizontal,
        //allowHalfRating: false,
        itemCount:5,
        itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,

        ),
        // onRatingUpdate: (rating) {
        //   print(rating);
        // },
      ),
    ),
  );

}