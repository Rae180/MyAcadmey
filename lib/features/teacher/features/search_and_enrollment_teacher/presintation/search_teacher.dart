import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../util/colors.dart';
import '../../../../util/myTextField.dart';
import '../data/search_teacher_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';
import 'details_institute_enrollment_teacher.dart';

class SearchTeacher extends StatefulWidget {
  SearchTeacher({Key? key}) : super(key: key);

  @override
  State<SearchTeacher> createState() => _SearchTeacherState();
}

class _SearchTeacherState extends State<SearchTeacher> {
  SearchTeacherModel? searchTeacherModel;

  void _refreshPage() {
    setState(() {
      // You can update any state variables here
    });
  }

  // Widget? Louded;

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchTeacherCubit(),
      child: BlocConsumer<SearchTeacherCubit, SearchTeacherStatus>(
        listener: (context, state) {
if(state is SearchTeacherSuccessStatus)
  {
    searchTeacherModel=state.searchTeacherModel;
    // _refreshPage();
  }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'search ',
                style: TextStyle(color: mainColor),
              ),
              backgroundColor: fillColorInTextFormField,
              iconTheme: IconThemeData(color: mainColor),
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
                        query = searchController.text;
                        // print(query);
                        SearchTeacherCubit.get(context)
                            .searchTeacher(searchController.text);
                      }),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Expanded(
                    child: searchTeacherModel?.searchTeacher == null
                        ? Center(
                            child: Container(),
                          )
                        : ListView.builder(
                            itemCount:
                                searchTeacherModel!.searchTeacher!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsInstituteEnrollmentTeacher(
                                                  searchTeacher:
                                                      searchTeacherModel!
                                                              .searchTeacher![
                                                          index],
                                                )));
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
                                              '${searchTeacherModel!.searchTeacher![index].image1}'),
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
                                                ' ${searchTeacherModel!.searchTeacher![index].academyName}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.sp,
                                                    color: mainColor),
                                              ),
                                              Text(
                                                ' ${searchTeacherModel!.searchTeacher![index].address}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.sp,
                                                    color: mainColor),
                                              ),
                                              RatingBarIndicator(
                                                rating: searchTeacherModel!
                                                    .searchTeacher![index].rate!
                                                    .toDouble(),
                                                itemSize: 25,
                                                //initialRating: 3,
                                                // minRating: 1,
                                                direction: Axis.horizontal,
                                                //allowHalfRating: false,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 0.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
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
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
