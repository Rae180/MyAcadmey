import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/colors.dart';
import '../../../../util/details_container.dart';
import '../../../../util/summary.dart';
import '../../../../teacher/features/home/prisentation/widget/rate_and_like_and_dislike.dart';

class ProfileTeacherInOffersSearch extends StatelessWidget {
  const ProfileTeacherInOffersSearch({Key? key}) : super(key: key);
  final String description =
      "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line";

  @override
  Widget build(BuildContext context) {
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
                backgroundImage: AssetImage('assets/images/p.png'),
                radius: 110.r,
              ),
              SizedBox(
                height: 15.h,
              ),

              ShowRateInstituteAndTeacher(rate: 3),

              detailsContainer(text: 'Abd fy'),
              detailsContainer(text: '0936251498'),
              detailsContainer(text: 'abd@gmail.com'),
              SizedBox(
                height: 15.h,
              ),

              SizedBox(
                height: 15.h,
              ),
              ShowMoreShowLess(text: description),
              SizedBox(
                height: 15.h,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
