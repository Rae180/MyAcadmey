import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../util/colors.dart';
import '../../../../util/defaultbutton.dart';
import '../../../../util/show_message_on_screen.dart';
import '../data/studentForAddDegreeModel.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class Student {
  final int id;
  final String name;
  final String email;
  final String phone;
  int degree;

  Student(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      this.degree = 0});
}

final List<Student> students = [
  Student(
      id: 1, name: "John", email: "john@example.com", phone: "123-456-7890"),
  Student(
      id: 2, name: "Alice", email: "alice@example.com", phone: "987-654-3210"),
];

class StudentList extends StatefulWidget {
  int id;

  StudentList(this.id);

  final List<Student> students = [
    Student(
        id: 1, name: "John", email: "john@example.com", phone: "123-456-7890"),
    Student(
        id: 2,
        name: "Alice",
        email: "alice@example.com",
        phone: "987-654-3210"),
    Student(
        id: 3,
        name: "Alice",
        email: "alice@example.com",
        phone: "987-654-3210"),
    Student(
        id: 5,
        name: "Alice",
        email: "alice@example.com",
        phone: "987-654-3210"),
    Student(
        id: 7,
        name: "Alice",
        email: "alice@example.com",
        phone: "987-654-3210"),
    Student(
        id: 6,
        name: "Alice",
        email: "alice@example.com",
        phone: "987-654-3210"),
  ];

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  Map<int, int> degrees = {};
  StudentForAddDegreeModel? studentForAddDegreeModel;
  AddDegreeModel? addDegreeModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          CourseTeacherCubit()..getStudentForAddDegree(widget.id),
      child: BlocConsumer<CourseTeacherCubit, CourseTeacherStatus>(
        listener: (context, state) {
          if (state is GetStudentAddDegreeSuccessState)
            studentForAddDegreeModel = state.studentForAddDegreeModel;
          if (state is AddDegreeSuccessState) {
            addDegreeModel = state.addDegreeModel;
            if (addDegreeModel!.status == 200) {
              showMessageOnScreen(
                  context: context,
                  titleText: "Done",
                  messageText: addDegreeModel!.message!,
                  backgroundColor: Colors.green,
                  messageColor: Colors.red);
            }else{
              showMessageOnScreen(
                  context: context,
                  titleText: "Error",
                  messageText: addDegreeModel!.message!,
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
                "Add Degree",
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: mainColor),
              ),
            ),
            body: studentForAddDegreeModel?.students == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    // reverse: true,
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: studentForAddDegreeModel?.students?.length,
                          itemBuilder: (context, index) {
                            // if (index == 0) {
                            //   // Empty item to create space for scrolling up when the keyboard is opened
                            //   return SizedBox(height: MediaQuery.of(context).viewInsets.bottom);
                            // }
                            // Student student = studentForAddDegreeModel?.students[index];
                            int? currentDegree = degrees[
                                studentForAddDegreeModel!
                                    .students![index].id]; // Use nullable type
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 380.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                    color: fillColorInTextFormField,
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: borderContainer,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${studentForAddDegreeModel!.students![index].firstName}+${studentForAddDegreeModel!.students![index].lastName} ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                  color: mainColor),
                                            ),
                                            Text(
                                              '${studentForAddDegreeModel!.students![index].email}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp,
                                                  color: mainColor),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${studentForAddDegreeModel!.students![index].phoneNumber}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16.sp,
                                                      color: mainColor),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 80.w,
                                            child: SizedBox(
                                              height: 46.h,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: TextFormField(
                                                    keyboardType: TextInputType
                                                        .number,
                                                    initialValue: currentDegree !=
                                                            null
                                                        ? currentDegree
                                                            .toString()
                                                        : null,
                                                    // Set initialValue to null if degree is not assigned
                                                    onChanged: (value) {
                                                      setState(() {
                                                        currentDegree =
                                                            int.tryParse(value);
                                                        degrees[
                                                                studentForAddDegreeModel!
                                                                    .students![
                                                                        index]
                                                                    .id!] =
                                                            currentDegree!;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            fillColorInTextFormField,
                                                        labelText: 'degree',
                                                        labelStyle:
                                                            TextStyle(
                                                                color:
                                                                    mainColor),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10
                                                                            .r),
                                                                borderSide:
                                                                    BorderSide(
                                                                        width: 2
                                                                            .w,
                                                                        color:
                                                                            mainColor)),
                                                        suffixIconColor:
                                                            mainColor,
                                                        prefixIconColor:
                                                            mainColor,
                                                        hintStyle:
                                                            TextStyle(
                                                                color:
                                                                    mainColor),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                          borderSide:
                                                              BorderSide(
                                                            color: mainColor,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF210440),
                                                                )))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        defaultbutton(
                            backround: mainColor,
                            text: 'Done',
                            textColor: fillColorInTextFormField,
                            width: 150.w,
                            function: () {
                              String degreeText = degrees.entries
                                  .map((entry) =>
                                      '"${entry.key}":${entry.value}')
                                  .join(', ');
                             // print("{" + degreeText + "}");
                              String sss = "{" + degreeText + "}";
                              
                              String validJsonString = json.encode(sss);
                              CourseTeacherCubit.get(context)
                                  .AddDegree(widget.id, json.decode(validJsonString));
                              print(json.decode(validJsonString));
                             // Navigator.pop(context);
                            }),
                        SizedBox(
                          height: 300.h,
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
