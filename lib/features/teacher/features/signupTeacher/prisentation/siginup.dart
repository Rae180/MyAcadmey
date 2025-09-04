import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../both/Login/view/Screens/loginscreen.dart';
import '../../../../util/colors.dart';
import '../../../../util/defaultbutton.dart';
import '../../../../util/myTextField.dart';
import '../../../../util/shared_preferences.dart';
import '../../home/prisentation/home_teacher.dart';
import 'bloc/cubit.dart';
import 'bloc/states.dart';


class SignUpScreenTeacher extends StatelessWidget {
  const SignUpScreenTeacher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => SignInCubitTeacher(),
      child: BlocConsumer<SignInCubitTeacher, SignInScreenStatesTeacher>(
        listener: (context, state) {
          if(state is SignInSuccessStateTeacher){
            SharedPref.saveData(key: 'token', value: state.signInModel.token)
                .then((value) {
              print(SharedPref.getData(key: 'token'));
              print(state.signInModel.token);
            });
            print(state.signInModel.token);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeTeacher()));
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
                                child: Image.asset('assets/images/signup1.jpg'))),
                        Text('Welcome Teacher ',
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: mainColor,
                              fontSize: 30.sp),),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            myTextField(
                              width: 354.w,
                              height: 46.h,
                              prefixIcon: Icon(Icons.person),
                              controller: nameController,
                              validatorValue: ' Name is embty',
                              labelText: 'Your name',

                            ),
                            // SizedBox(width: 20.w,),
                            // myTextField(
                            //   width: 166.w,
                            //   height: 46.h,
                            //   controller: lastNameController,
                            //   validatorValue: 'Last name is embty',
                            //   labelText: 'Last name',
                            //
                            // ),
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        myTextField(
                          width: 354.w,
                          height: 46.h,
                          controller: emailController,
                          prefixIcon: Icon(Icons.email),
                          validatorValue: 'emil address must not be embty',
                          labelText: 'Email',

                          keyboardType: TextInputType.emailAddress,

                        ),
                        SizedBox(height: 20.h,),
                        myTextField(
                          width: 354.w,
                          height: 46.h,
                          controller: phoneController,
                          prefixIcon: Icon(Icons.phone),
                          validatorValue: 'phone number must not be embty',
                          labelText: 'phone',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20.h,),
                        myTextField(
                          width: 354.w,
                          height: 46.h,
                          controller: passwordController,
                          validatorValue: 'password must not be empty',
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'password',
                          obscureText: SignInCubitTeacher
                              .get(context)
                              .isPasswordShow,

                          suffixIcon: IconButton(
                            onPressed: () {
                              SignInCubitTeacher.get(context).changePasswordVisibility();
                            },
                            icon: Icon(SignInCubitTeacher
                                .get(context)
                                .suffix),

                          ),

                        ),
                        SizedBox(height: 20.h,),
                        Center(
                          child: defaultbutton(
                              function: () {
                             // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage()));
                                if (formKey.currentState!.validate()) {
                                  SignInCubitTeacher.get(context).userSignIn(
                                      nameController.text,
                                      emailController.text,
                                      phoneController.text,
                                    passwordController.text,
                                    passwordController.text,
                                  );
                                }
                              },
                              text: 'Sign up',
                              //textColor: Colors.white,
                              width: 128.w,
                              height: 41.h,
                              fontSizeText: 18.sp,
                              textColor: fillColorInTextFormField,
                              backround:mainColor
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You have an account ?',
                              style: TextStyle(fontSize: 14.sp,color: mainColor),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
                                },
                                child:  Text(
                                  'Login',
                                  style: TextStyle(fontWeight: FontWeight.w700,
                                      fontSize: 16.sp, color:mainColor),
                                )),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Expanded(child: Divider(
                                thickness: 1, color: Color(0xff707070))),

                            Padding(
                              padding: EdgeInsets.only(left: 15.w, right: 15.w),
                              child: Text(
                                'Or', style: TextStyle(fontSize: 14.sp),),
                            ),
                            Expanded(child: Divider(
                              thickness: 1, color: Color(0xff707070),)),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            defaultbutton(
                                function: (){},
                                text: 'Google',
                                width: 128.w,
                                height: 41.h,
                                fontSizeText: 18.sp,
                                textColor: mainColor,
                                backround: fillColorInTextFormField
                            ),
                            defaultbutton(
                                function: (){
                                },
                                text: 'Facebook',
                                width: 128.w,
                                height: 41.h,
                                fontSizeText: 18.sp,
                                textColor: mainColor,

                                backround:fillColorInTextFormField
                            ),
                          ],
                        ),
                        SizedBox(height: 200.h,),

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
