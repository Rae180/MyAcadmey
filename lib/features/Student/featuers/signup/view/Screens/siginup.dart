import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/Student/featuers/signup/Bloc/bloc/signup_bloc.dart';

import '../../../../../both/Login/view/Screens/loginscreen.dart';
import '../../../../../util/colors.dart';
import '../../../../../util/defaultbutton.dart';
import '../../../../../util/myTextField.dart';
import '../../../../../util/shared_preferences.dart';
import '../../../home_student/prisentation/home_student.dart';

class SignUpScreenStudent extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) =>
          SignupBloc(client: NetworkApiServiceHttp()),
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            // Token is already saved in the bloc, just navigate
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeStudent()),
                (Route<dynamic> route) => false);

            // Show success message
            Flushbar(
                    titleText: Text(
                      "Welcome!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.yellow[600],
                          fontFamily: "ShadowsIntoLightTwo"),
                    ),
                    messageText: Text(
                      "Your account has been created successfully",
                      style: TextStyle(fontSize: 16.0, color: Colors.green),
                    ),
                    duration: Duration(seconds: 3),
                    margin: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8))
                .show(context);
          } else if (state is SignupError) {
            // Show error message
            Flushbar(
                    titleText: Text(
                      "Signup Error",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: mainColor,
                          fontFamily: "ShadowsIntoLightTwo"),
                    ),
                    messageText: Text(
                      state.message,
                      style: TextStyle(fontSize: 16.0, color: mainColor),
                    ),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                    margin: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8))
                .show(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15.w, top: 15.h, right: 15.w, bottom: 15.h),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                              width: 307.w,
                              height: 247.h,
                              child: Image.asset('assets/images/signup1.jpg')),
                        ),
                        Text(
                          'Welcome Student',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 30.sp),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Expanded(
                              child: myTextField(
                                width: 166.w,
                                height: 46.h,
                                controller: firstNameController,
                                validatorValue: 'First name is required',
                                labelText: 'First name',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: myTextField(
                                width: 166.w,
                                height: 46.h,
                                controller: lastNameController,
                                validatorValue: 'Last name is required',
                                labelText: 'Last name',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        myTextField(
                          width: 354.w,
                          height: 46.h,
                          controller: emailController,
                          prefixIcon: Icon(Icons.email),
                          validatorValue: 'Email address is required',
                          labelText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20.h),
                        myTextField(
                          width: 354.w,
                          height: 46.h,
                          controller: phoneController,
                          prefixIcon: Icon(Icons.phone),
                          validatorValue: 'Phone number is required',
                          labelText: 'Phone',
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 20.h),
                        myTextField(
                          width: 354.w,
                          height: 46.h,
                          controller: passwordController,
                          validatorValue: 'Password is required',
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          obscureText: true,
                        ),
                        SizedBox(height: 20.h),
                        myTextField(
                          width: 354.w,
                          height: 46.h,
                          controller: confirmPasswordController,
                          validatorValue: 'Please confirm your password',
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Confirm Password',
                          obscureText: true,
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: state is SignUpLoading
                              ? CircularProgressIndicator()
                              : defaultbutton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      // Validate passwords match
                                      if (passwordController.text !=
                                          confirmPasswordController.text) {
                                        Flushbar(
                                                titleText: Text(
                                                  "Password Error",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                      color: mainColor,
                                                      fontFamily:
                                                          "ShadowsIntoLightTwo"),
                                                ),
                                                messageText: Text(
                                                  "Passwords do not match",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: mainColor),
                                                ),
                                                duration: Duration(seconds: 3),
                                                backgroundColor: Colors.red,
                                                margin: EdgeInsets.all(8),
                                                borderRadius:
                                                    BorderRadius.circular(8))
                                            .show(context);
                                        return;
                                      }

                                      // Dispatch signup event
                                      BlocProvider.of<SignupBloc>(context).add(
                                          SigningupEvent(
                                              firstName:
                                                  firstNameController.text,
                                              lastName: lastNameController.text,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              password:
                                                  passwordController.text));
                                    }
                                  },
                                  text: 'Sign up',
                                  width: 128.w,
                                  height: 41.h,
                                  fontSizeText: 18.sp,
                                  textColor: Colors.greenAccent,
                                  backround: Colors.white),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You have an account ?',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.blueAccent),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Login()));
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                      color: Colors.black),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
