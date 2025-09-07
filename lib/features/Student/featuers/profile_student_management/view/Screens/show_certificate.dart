import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/Student/featuers/profile_student_management/Bloc/bloc/profile_bloc.dart';
import 'package:start/features/Student/featuers/profile_student_management/Models/show_certificate_model.dart';
import 'package:start/features/util/colors.dart';

class ShowCertificate extends StatelessWidget {
  const ShowCertificate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => 
        ProfileBloc(client: NetworkApiServiceHttp())..add(GetCertificatesEvent()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // Handle state changes if needed
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: mainColor,
              backgroundColor: fillColorInTextFormField,
              title: Text(
                "Certificates",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: mainColor
                ),
              ),
            ),
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(ProfileState state) {
    if (state is ProfileLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is ShowCertficatedSuccess) {
      return _buildCertificatesList(state.certificates);
    } else if (state is ProfileError) {
      return Center(
        child: Text(
          "Error loading certificates: ${state.message}",
          style: TextStyle(fontSize: 16.sp, color: Colors.red),
        ),
      );
    } else {
      return Center(
        child: Text(
          "No certificates found",
          style: TextStyle(fontSize: 16.sp, color: mainColor),
        ),
      );
    }
  }

  Widget _buildCertificatesList(CertificatedModel certificates) {
    if (certificates.data == null || certificates.data!.isEmpty) {
      return Center(
        child: Text(
          "No certificates available",
          style: TextStyle(fontSize: 16.sp, color: mainColor),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(8.w),
      itemCount: certificates.data!.length,
      itemBuilder: (BuildContext context, int index) {
        final certificate = certificates.data![index];
        return _buildCertificateCard(certificate);
      },
    );
  }

  Widget _buildCertificateCard(Data certificate) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Container(
        width: 350.w,
        height: 280.h,
        decoration: BoxDecoration(
          color: fillColorInTextFormField,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: borderContainer),
        ),
        child: Column(
          children: [
            // Certificate Image
            Container(
              width: 380.w,
              height: 200.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(certificate.image ?? ''),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
            ),
            // Certificate Details
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        certificate.courseLevel ?? 'No Course Level',
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        certificate.academyName ?? 'No Academy Name',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Mark: ${certificate.mark ?? 'N/A'}",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                          color: mainColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        certificate.receiveDate ?? 'No Date',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}