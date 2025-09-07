import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/core/api_service/base_Api_service.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:start/features/Student/featuers/list_of_courses_and_details_student/Bloc/bloc/courses_bloc.dart';
import 'package:start/features/util/colors.dart';


// Screen
class ListOfCoursesStudent extends StatelessWidget {
  const ListOfCoursesStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CoursesBloc(client: NetworkApiServiceHttp())..add(GetCoursesEvent()),
      child: BlocConsumer<CoursesBloc, CoursesState>(
        listener: (context, state) {
          // Handle state changes if needed
        },
        builder: (context, state) {
          if (state is CoursesLoading) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is CoursesError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          } else if (state is GetCoursesSuccess) {
            final courses = state.courses.data;
            final offers = courses?.where((course) => course.isOffer == true).toList() ?? [];
            
            return Scaffold(
              body: Column(
                children: [
                  SizedBox(height: 15.h),
                  // Carousel for offers
                  offers.isEmpty
                      ? SizedBox.shrink()
                      : CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.8,
                            aspectRatio: 16 / 9,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: offers.take(10).map((offer) {
                            return Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => DetailsOffersEnrollment(data: offer),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 190.h,
                                    decoration: BoxDecoration(
                                      color: fillColorInTextFormField,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 140.w,
                                          height: 170.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.r),
                                            image: DecorationImage(
                                              image: offer.courseImage != null
                                                  ? NetworkImage(offer.courseImage!)
                                                  : AssetImage("assets/images/p.png") as ImageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15.w),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              offer.name ?? 'No Name',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: mainColor,
                                              ),
                                            ),
                                            Text(
                                              "\$${offer.price?.toStringAsFixed(2) ?? '0.00'}",
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.normal,
                                                color: mainColor,
                                              ),
                                            ),
                                            Text(
                                              offer.startTime ?? 'No Date',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.normal,
                                                color: mainColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: courses?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final course = courses![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => DetailsCoursesStudent(courses: course),
                                //   ),
                                // );
                              },
                              child: Container(
                                width: 380.w,
                                height: 107.h,
                                decoration: BoxDecoration(
                                  color: fillColorInTextFormField,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: borderContainer),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 107.h,
                                      width: 107.w,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: course.courseImage != null
                                              ? NetworkImage(course.courseImage!)
                                              : AssetImage('assets/images/p.jpg') as ImageProvider,
                                        ),
                                        color: fillColorInTextFormField,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            course.name ?? 'No Name',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp,
                                              color: mainColor,
                                            ),
                                          ),
                                          Text(
                                            course.academy?.name ?? 'No Academy',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                              color: mainColor,
                                            ),
                                          ),
                                          Text(
                                            course.startTime ?? 'No Date',
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.sp,
                                              color: mainColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              body: Center(child: Text('Unknown state')),
            );
          }
        },
      ),
    );
  }
}