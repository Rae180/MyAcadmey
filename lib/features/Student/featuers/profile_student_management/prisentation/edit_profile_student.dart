import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:start/features/Student/featuers/profile_student_management/data/profile_model.dart';
import 'package:start/features/Student/featuers/profile_student_management/prisentation/bloc/cubit.dart';
import 'package:start/features/Student/featuers/profile_student_management/prisentation/bloc/status.dart';
import 'package:start/features/util/colors.dart';
import 'package:start/features/util/defaultbutton.dart';
import 'package:start/features/util/myTextField.dart';
import 'package:start/features/util/show_message_on_screen.dart';




class EditProfileStudent extends StatefulWidget {
  EditProfileStudent({Key? key, this.profileStudentModel}) : super(key: key);
  final ProfileStudentModel? profileStudentModel;

  @override
  State<EditProfileStudent> createState() => _EditProfileStudentState();
}

class _EditProfileStudentState extends State<EditProfileStudent> {
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

  ChangePasswordModel  ? changePasswordModel;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerOldPassword = TextEditingController();
  TextEditingController _controllerNewPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // addBookCubit = AddBookCubit(dioHelper: DioHelper());
    _controllerName.text =
        "${widget.profileStudentModel?.profile!.name!}" ;

    _controllerEmail.text = "${widget.profileStudentModel?.profile!.email!}";
    _controllerPhone.text =
    "${widget.profileStudentModel?.profile!.phoneNumber!}";
    imageEdit = "${widget.profileStudentModel?.profile!.student!.image}";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileStudentCubit(),
      child: BlocConsumer<ProfileStudentCubit, ProfileStudentStatus>(
        listener: (context, state) {
          if (state is ChangePasswordStudentSuccessState) {
            changePasswordModel = state.changePasswordModel as ChangePasswordModel?   ;
            if (changePasswordModel!.message == "Password changed successfully") {
              showMessageOnScreen(context: context,
                  titleText: "Done",
                  messageText: "${changePasswordModel!.message}",
                  titleColor:Colors.black,
                  messageColor:Colors.black,
                  backgroundColor:Colors.green
                  );

            }else{
              showMessageOnScreen(context: context,
                  titleText: "Error",
                  messageText: "${changePasswordModel!.message}",
                  backgroundColor:Colors.red
              );
            }
          }
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
            body: widget.profileStudentModel?.profile?.name == null
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
                          builder: (BuildContext context) =>
                              Center(
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
                          ? Image
                          .file(_image!)
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
                    controller: _controllerName,
                  ),
                  SizedBox(height: 20.h),
                  myTextField(
                    labelText: 'phone',
                    radios: 20.r,
                    controller: _controllerPhone,
                  ),
                  SizedBox(height: 20.h),
                  myTextField(
                    labelText: 'email',
                    radios: 20.r,
                    controller: _controllerEmail,
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
                                            height: 230.h,
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
                                                    _controllerOldPassword,
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
                                                    _controllerNewPassword,
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

                                                          ProfileStudentCubit
                                                              .get(
                                                              context)
                                                              .changePasswordStudent(
                                                              _controllerOldPassword
                                                                  .text,
                                                              _controllerNewPassword
                                                                  .text);

                                                          print(_controllerNewPassword.text + _controllerOldPassword.text);
                                                          Navigator.pop(context);
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
                        ProfileStudentCubit.get(context).updateProfile(
                            _controllerName.text,
                            _controllerEmail.text,
                            _controllerPhone.text,
                            _image);
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
