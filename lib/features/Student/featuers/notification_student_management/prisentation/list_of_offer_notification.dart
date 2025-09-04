import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../util/colors.dart';
import '../../../../util/defaultbutton.dart';
import '../../../../util/show_message_on_screen.dart';
import '../../../../util/summary.dart';
import '../data/list_accept_offer_notification_model.dart';
import '../data/showOfferDetailsNotificationModel.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class ListOfOffersNotification extends StatelessWidget {
  ListOfOffersNotification({Key? key}) : super(key: key);
  ShowOfferDetailsNotificationModel? showOfferDetailsNotificationModel;
 ListAcceptOfferNotificationModel ?listAcceptOfferNotificationModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ShowNotificationInstituteCubit()..getOfferNotification(),
      child: BlocConsumer<ShowNotificationInstituteCubit,
          ShowNotificationInstituteState>(
        listener: (context, state) {
          if(state is ShowNotificationOfferSuccessState)
            listAcceptOfferNotificationModel=state.listAcceptOfferNotificationModel;

          if (state is ShowOfferDetailsSuccessState)
            showOfferDetailsNotificationModel =
                state.showOfferDetailsNotificationModel;
          if(state is ShowOfferDetailsErrorState)
            showMessageOnScreen(context: context, titleText: "Error", messageText: "there are an error");

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Offers Notification',
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
            body:listAcceptOfferNotificationModel?.message==null?Center(child: CircularProgressIndicator(),): ListView.builder(
                itemCount: listAcceptOfferNotificationModel?.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsInstituteStudent(showStudentInstituteModel: showStudentInstituteModel!.data?[index].id,)));
                        // navigateTo(context, CourseDetails());
                        ShowNotificationInstituteCubit.get(context).showDetailsOfferNotification(listAcceptOfferNotificationModel!.data![index].id!);
                        showDialog(
                            context: context,
                            builder: (BuildContext ccontext) =>showOfferDetailsNotificationModel!.data==null?Center(child: CircularProgressIndicator(),): Center(
                                  child: Dialog(
                                    backgroundColor: fillColorInTextFormField,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
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
                                                  color:
                                                      fillColorInTextFormField,
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        '${showOfferDetailsNotificationModel!.data!.image}',
                                                      )),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                  border: Border.all()),
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Container(
                                              width: 290.w,
                                              height: 226.h,
                                              decoration: BoxDecoration(
                                                  color:
                                                      fillColorInTextFormField,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                  border: Border.all()),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      "${showOfferDetailsNotificationModel!.data!.name}",
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: mainColor),
                                                    ),
                                                    Text(
                                                      "${showOfferDetailsNotificationModel!.data!.price}",
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: mainColor),
                                                    ),
                                                    Text(
                                                      "Start in:${showOfferDetailsNotificationModel!.data!.startDate} ",
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: mainColor),
                                                    ),
                                                    Text(
                                                      "end in:${showOfferDetailsNotificationModel!.data!.endDate}",
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: mainColor),
                                                    ),
                                                    Text(
                                                      "Number of hour :${showOfferDetailsNotificationModel!.data!.hours} hour",
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: mainColor),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            ShowMoreShowLess(
                                                text: "${showOfferDetailsNotificationModel!.data!.description}"),
                                            defaultbutton(
                                                backround: mainColor,
                                                text: "Done",
                                                textColor:
                                                    fillColorInTextFormField,
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
                          child: Text("${listAcceptOfferNotificationModel!.data?[index].title}",
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
