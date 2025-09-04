import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../util/colors.dart';
import '../../../../util/show_message_on_screen.dart';
import '../data/show_student_institute_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';
import 'details_institute_student.dart';

class ListOfInstituteStudent extends StatelessWidget {
  ListOfInstituteStudent({Key? key}) : super(key: key);
  ShowStudentInstituteModel? showStudentInstituteModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          InstituteStudentCubit()..getListStudentInstitute(),
      child: BlocConsumer<InstituteStudentCubit, InstituteStudentStatus>(
        listener: (context, state) {
          if (state is InstituteStudentSuccessState) {
            showStudentInstituteModel = state.showStudentInstituteModel;

            print(showStudentInstituteModel?.academyInfo?.length);
          } else if (state is InstituteStudentErrorState) {
            showMessageOnScreen(
                context: context,
                titleText: "Not Found",
                messageText: "error conection");
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: showStudentInstituteModel?.academyInfo == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: showStudentInstituteModel?.academyInfo?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsInstituteStudent(
                                      showStudentInstituteModel:
                                          showStudentInstituteModel!
                                              .academyInfo?[index].id,
                                    )));
                            // navigateTo(context, CourseDetails());
                          },
                          child: Container(
                            width: 332.w,
                            height: 109.h,
                            decoration: BoxDecoration(
                                color: fillColorInTextFormField,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: borderContainer,
                                )),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${showStudentInstituteModel!.academyInfo?[index].image1}'),
                                  radius: 45.r,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${showStudentInstituteModel!.academyInfo?[index].academyName}',
                                        maxLines: 2,
                                        style: TextStyle(

                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                            color: mainColor),
                                      ),
                                      Text(
                                        ' ${showStudentInstituteModel!.academyInfo?[index].address}',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                            color: mainColor),
                                      ),
                                      RatingBarIndicator(
                                        rating:showStudentInstituteModel!.academyInfo?[index].rateId?.toDouble() ?? 0.0 ,
                                        itemSize: 25,
                                        // initialRating: 3,
                                        // minRating: 1,
                                        direction: Axis.horizontal,
                                        //allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 0.0),
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
