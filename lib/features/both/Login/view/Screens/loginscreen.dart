import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/Student/featuers/home_student/prisentation/home_student.dart';
import 'package:start/features/both/Login/bloc/login_bloc.dart';
import 'package:start/features/teacher/features/home/prisentation/home_teacher.dart';
import 'package:start/features/both/Login/Models/login_model.dart';
import 'package:start/features/util/colors.dart';
import 'package:start/features/util/defaultbutton.dart';
import 'package:start/features/util/myTextField.dart';
import 'package:start/features/util/shared_preferences.dart';

class Login extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emilController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) =>
          LoginBloc(client: NetworkApiServiceHttp()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Save token and role to shared preferences
            SharedPref.saveData(key: 'token', value: state.loginModel.token);
            SharedPref.saveData(key: 'role', value: state.loginModel.role);

            // Show appropriate message based on role
            if (state.loginModel.role == 'Teacher') {
              Flushbar(
                      titleText: Text(
                        "Hello Teacher",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.yellow[600],
                            fontFamily: "ShadowsIntoLightTwo"),
                      ),
                      messageText: Text(
                        "Welcome to our application",
                        style: TextStyle(fontSize: 16.0, color: Colors.green),
                      ),
                      duration: Duration(seconds: 3),
                      margin: EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(8))
                  .show(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeTeacher()));
            } else if (state.loginModel.role == 'Student') {
              Flushbar(
                      titleText: Text(
                        "Hello Student",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.yellow[600],
                            fontFamily: "ShadowsIntoLightTwo"),
                      ),
                      messageText: Text(
                        "Welcome to our application",
                        style: TextStyle(fontSize: 16.0, color: Colors.green),
                      ),
                      duration: Duration(seconds: 3),
                      margin: EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(8))
                  .show(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeStudent()),
                  (Route<dynamic> route) => false);
            } else {
              Flushbar(
                      titleText: Text(
                        "Welcome to our application",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.yellow[600],
                            fontFamily: "ShadowsIntoLightTwo"),
                      ),
                      messageText: Text(
                        "If you are an admin or super admin, please use the web application",
                        style: TextStyle(fontSize: 16.0, color: Colors.green),
                      ),
                      duration: Duration(seconds: 3),
                      margin: EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(8))
                  .show(context);
            }
          } else if (state is LoginError) {
            Flushbar(
                    titleText: Text(
                      "Login Error",
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100.h),
                      Center(
                        child: SizedBox(
                            width: 384.w,
                            height: 309.h,
                            child: Image.asset('assets/images/login11.jpg')),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: const Text(
                              ' Login ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: mainColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      myTextField(
                        controller: emilController,
                        prefixIcon: const Icon(Icons.email),
                        validatorValue: 'Email address must not be empty',
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 35.h),
                      myTextField(
                        controller: passwordController,
                        validatorValue: 'Password must not be empty',
                        prefixIcon: const Icon(Icons.lock),
                        labelText: 'Password',
                        obscureText: true,
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginingEvent(
                                    email: emilController.text,
                                    paassword: passwordController.text));
                          }
                        },
                      ),
                      SizedBox(height: 26.h),
                      state is LoginLoading
                          ? CircularProgressIndicator()
                          : defaultbutton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      LoginingEvent(
                                          email: emilController.text,
                                          paassword: passwordController.text));
                                }
                              },
                              text: 'Login',
                              textColor: fillColorInTextFormField,
                              width: 128.w,
                              height: 41.h,
                              fontSizeText: 18.sp,
                              backround: mainColor),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(thickness: 1, color: mainColor)),
                          Padding(
                            padding: EdgeInsets.only(left: 15.w, right: 15.w),
                            child: Text(
                              'Or',
                              style:
                                  TextStyle(fontSize: 14.sp, color: mainColor),
                            ),
                          ),
                          Expanded(
                              child: Divider(thickness: 1, color: mainColor)),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          defaultbutton(
                              function: () {},
                              text: 'Google',
                              width: 128.w,
                              height: 41.h,
                              fontSizeText: 18.sp,
                              textColor: mainColor,
                              backround: fillColorInTextFormField),
                          defaultbutton(
                              function: () {},
                              text: 'Facebook',
                              width: 128.w,
                              height: 41.h,
                              fontSizeText: 18.sp,
                              textColor: mainColor,
                              backround: fillColorInTextFormField),
                        ],
                      ),
                      SizedBox(height: 200.h),
                    ],
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
