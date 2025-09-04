import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../util/colors.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class PendingListStudent extends StatelessWidget {
  const PendingListStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>PendingListStudentCubit()..getPendingList(),
    child: BlocConsumer<PendingListStudentCubit,PendingListStudentStatus>(
      listener: (context,state){
// if(state is PendingListStudentSuccessState)

      },
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: fillColorInTextFormField,
            foregroundColor: mainColor,
            title: Text(
              'LangHub',
              style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: mainColor),
            ) ,
          ),
          body: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 332.w,
                    height: 109.h,
                    decoration: BoxDecoration(
                        color: fillColorInTextFormField,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: borderContainer,
                        )),
                    child: Row(
                      children: [
                        SizedBox(width: 10.w,),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/p.png'),
                          radius: 45.r,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' ALTC institue',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp,color: mainColor),),
                                SizedBox(height: 15.h,),
                                Text(' English',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,color: mainColor),),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Center(
                                    child: Dialog(
                                      backgroundColor: fillColorInTextFormField,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0)),
                                      //this right here
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 100.h,
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                  "Are you sure",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 20.sp,
                                                      color: mainColor)),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'No',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 20.sp,
                                                            color: mainColor),
                                                      )),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        'Yes',
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold,
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
                            }, child: Text("cancel",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20.sp,color: Colors.red),))
                          ],)
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
