import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/colors.dart';
import '../../../../util/myTextField.dart';
import '../../../../util/show_message_on_screen.dart';
import '../data/search_institute_student_mode.dart';
import '../data/search_offer_student_model.dart';
import '../widget/toggel_bottun_for_search.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';
import 'details_institute_enrollment.dart';
import 'details_offers_enrollment.dart';

class SearchStudent extends StatelessWidget {
  SearchStudent({Key? key}) : super(key: key);
SearchOfferStudentModel ?searchOfferStudentModel;
SearchInstituteStudentModel ? searchInstituteStudentModel;
  @override
  Widget build(BuildContext context) {
    var searchController = new TextEditingController();
    return BlocProvider<SearchStudentCubit>(
      create: (BuildContext context) => SearchStudentCubit(),
      child: BlocConsumer<SearchStudentCubit, SearchStudentStatus>(
        listener: (context, state) {
          if(state is SearchStudentInstituteSuccessState)
            searchInstituteStudentModel=state.searchInstituteStudentModel;
         else if(state is SearchStudentOfferSuccessState)
            searchOfferStudentModel=state.searchOfferStudentModel;
         else
           showMessageOnScreen(context: context, titleText: "Error", messageText: "thr are an error");
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: fillColorInTextFormField,
              foregroundColor: mainColor,
              title: Text(
                "Search",
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: mainColor),
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  myTextField(
                      controller: searchController,
                      labelText: "search",
                      prefixIcon: Icon(
                        Icons.search,
                        color: mainColor,
                      ),
                      onChanged: (String query) {
                        if(SearchStudentCubit.get(context).cc==1)
                          {
                            SearchStudentCubit.get(context).searchForInstitute(query);
                          }else if(SearchStudentCubit.get(context).cc==2){
                          SearchStudentCubit.get(context).searchForOffer(query);
                        }
                      }),
                  SizedBox(
                    height: 15.h,
                  ),
                  ToggleButton(
                    width: 320.w,
                    height: 40.h,
                    toggleBackgroundColor: fillColorInTextFormField,
                    toggleBorderColor: mainColor,
                    toggleColor: mainColor,
                    activeTextColor: Colors.white,
                    inactiveTextColor: mainColor,
                    leftDescription: 'Institute',
                    rightDescription: 'Offers',
                    onLeftToggleActive: () {
                      BlocProvider.of<SearchStudentCubit>(context)
                          .changValueOfSearch1(2);
                      print(BlocProvider.of<SearchStudentCubit>(context).cc);
                    },
                    onRightToggleActive: () {
                      BlocProvider.of<SearchStudentCubit>(context)
                          .changValueOfSearch1(1);
                      print(BlocProvider.of<SearchStudentCubit>(context).cc);
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  BlocProvider.of<SearchStudentCubit>(context).cc == 1
                      ? Expanded(
                          child:searchInstituteStudentModel?.data==null?Center(child: CircularProgressIndicator(),): ListView.builder(
                              itemCount: searchInstituteStudentModel!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      print("institute");
                                      print(BlocProvider.of<SearchStudentCubit>(
                                              context)
                                          .cc);
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsInstituteEnrollment(dat: searchInstituteStudentModel!.data![index],)));

                                    },
                                    child: Container(
                                      width: 332.w,
                                      height: 109.h,
                                      decoration: BoxDecoration(
                                          color: fillColorInTextFormField,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
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
                                                '${searchInstituteStudentModel!.data![index].image}'),
                                            radius: 45.r,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ' ${searchInstituteStudentModel!.data![index].name}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.sp,
                                                      color: mainColor),
                                                ),
                                                Text(
                                                  ' ${searchInstituteStudentModel!.data![index].location}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.sp,
                                                      color: mainColor),
                                                ),
                                                // RatingBarIndicator(
                                                //   rating: searchInstituteStudentModel!.data![index].,
                                                //   itemSize: 25,
                                                //   //initialRating: 3,
                                                //   // minRating: 1,
                                                //   direction: Axis.horizontal,
                                                //   //allowHalfRating: false,
                                                //   itemCount: 5,
                                                //   itemPadding:
                                                //       EdgeInsets.symmetric(
                                                //           horizontal: 0.0),
                                                //   itemBuilder: (context, _) =>
                                                //       Icon(
                                                //     Icons.star,
                                                //     color: Colors.amber,
                                                //   ),
                                                //   // onRatingUpdate: (rating) {
                                                //   //   print(rating);
                                                //   // },
                                                // ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Expanded(
                          child:searchOfferStudentModel?.data==null?Center(child: CircularProgressIndicator(),): ListView.builder(
                              itemCount: searchOfferStudentModel!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      print("offers");
                                      print(BlocProvider.of<SearchStudentCubit>(
                                              context)
                                          .cc);
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsOffersEnrollment(data:searchOfferStudentModel!.data![index]!)));

                                    },
                                    child: Container(
                                      width: 332.w,
                                      height: 109.h,
                                      decoration: BoxDecoration(
                                          color: fillColorInTextFormField,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(
                                            color: borderContainer,
                                          )),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 109.w,
                                            height: 109.h,
                                            decoration: BoxDecoration(
                                                color: fillColorInTextFormField,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      '${searchOfferStudentModel!.data![index].image}',
                                                    )),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                border: Border.all()),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ' ${searchOfferStudentModel!.data![index].name}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.sp,
                                                      color: mainColor),
                                                ),
                                                Text(
                                                  ' ${searchOfferStudentModel!.data![index].academy!.name}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.sp,
                                                      color: mainColor),
                                                ),
                                                Text(
                                                  ' ${searchOfferStudentModel!.data![index].price}\$',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.sp,
                                                      color: mainColor),
                                                ),
                                                Text(
                                                  ' ${searchOfferStudentModel!.data![index].startDate}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.sp,
                                                      color: mainColor),
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
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
