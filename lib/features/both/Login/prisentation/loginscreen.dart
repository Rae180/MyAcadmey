import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/features/Student/featuers/home_student/prisentation/home_student.dart';
import 'package:start/features/teacher/features/home/prisentation/home_teacher.dart';

// import '../../../Student/featuers/home_student/prisentation/home_student.dart';
// import '../../../teacher/features/home/prisentation/home_teacher.dart';
import '../../../util/colors.dart';
import '../../../util/defaultbutton.dart';
import '../../../util/myTextField.dart';
import '../../../util/shared_preferences.dart';
import '../../../util/showToast.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class Login extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emilController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => LoginScreenCubit(),
      child: BlocConsumer<LoginScreenCubit, LoginScreenStatus>(
        listener: (context, state) {
          if (state is LoginScreenSuccessState) {
            SharedPref.saveData(key: 'token', value: state.loginModel.token)
                .then((value) {
              print(SharedPref.getData(key: 'token'));
            });
            SharedPref.saveData(key: 'user', value: state.loginModel.user?.role)
                .then((value) {
              print(SharedPref.getData(key: 'token'));
            });
            if (state.loginModel.user?.role == 'teacher') {
              Flushbar(
                titleText: Text("hello Teacher", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily:"ShadowsIntoLightTwo"),),
                messageText: Text("welcome in our application", style: TextStyle(fontSize: 16.0, color: Colors.green),),
                duration:  Duration(seconds: 3),
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8)
              ).show(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeTeacher()));
            } else if (state.loginModel.user?.role == 'student') {
              Flushbar(
                titleText: Text("Hello Student", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily:"ShadowsIntoLightTwo"),),
                messageText: Text("welcome in our application", style: TextStyle(fontSize: 16.0, color: Colors.green),),
                duration:  Duration(seconds: 3),
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8)
              ).show(context);
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => HomeStudent()));
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeStudent()), (Route<dynamic> route) => false);            }else{
              Flushbar(
                titleText: Text("welcome in our application", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily:"ShadowsIntoLightTwo"),),
                messageText: Text("if you admin or super admin you can login from web application", style: TextStyle(fontSize: 16.0, color: Colors.green),),
                duration:  Duration(seconds: 3),
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8)

              ).show(context);
            }
          }
          if(state is LoginScreenErrorState){
            Flushbar(
                titleText: Text("error login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: mainColor, fontFamily:"ShadowsIntoLightTwo"),),
                messageText: Text("error in your email or password", style: TextStyle(fontSize: 16.0, color: mainColor),),
                duration:  Duration(seconds: 3),
                backgroundColor: Colors.red,
                margin: EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8)

            ).show(context);
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
                      SizedBox(
                        height: 100.h,
                      ),
                      Center(
                          child: SizedBox(
                              width: 384.w,
                              height: 309.h,
                              child: Image.asset('assets/images/login11.jpg'))),
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
                      SizedBox(
                        height: 20.h,
                      ),
                      myTextField(
                        controller: emilController,
                        prefixIcon: const Icon(Icons.email),
                        validatorValue: 'emil address must not be empty',
                        labelText: 'Email',
                        // hintText: 'Enter Your Emil Address',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      myTextField(
                          controller: passwordController,
                          validatorValue: 'password must not be empty',
                          prefixIcon: const Icon(Icons.lock),
                          labelText: 'password',
                          obscureText:
                              LoginScreenCubit.get(context).isPasswordShow,
                          // hintText: 'Enter Your Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                LoginScreenCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              icon: Icon(LoginScreenCubit.get(context).suffix),
                              ),
                          onFieldSubmitted: (value) {
                            // if(formKey.currentState!.validate())
                            // {
                            //   LoginCubit.get(context).userLoginIn(
                            //       emilController.text,
                            //       passwordController.text);
                            // }
                          }),
                      SizedBox(
                        height: 26.h,
                      ),

                        LoginScreenLoadingState!=true?defaultbutton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              LoginScreenCubit.get(context).userLogin(
                                  emilController.text, passwordController.text);
                              closeKeyboard(context);
                            }
                          },
                          text: 'Login',
                          textColor: fillColorInTextFormField,
                          width: 128.w,
                          height: 41.h,
                          fontSizeText: 18.sp,
                          backround: mainColor):CircularProgressIndicator(),
                      SizedBox(
                        height: 20.h,
                      ),
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
                      SizedBox(
                        height: 10.h,
                      ),
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
                      SizedBox(
                        height: 200.h,
                      ),
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
