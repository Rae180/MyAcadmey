import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/Student/featuers/profile_student_management/Bloc/bloc/profile_bloc.dart';
import 'package:start/features/Student/featuers/profile_student_management/Models/profile_model.dart';
import 'package:start/features/util/colors.dart';
import 'package:start/features/util/defaultbutton.dart';
import 'package:start/features/util/myTextField.dart';
import 'package:start/features/util/show_message_on_screen.dart';
import 'package:http/http.dart' as http;

class EditProfileStudent extends StatefulWidget {
  EditProfileStudent({Key? key, this.profileStudentModel}) : super(key: key);
  final ProfileStudentModel? profileStudentModel;

  @override
  State<EditProfileStudent> createState() => _EditProfileStudentState();
}

class _EditProfileStudentState extends State<EditProfileStudent> {
  File? _image;
  String? imageEdit;
  late TextEditingController _controllerName;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerOldPassword;
  late TextEditingController _controllerNewPassword;

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerOldPassword = TextEditingController();
    _controllerNewPassword = TextEditingController();

    _controllerName.text = widget.profileStudentModel?.profile?.name ?? '';
    _controllerEmail.text = widget.profileStudentModel?.profile?.email ?? '';
    _controllerPhone.text =
        widget.profileStudentModel?.profile?.phoneNumber ?? '';
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        imageEdit = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(client: NetworkApiServiceHttp()),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: mainColor,
          backgroundColor: fillColorInTextFormField,
          title: Text(
            "Edit Profile",
            style: TextStyle(
                fontSize: 24.sp, fontWeight: FontWeight.bold, color: mainColor),
          ),
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileStuSuccess) {
              showMessageOnScreen(
                context: context,
                titleText: "Success",
                messageText: "Profile updated successfully",
                backgroundColor: Colors.green,
              );
            } else if (state is ChangePasswordSuccess) {
              showMessageOnScreen(
                context: context,
                titleText: "Success",
                messageText: "Password changed successfully",
                backgroundColor: Colors.green,
              );
              // Clear password fields
              _controllerOldPassword.clear();
              _controllerNewPassword.clear();
            } else if (state is ProfileError) {
              showMessageOnScreen(
                context: context,
                titleText: "Error",
                messageText: state.message,
                backgroundColor: Colors.red,
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  _buildProfileImage(),
                  SizedBox(height: 20.h),
                  _buildFormFields(),
                  SizedBox(height: 20.h),
                  _buildChangePasswordOption(context),
                  SizedBox(height: 20.h),
                  _buildUpdateButton(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return InkWell(
      onTap: _showImagePickerDialog,
      child: CircleAvatar(
        radius: 110.r,
        backgroundImage: _getProfileImage(),
        child: _image == null && imageEdit == null
            ? Icon(Icons.camera_alt, size: 80, color: mainColor)
            : null,
      ),
    );
  }

  ImageProvider? _getProfileImage() {
    if (_image != null) {
      return FileImage(_image!);
    } else if (imageEdit != null) {
      return NetworkImage(imageEdit!);
    }
    return null;
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: fillColorInTextFormField,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200.h,
            child: Column(
              children: <Widget>[
                _buildImagePickerOption("Gallery", Icons.photo, () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                }),
                _buildImagePickerOption("Camera", Icons.camera_alt, () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerOption(
      String text, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: mainColor),
      title: Text(text),
      onTap: onTap,
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        myTextField(controller: _controllerName, labelText: 'Name'),
        SizedBox(height: 20.h),
        myTextField(controller: _controllerPhone, labelText: 'Phone'),
        SizedBox(height: 20.h),
        myTextField(controller: _controllerEmail, labelText: 'Email'),
      ],
    );
  }

  Widget _buildChangePasswordOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Change password:",
            style: TextStyle(fontSize: 18.sp, color: mainColor)),
        TextButton(
          onPressed: () => _showChangePasswordDialog(context),
          child: Text("Change password",
              style: TextStyle(fontSize: 18.sp, color: mainColor)),
        ),
      ],
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: fillColorInTextFormField,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              myTextField(
                controller: _controllerOldPassword,
                labelText: 'Old Password',
                isPassword: true,
              ),
              SizedBox(height: 10.h),
              myTextField(
                controller: _controllerNewPassword,
                labelText: 'New Password',
                isPassword: true,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: 10.w),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return CircularProgressIndicator();
                      }
                      return TextButton(
                        onPressed: () {
                          if (_controllerOldPassword.text.isEmpty ||
                              _controllerNewPassword.text.isEmpty) {
                            showMessageOnScreen(
                              context: context,
                              titleText: "Error",
                              messageText: "Please fill all fields",
                              backgroundColor: Colors.red,
                            );
                            return;
                          }
                          
                          context.read<ProfileBloc>().add(ChangePasswordEvent(
                            current: _controllerOldPassword.text,
                            newPass: _controllerNewPassword.text,
                          ));
                        },
                        child: Text('Change'),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return defaultbutton(
          backround: mainColor,
          text: state is ProfileLoading ? "Updating..." : "Update Profile",
          textColor: fillColorInTextFormField,
          function: state is ProfileLoading
              ? () {}
              : () {
                  final names = _controllerName.text.split(' ');
                  final firstName = names.first;
                  final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

                  context.read<ProfileBloc>().add(UpdateProfileEvent(
                    firstName: firstName,
                    lastName: lastName,
                    phone: _controllerPhone.text,
                  ));
                },
        );
      },
    );
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerPhone.dispose();
    _controllerEmail.dispose();
    _controllerOldPassword.dispose();
    _controllerNewPassword.dispose();
    super.dispose();
  }
}