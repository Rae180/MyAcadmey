import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../util/colors.dart';
import '../../../../util/defaultbutton.dart';
import '../../../../util/show_message_on_screen.dart';
import '../data/List_lesson_notification_model.dart';
import '../data/show_lesson_notificaiton_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class ListOfLessonNotification extends StatelessWidget {
   ListOfLessonNotification({Key? key}) : super(key: key);
ListLessonsAddedNotificationModel? lessonsAddedNotificationModel;
   ShowLessonNotificationModel ?showLessonNotificationModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowNotificationInstituteCubit()..getLessonNotification(),
    child: BlocConsumer<ShowNotificationInstituteCubit,ShowNotificationInstituteState>(
      listener: (context,state){
        if(state is ShowNotificationAddLessonSuccessState)
          lessonsAddedNotificationModel=state.lessonsAddedNotificationModel;
        if(state is ShowNotificationAddLessonErrorState)
          showMessageOnScreen(context: context, titleText: "Error", messageText: "there are an error");
        if(state is ShowLessonDetailsSuccessState)
          showLessonNotificationModel=state.showLessonNotificationModel;
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Lesson Notification',
              style: TextStyle(color: mainColor),
            ),
            backgroundColor: fillColorInTextFormField,
            iconTheme: IconThemeData(color: mainColor),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.notifications),
              )
            ],
          ),
          body:lessonsAddedNotificationModel?.data==null?Center(child: CircularProgressIndicator(),): ListView.builder(
              itemCount: lessonsAddedNotificationModel?.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      ShowNotificationInstituteCubit.get(context).showDetailsLessonNotification(lessonsAddedNotificationModel!.data![index].lessonId!);
                      showDialog(
                          context: context,
                          builder: (BuildContext ccontext) => Center(
                            child: Dialog(
                              backgroundColor: fillColorInTextFormField,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              //this right here
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:showLessonNotificationModel?.data==null?Center(child: CircularProgressIndicator(),): Container(
                                  height: 400.h,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text("${showLessonNotificationModel!.data![index].name}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.sp,
                                              color: mainColor)),
                                      Text("${showLessonNotificationModel!.data![index].title1}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.sp,
                                              color: mainColor)),
                                      Text("${showLessonNotificationModel!.data![index].title2}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.sp,
                                              color: mainColor)),
                                      Text("${showLessonNotificationModel!.data![index].title3}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.sp,
                                              color: mainColor)),
                                      Text("${showLessonNotificationModel!.data![index].title4}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.sp,
                                              color: mainColor)),
                                      Text("${showLessonNotificationModel!.data![index].title5}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.sp,
                                              color: mainColor)),
                                      Text("${showLessonNotificationModel!.data![index].title6}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.sp,
                                              color: mainColor)),
                                      defaultbutton(
                                          backround: mainColor,
                                          text: "Done",
                                          textColor: fillColorInTextFormField,
                                          function: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                    child: Container(
                      width: 332.w,
                      height: 75.h,
                      decoration: BoxDecoration(
                          color: fillColorInTextFormField,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: borderContainer,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "${lessonsAddedNotificationModel!.data![index].title}",
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    ),
    );
  }
}


