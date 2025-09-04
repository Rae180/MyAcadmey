import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../util/colors.dart';
import '../../../../util/defaultbutton.dart';
import '../../../../util/show_message_on_screen.dart';
import '../../../../util/summary.dart';
import '../data/ListAcceptInstituteNotificationModel.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class ListOfInstituteNotification extends StatelessWidget {
   ListOfInstituteNotification({Key? key}) : super(key: key);
  ListAcceptInstituteNotificationModel ?listAcceptInstituteNotificationModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowNotificationInstituteCubit()..getNotificationInstitute(),
      child: BlocConsumer<ShowNotificationInstituteCubit,ShowNotificationInstituteState>(
        listener: (context,state){
          if(state is ShowNotificationInstituteSuccessState)
            listAcceptInstituteNotificationModel=state.listAcceptInstituteNotificationModel;
          if(state is ShowNotificationInstituteErrorState)
            showMessageOnScreen(context: context, titleText: "Error", messageText: "there are an error");
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Institute Notificatoin',
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
            body:listAcceptInstituteNotificationModel?.data==null?Center(child: CircularProgressIndicator(),): ListView.builder(
                itemCount: listAcceptInstituteNotificationModel!.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsInstituteStudent(showStudentInstituteModel: showStudentInstituteModel!.data?[index].id,)));
                        // navigateTo(context, CourseDetails());

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
                                  child: Container(
                                    height: 600.h,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Container(
                                          width: 217.w,
                                          height: 183.h,
                                          decoration: BoxDecoration(
                                              color: fillColorInTextFormField,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                    'assets/images/p.png',
                                                  )),
                                              borderRadius: BorderRadius.circular(20.r),
                                              border: Border.all()),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Container(
                                          width: 290.w,
                                          height: 226.h,
                                          decoration: BoxDecoration(
                                              color: fillColorInTextFormField,
                                              borderRadius: BorderRadius.circular(20.r),
                                              border: Border.all()),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "name",
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: mainColor),
                                                ),
                                                Text(
                                                  "price",
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: mainColor),
                                                ),

                                                Text(
                                                  "Start in: ",
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.normal,
                                                      color: mainColor),
                                                ),
                                                Text(
                                                  "end in:",
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.normal,
                                                      color: mainColor),
                                                ),
                                                Text(
                                                  "Number of hour :5 hour",
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.normal,
                                                      color: mainColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        ShowMoreShowLess(text: "sdgdfgdrre"),
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
                              "${listAcceptInstituteNotificationModel!.data![index].title}",
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


