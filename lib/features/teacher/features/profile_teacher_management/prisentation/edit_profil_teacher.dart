import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../util/colors.dart';
import '../../../../util/defaultbutton.dart';
import '../../../../util/myTextField.dart';
import '../../../../util/show_message_on_screen.dart';
import '../data/profile_teacher_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class EditProfileTeacher extends StatefulWidget {
  EditProfileTeacher({Key? key, this.profileTeacherModel}) : super(key: key);
  final ProfileTeacherModel? profileTeacherModel;

  @override
  State<EditProfileTeacher> createState() => _EditProfileTeacherState();
}

class _EditProfileTeacherState extends State<EditProfileTeacher> {
  File? _image;
  String? imageEdit;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        imageEdit = null; // Reset the imageEdit when a new image is selected
      });
    }
  }

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerOldPassword = TextEditingController();
  TextEditingController controllerNewPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // addBookCubit = AddBookCubit(dioHelper: DioHelper());
    controllerName.text = "${widget.profileTeacherModel?.data!.name!}" ;
    controllerEmail.text = "${widget.profileTeacherModel?.data!.email!}";
    controllerPhone.text = "${widget.profileTeacherModel?.data!.phoneNumber ?? 00}";
    imageEdit = "${widget.profileTeacherModel?.data!.photo}";
  }

  bool back = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileTeacherCubit(),
      child: BlocConsumer<ProfileTeacherCubit, ProfileTeacherStatus>(
        listener: (context, state) {
          if (state is ChangePasswordProfileTeacherSuccessState) {
            if (state.changePasswordModel.status == 200) {
              showMessageOnScreen(
                  context: context,
                  titleText: "Error",
                  messageText: "The current password is incorrect",

                  messageColor: Colors.blueAccent,
                  backgroundColor: Colors.green);
              back = true;
            } else {
              showMessageOnScreen(
                context: context,
                titleText: "Success",
                messageText: "Password changed successfully",
                  messageColor: Colors.blueAccent,
                  backgroundColor: Colors.grey
              );
            }
          } else {}
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: mainColor,
              backgroundColor: fillColorInTextFormField,
              title: Text(
                "Edit Profile",
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: mainColor),
              ),
            ),
            body: widget.profileTeacherModel?.data?.name == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40.h),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => Center(
                                      child: Dialog(
                                        backgroundColor:
                                            fillColorInTextFormField,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        //this right here
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 200.h,
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text("chose from Gallery",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 20.sp,
                                                        color: mainColor)),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                defaultbutton(
                                                    backround: mainColor,
                                                    text: "Gallery",
                                                    textColor:
                                                        fillColorInTextFormField,
                                                    function: () {
                                                      _pickImage(
                                                          ImageSource.gallery);
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text("chose from camera",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 20.sp,
                                                        color: mainColor)),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                defaultbutton(
                                                    backround: mainColor,
                                                    text: "Camera",
                                                    textColor:
                                                        fillColorInTextFormField,
                                                    function: () {
                                                      _pickImage(
                                                          ImageSource.camera);
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                          },
                          child: CircleAvatar(
                            radius: 110.r,
                            backgroundImage: _image != null
                                ? Image.file(_image!)
                                    .image // Convert FileImage to ImageProvider
                                : imageEdit != null
                                    ? NetworkImage(
                                        "$imageEdit") // Display the existing image
                                    : null, // Display the default icon

                            child: _image == null && imageEdit == null
                                ? Icon(
                                    Icons.camera_alt,
                                    size: 80,
                                    color: mainColor,
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        myTextField(
                          labelText: 'name',
                          radios: 20.r,
                          controller: controllerName,
                        ),
                        SizedBox(height: 20.h),
                        myTextField(
                          labelText: 'phone',
                          radios: 20.r,
                          controller: controllerPhone,
                        ),
                        SizedBox(height: 20.h),
                        myTextField(
                          labelText: 'email',
                          radios: 20.r,
                          controller: controllerEmail,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("can you change password:",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.sp,
                                    color: mainColor)),
                            TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ccontext) =>
                                          Center(
                                            child: Dialog(
                                              backgroundColor:
                                                  fillColorInTextFormField,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0)),
                                              //this right here
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 220.h,
                                                  width: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text("Old Password",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 20.sp,
                                                              color:
                                                                  mainColor)),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      myTextField(
                                                          controller:
                                                              controllerOldPassword,
                                                          colorfillColor:
                                                              Colors.white),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text("New Password",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 20.sp,
                                                              color:
                                                                  mainColor)),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      myTextField(
                                                          controller:
                                                              controllerNewPassword,
                                                          colorfillColor:
                                                              Colors.white),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                'cancel',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20.sp,
                                                                    color:
                                                                        mainColor),
                                                              )),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          TextButton(
                                                              onPressed: () {
                                                                ProfileTeacherCubit
                                                                        .get(
                                                                            context)
                                                                    .changePassword(
                                                                        controllerOldPassword
                                                                            .text,
                                                                       controllerNewPassword
                                                                            .text);

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                'Change',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20.sp,
                                                                    color:
                                                                        mainColor),
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ));
                                },
                                child: Text("change password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                        color: mainColor)))
                          ],
                        ),
                        SizedBox(height: 20.h),
                        defaultbutton(
                            backround: mainColor,
                            text: "Done",
                            textColor: fillColorInTextFormField,
                            function: () {
                              // print("${controllerPhone.text}"+ "hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
                              ProfileTeacherCubit.get(context).updateProfile(controllerName.text, controllerPhone.text ,controllerEmail.text );
                            }),
                        SizedBox(height: 300.h),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
