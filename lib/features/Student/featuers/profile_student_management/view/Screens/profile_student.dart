import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/Student/featuers/profile_student_management/Bloc/bloc/profile_bloc.dart';
import 'package:start/features/Student/featuers/profile_student_management/view/Screens/show_certificate.dart';

import '../../../../../util/colors.dart';
import '../../../../../util/details_container.dart';
import '../../Models/profile_model.dart';
import 'edit_profile_student.dart';

class ProfileStudent extends StatelessWidget {
  const ProfileStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ProfileBloc(client: NetworkApiServiceHttp())
            ..add(GetProfileStuEvent()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            // Handle error state if needed
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is GetProfileStuSuccess) {
            final profileStudentModel = state.profileStu;

            return Scaffold(
              body: Center(
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfileStudent(
                                        profileStudentModel:
                                            profileStudentModel,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                color: fillColorInTextFormField,
                                onPressed: () {
                                  // Handle logout functionality
                                },
                                icon: const Icon(Icons.logout),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "${profileStudentModel.profile?.student!.image}"),
                      radius: 110.r,
                    ),
                    detailsContainer(
                        text: "${profileStudentModel.profile!.name}"),
                    detailsContainer(
                        text: "${profileStudentModel.profile!.phoneNumber}"),
                    detailsContainer(
                        text: "${profileStudentModel.profile!.email}"),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  ShowCertificate()));
                },
                child: const Icon(Icons.add_chart_rounded),
                backgroundColor: Colors.white,
              ),
            );
          } else if (state is ProfileError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(GetProfileStuEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
