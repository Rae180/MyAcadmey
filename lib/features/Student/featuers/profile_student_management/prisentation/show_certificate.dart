import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/colors.dart';
import '../data/show_certificate_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class ShowCertificate extends StatelessWidget {
   ShowCertificate({Key? key}) : super(key: key);
ShowCertificateModel ? showCertificateModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>ProfileStudentCubit()..fetchCertificateData(),
      child: BlocConsumer<ProfileStudentCubit,ProfileStudentStatus>(
        listener: (context,state){
          if(state is ShowCertificateStudentSuccessState){
            showCertificateModel=state.showCertificateModel;
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              foregroundColor: mainColor,
              backgroundColor: fillColorInTextFormField,
              title: Text("Certificate",style: TextStyle(
                  fontSize: 24.sp,fontWeight: FontWeight.bold,color: mainColor
              ),),
            ),
            body:showCertificateModel?.certificates==null?Center(child: CircularProgressIndicator(),): ListView.builder(
                itemCount: showCertificateModel?.certificates?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 350.w,
                      height: 280.h,
                      decoration: BoxDecoration(
                          color: fillColorInTextFormField,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: borderContainer,
                          )),

                      child: Column(
                        children: [
                          Container(
                            width: 380.w,
                            height: 200.h,
                            decoration: BoxDecoration(image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("${showCertificateModel!.certificates?[index].image}")),

                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),topRight: Radius.circular(10.r)),

                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(

                                  children: [
                                    Text("${showCertificateModel!.certificates?[index].level}",style: TextStyle(
                                        fontSize: 19.sp,fontWeight: FontWeight.bold,color: mainColor
                                    ),),
                                    SizedBox(height: 15.h,),
                                    Text("${showCertificateModel!.certificates?[index].description}",style: TextStyle(
                                        fontSize: 15.sp,fontWeight: FontWeight.normal,color: mainColor
                                    ),)
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("mark:${showCertificateModel!.certificates?[index].mark}",style: TextStyle(
                                        fontSize: 15.sp,fontWeight: FontWeight.normal,color: mainColor
                                    ),),
                                    SizedBox(height: 15.h,),
                                    Text("${showCertificateModel!.certificates?[index].createdAt}",style: TextStyle(
                                        fontSize: 15.sp,fontWeight: FontWeight.normal,color: mainColor
                                    ),)
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
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
