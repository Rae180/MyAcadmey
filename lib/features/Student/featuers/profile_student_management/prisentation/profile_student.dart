import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/features/Student/featuers/profile_student_management/prisentation/show_certificate.dart';

import '../../../../util/colors.dart';
import '../../../../util/details_container.dart';
import '../data/profile_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';
import 'edit_profile_student.dart';


class ProfileStudent extends StatelessWidget {

   ProfileStudent({Key? key,  }) : super(key: key);
 ProfileStudentModel ?profileStudentModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (BuildContext context)=>ProfileStudentCubit()..getProfileData(),
      child: BlocConsumer<ProfileStudentCubit,ProfileStudentStatus>(
        listener: (context,state){
      if(state is ProfileStudentSuccessState)
      {
        profileStudentModel=state.profileStudentModel;
        print(profileStudentModel?.profile);
       print ("success");
      }else print("thare are error");
        },
        builder: (context ,state){

          return  Scaffold(
            body:profileStudentModel==null?Center(child: CircularProgressIndicator(),) :Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Row(

                          children: [

                            IconButton(
                                color: fillColorInTextFormField,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileStudent(profileStudentModel: profileStudentModel,)));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                color: fillColorInTextFormField,
                                onPressed: () {},
                                icon: Icon(Icons.logout))
                          ],
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage("${profileStudentModel!.profile?.student!.image}"),
                    radius: 110.r,
                  ),
                  detailsContainer(text: "${profileStudentModel!.profile!.name}"),
                  detailsContainer(text: "${profileStudentModel!.profile!.phoneNumber}"),
                  detailsContainer(text: "${profileStudentModel!.profile!.email}"),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ShowCertificate()));
              },
              child: Icon(Icons.add_chart_rounded),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
