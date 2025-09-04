import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../util/colors.dart';
import '../../search_and_enrollment_student/prisentation/details_offers_enrollment.dart';
import '../data/courses_and_offers_model.dart';
import '../data/show_ten_offers_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';
import 'details_courses_student.dart';

class ListOfCoursesStudent extends StatelessWidget {
   ListOfCoursesStudent({Key? key}) : super(key: key);
   ShowCoursesAndOffersModel? showCoursesAndOffersModel;
   ShowTenOffersModel ?showTenOffersModel;
   final List<List<String>> productDetails = [

     ['assets/images/p.jpg','C++', 'ALTC institute ', '55\$','15/3/2023'],
     ['assets/images/p.jpg','C++', 'ALTC institute ', '55\$','15/3/2023'],
     ['assets/images/p.jpg','C++', 'ALTC institute ', '55\$','15/3/2023'],
     ['assets/images/p.jpg','C++', 'ALTC institute ', '55\$','15/3/2023'],
     ['assets/images/p.jpg','C++', 'ALTC institute ', '55\$','15/3/2023'],



     // Add more product details here
   ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>CourseStudentCubit()..getListCoursesAndOffers()..getTenOffer(),
      child: BlocConsumer<CourseStudentCubit,CourseStudentStatus>(
        listener: (context,state){
          if(state is CourseStudentSuccessState)
            showCoursesAndOffersModel=state.showCoursesAndOffersModel;
          if(state is TenOffersSuccessState)
            showTenOffersModel=state.showTenOffersModel;
        },
        builder: (context,state){
          return  Scaffold(
            body: Column(
              children: [
                SizedBox(height: 15.h,),
                showTenOffersModel==null?Center(child: CircularProgressIndicator(),): CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    aspectRatio: 16 / 9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      // Handle page change
                    },
                  ),
                  items: showTenOffersModel?.offers?.map((details) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: (){
                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsOffersEnrollment(data: showTenOffersModel.,)));
                          }
                          ,

                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 190.h,
                            decoration: BoxDecoration(
                                color: fillColorInTextFormField,
                                borderRadius: BorderRadius.circular(20.r)

                            ),
                             margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              children: [
                                Container(
                                  width:140.w,
                                  height: 170.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r)
                                      ,image:details.courseImage==null ? DecorationImage(image: AssetImage("assets/images/p.png"),fit: BoxFit.cover):DecorationImage(image: NetworkImage("${details.courseImage}"),fit: BoxFit.cover)
                                  ),
                                  // child: Image(image: AssetImage(details[0]))
                                ),
                                SizedBox(width: 15.w,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(details.name.toString(), style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold,color: mainColor)),
                                  //  Text(details.hours!, style:TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,color: mainColor)),
                                    Text("${details.price!}", style:TextStyle(fontSize: 10.sp,fontWeight: FontWeight.normal,color: mainColor)),
                                    Text(details.startDate!, style:TextStyle(fontSize: 10.sp,fontWeight: FontWeight.normal,color: mainColor)),

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
                    child:showCoursesAndOffersModel?.courses==null?Center(child: CircularProgressIndicator(),): ListView.builder(
                        itemCount:showCoursesAndOffersModel?.courses?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsCoursesStudent(courses:showCoursesAndOffersModel!.courses![index])));
                                // navigateTo(context, CourseDetails());
                              },
                              child: Container(
                                width: 380.w,
                                height: 107.h,
                                decoration: BoxDecoration(
                                    color: fillColorInTextFormField,
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: borderContainer,
                                    )),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 107.h,
                                      width: 107.w,
                                      decoration: BoxDecoration(
                                        image:DecorationImage(fit: BoxFit.cover,image:  AssetImage('assets/images/p.jpg'), ),
                                        color: fillColorInTextFormField,
                                        borderRadius: BorderRadius.circular(10.r),
                                        // border: Border.all(
                                        //   color: borderContainer,
                                        // )
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${showCoursesAndOffersModel!.courses?[index].name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp,color: mainColor),),

                                          //////acadmy name here
                                          Text('${showCoursesAndOffersModel!.courses?[index].level!}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,color: mainColor),),
                                          Text("${showCoursesAndOffersModel!.courses?[index].startDate}",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16.sp,color: mainColor),)
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
                ),
              ],
            ),
          );
        },
      )
    );
  }
}
