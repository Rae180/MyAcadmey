import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/features/util/details_container.dart';

import '../../../../util/colors.dart';
import '../../../../util/summary.dart';
import '../../home/prisentation/widget/checkboxLanguge.dart';
import '../../home/prisentation/widget/rate_and_like_and_dislike.dart';
import '../data/details_institute_teacher_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class InstituteDetailsTeacher extends StatelessWidget {
   InstituteDetailsTeacher({Key? key,required this.id}) : super(key: key);
  final String description =
      "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line";
   DetailsInstituteTeacherModel ?detailsInstituteTeacherModel;
 final  int? id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>InstituteTeacherCubit()..getListTeacherInstituteDetails(id!),
      child:  BlocConsumer<InstituteTeacherCubit,InstituteTeacherStatus>(
        listener: (context,state){
          if(state is InstituteDetailsTeacherSuccessState)
            detailsInstituteTeacherModel =state.detailsInstituteTeacherModel;

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'institute details',
                style: TextStyle(color: mainColor),
              ),
              backgroundColor: fillColorInTextFormField,
              iconTheme: IconThemeData(color: mainColor),
            ),
            body:detailsInstituteTeacherModel?.data==null?Center(child: CircularProgressIndicator(),): SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage('${detailsInstituteTeacherModel!.data!.image1}'),
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
                        ShowRateInstituteAndTeacher(rate: detailsInstituteTeacherModel!.data!.rate!.toDouble()),
                      ],
                    ),

                    detailsContainer(text: '${detailsInstituteTeacherModel!.data!.name}'),
                    detailsContainer(text: '${detailsInstituteTeacherModel!.data!.location}'),
                    SizedBox(
                      height: 15.h,
                    ),
                    LanguageInDetailsInstitute(
                        english: detailsInstituteTeacherModel!.data!.languages!.contains("English"),
                        french: detailsInstituteTeacherModel!.data!.languages!.contains("French"),
                        spanish: detailsInstituteTeacherModel!.data!.languages!.contains("Spanish"),
                        germany: detailsInstituteTeacherModel!.data!.languages!.contains("Germany")
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ShowMoreShowLess(text: detailsInstituteTeacherModel!.data!.description),
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
