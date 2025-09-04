import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../util/colors.dart';
import '../../../../util/show_message_on_screen.dart';
import '../data/pending_list_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class PendingListTeacher extends StatefulWidget {
  PendingListTeacher({Key? key}) : super(key: key);

  @override
  State<PendingListTeacher> createState() => _PendingListTeacherState();
}

class _PendingListTeacherState extends State<PendingListTeacher> {
  PendingListTeacherModel? pendingListTeacherModel;
  int c=0;
  void _refreshPage() {

    setState(() {
       c++;
       // You can update any state variables here
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PendingListTeacherCubit()..getPendingList(),
      child: BlocConsumer<PendingListTeacherCubit, PendingListTeacherStatus>(
        listener: (context, state) {
          if (state is PendingListTeacherSuccessState)pendingListTeacherModel = state.pendingListTeacherModel;
          if (state is DeleteErrorState) {
            showMessageOnScreen(
                context: context,
                titleText: "Done",
                messageText: "deleted is successfully",
                backgroundColor: Colors.green,
                titleColor: Colors.white,
                messageColor: Colors.white);
                PendingListTeacherCubit.get(context).getPendingList();

          } else if (state is DeleteSuccessState) {
            showMessageOnScreen(
                context: context,
                titleText: "Error",
                messageText: "deleted don't completed");
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: fillColorInTextFormField,
              foregroundColor: mainColor,
              title: Text(

                'LangHub',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: mainColor),
              ),
            ),

            body: pendingListTeacherModel?.data == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: pendingListTeacherModel?.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 332.w,
                          height: 115.h,
                          decoration: BoxDecoration(
                              color: fillColorInTextFormField,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: borderContainer,
                              )),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '${pendingListTeacherModel!.data![index].image}'),
                                radius: 45.r,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' ${pendingListTeacherModel!.data![index].name}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.sp,
                                            color: mainColor),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Text(
                                        ' ${pendingListTeacherModel!.data![index].location}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                            color: mainColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext ccontext) =>
                                                    Center(
                                                      child: Dialog(
                                                        backgroundColor:
                                                            fillColorInTextFormField,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0)),
                                                        //this right here
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 100.h,
                                                            width:
                                                                double.infinity,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: <Widget>[
                                                                Text(
                                                                    "Are you sure",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize: 20
                                                                            .sp,
                                                                        color:
                                                                            mainColor)),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'No',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 20.sp,
                                                                              color: mainColor),
                                                                        )),
                                                                    SizedBox(
                                                                      width:
                                                                          10.w,
                                                                    ),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                    PendingListTeacherCubit.get(context).deleteRequest(pendingListTeacherModel!.data![index].id!);
                                                                              Navigator.pop(context);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Yes',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 20.sp,
                                                                              color: mainColor),
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
                                      child: Text(
                                        "cancel",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 20.sp,
                                            color: Colors.red),
                                      ))
                                ],
                              )
                            ],
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
