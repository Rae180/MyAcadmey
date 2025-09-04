import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/colors.dart';
import '../../pending_list_student/prisentation/pending_list_student.dart';
import '../../search_and_enrollment_student/prisentation/search_student.dart';
import 'bloc/cubit.dart';
import 'bloc/states.dart';

class HomeStudent extends StatelessWidget {
  const HomeStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeStudentCubit(),
      child: BlocConsumer<HomeStudentCubit, HomeStudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: fillColorInTextFormField,
              title: Text(
                'LangHub',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: mainColor),
              ),
              actions: [

                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchStudent()));
                  },
                  color: mainColor,
                  icon: Icon(
                    Icons.search,

                    color: mainColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PendingListStudent()));
                  },
                  color: mainColor,
                  icon: Icon(
                    Icons.send_to_mobile,

                    color: mainColor,
                  ),
                )
              ],
            ),
            body: HomeStudentCubit.get(context)
                .screen[HomeStudentCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: HomeStudentCubit.get(context).currentIndex,
              onTap: (index) {
                HomeStudentCubit.get(context).changeIndex(index);
              },
              unselectedItemColor: mainColor,
              unselectedFontSize: 14,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: fillColorInTextFormField,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon:
                        Icon(Icons.business_sharp, color: mainColor, size: 30),
                    label: 'Screen One',
                    backgroundColor: fillColorInTextFormField),
                BottomNavigationBarItem(
                    icon:
                        Icon(Icons.account_circle, color: mainColor, size: 30),
                    label: 'Screen Two',
                    backgroundColor: fillColorInTextFormField),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_sharp,
                      color: mainColor,
                      size: 30,
                    ),
                    label: 'Screen Three',
                    backgroundColor: fillColorInTextFormField),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications, color: mainColor, size: 30),
                    label: 'Screen Four',
                    backgroundColor: fillColorInTextFormField),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_rounded, color: mainColor, size: 30),
                    label: 'Screen Four',
                    backgroundColor: fillColorInTextFormField),
              ],
            ),
          );
        },
      ),
    );
  }
}
