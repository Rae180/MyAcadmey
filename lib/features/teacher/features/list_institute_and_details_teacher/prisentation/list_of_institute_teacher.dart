import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../util/colors.dart';
import '../data/all_institute_teacher_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';
import 'institute_detailsTeacher.dart';

class ListOfInstituteTeacher extends StatelessWidget {
   ListOfInstituteTeacher({Key? key}) : super(key: key);
AllInstituteTeacherModel ?allInstituteTeacherModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>InstituteTeacherCubit()..getListTeacherInstitute(),
    child:  BlocConsumer<InstituteTeacherCubit,InstituteTeacherStatus>(
      listener: (context,state){
        if(state is InstituteTeacherSuccessState)
          allInstituteTeacherModel=state.allInstituteTeacherModel;
      },
      builder: (context,state){
        return Scaffold(
          body: allInstituteTeacherModel?.data==null?Center(child: CircularProgressIndicator(),): ListView.builder(
              itemCount: allInstituteTeacherModel?.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InstituteDetailsTeacher(id: allInstituteTeacherModel!.data![index].id,)));
                      // navigateTo(context, CourseDetails());
                    },
                    child: Container(
                      width: 332.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                          color: fillColorInTextFormField,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: borderContainer,
                          )),
                      child: Row(
                        children: [
                          SizedBox(width: 10.w,),
                          CircleAvatar(
                            backgroundImage: NetworkImage('${allInstituteTeacherModel!.data![index].photo}'),
                            radius: 45.r,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' ${allInstituteTeacherModel!.data![index].name} ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp,color: mainColor),),
                                Text(' ${allInstituteTeacherModel!.data![index].location}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: mainColor),),
                                RatingBarIndicator(
                                  rating: allInstituteTeacherModel!.data![index].rate!.toDouble(),
                                  itemSize: 25,
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
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
      ),
    );
  }
}
