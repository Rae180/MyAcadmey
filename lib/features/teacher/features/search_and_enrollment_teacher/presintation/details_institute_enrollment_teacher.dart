import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import '../../../../util/colors.dart';
import '../../../../util/defaultbutton.dart';
import '../../../../util/details_container.dart';
import '../../../../util/item_field.dart';
import '../../../../util/show_message_on_screen.dart';
import '../../../../util/summary.dart';
import '../../home/prisentation/widget/checkboxLanguge.dart';
import '../../home/prisentation/widget/rate_and_like_and_dislike.dart';
import '../data/search_teacher_model.dart';
import 'bloc/cubit.dart';
import 'bloc/status.dart';

class DetailsInstituteEnrollmentTeacher extends StatefulWidget {
   DetailsInstituteEnrollmentTeacher({Key? key, required this.searchTeacher}) : super(key: key);
SearchTeacher ?searchTeacher;

  @override
  State<DetailsInstituteEnrollmentTeacher> createState() => _DetailsInstituteEnrollmentTeacherState();
}

class _DetailsInstituteEnrollmentTeacherState extends State<DetailsInstituteEnrollmentTeacher> {
  final String description =
      "Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source. have a question , how can I put the show more behind the text , I mean it looks like this Flutter is Google’s mobile UI framework for... show more,they are both in the same line";

  TextEditingController Sat1 = TextEditingController(text: "-");

  TextEditingController Sun1 = TextEditingController(text: "-");

  TextEditingController Mon1 = TextEditingController(text: "-");

  TextEditingController Tue1 = TextEditingController(text: "-");

  TextEditingController Wen1 = TextEditingController(text: "-");

  TextEditingController Thu1 = TextEditingController(text: "-");

  TextEditingController Fri1 = TextEditingController(text: "-");

  TextEditingController Sat2 = TextEditingController(text: "-");

  TextEditingController Sun2 = TextEditingController(text: "-");

  TextEditingController Mon2 = TextEditingController(text: "-");

  TextEditingController Tue2 = TextEditingController(text: "-");

  TextEditingController Wen2 = TextEditingController(text: "-");

  TextEditingController Thu2 = TextEditingController(text: "-");

  TextEditingController Fri2 = TextEditingController(text: "-");

  List<String> days = ["Sat", "Sun", "Mon", "Tue", "Wen", "Thu", "Fri"];

  bool OnSat = false;

  bool OnSun = false;

  bool OnMon = false;

  bool OnTue = false;

  bool OnWen = false;

  bool OnThu = false;

  bool OnFri = false;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>SearchTeacherCubit(),
    child: BlocConsumer<SearchTeacherCubit,SearchTeacherStatus>(
      listener: (context,state){
        if(state is EnrollInstituteTeacherSuccessState)
          showMessageOnScreen(context: context, titleText: "Done ", messageText: "enrolled successfully",messageColor: Colors.red,backgroundColor: Colors.green);
        if(state is EnrollInstituteTeacherErrorState)
          showMessageOnScreen(context: context, titleText: "Error ", messageText: "enrolled error");

      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'institute details',
              style: TextStyle(color: mainColor),
            ),
            backgroundColor: fillColorInTextFormField,
            iconTheme: IconThemeData(color: mainColor),
          ),
          body:widget.searchTeacher==null?Center(child: CircularProgressIndicator(),): SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage('${widget.searchTeacher!.image1}'),
                    radius: 110.r,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Institute rate',
                        style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp),
                      ),
                      SizedBox(width: 5.w,),
                      ShowRateInstituteAndTeacher(rate: widget.searchTeacher!.rate!.toDouble()),
                    ],
                  ),
                  detailsContainer(text: '${widget.searchTeacher!.academyName}'),
                  detailsContainer(text: '${widget.searchTeacher!.address}'),
                  SizedBox(
                    height: 15.h,
                  ),
                  LanguageInDetailsInstitute(
                      english: widget.searchTeacher!.english!.isOdd, french: widget.searchTeacher!.french!.isOdd, spanish: widget.searchTeacher!.spanish!.isOdd, germany: widget.searchTeacher!.germany!.isOdd),
                  SizedBox(
                    height: 15.h,
                  ),
                  ShowMoreShowLess(text:widget.searchTeacher!.description ),
                  SizedBox(
                    height: 15.h,
                  ),
                  defaultbutton(
                      function: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage()));
                        showDialog(
                            context: context,
                            builder: (BuildContext ccontext) =>
                                Center(
                                  child: Dialog(
                                    backgroundColor: fillColorInTextFormField,
                                    shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(16.0)),
                                    //this right here
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: ScreenUtil().setWidth(480),
                                        height: ScreenUtil().setHeight(500),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: ScreenUtil().setWidth(
                                                        90),
                                                    height: ScreenUtil().setHeight(
                                                        40),
                                                    child: LiteRollingSwitch(
                                                      value: OnSat,
                                                      textOn: days[0],
                                                      textOff: days[0],
                                                      colorOn: mainColor,
                                                      textOffColor: Colors.white,
                                                      textOnColor: Colors.white,
                                                      colorOff: Colors.grey,
                                                      iconOff: Icons.delete,
                                                      iconOn: Icons.add,
                                                      // animationDuration: const Duration(milliseconds: 300),
                                                      onChanged: (bool state) {
                                                        setState(() {
                                                          OnSat = state;
                                                          print(
                                                              "boooooooooooooooolllllllll ");
                                                          print(OnSat);
                                                        });
                                                      },
                                                      onDoubleTap: () {},
                                                      onSwipe: () {},
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                  ItemField(

                                                      controller: Sat1,
                                                      ontap: () {
                                                        _selectTime(context, Sat1);
                                                        //  print(selectedTime);
                                                      }),
                                                  ItemField(
                                                      controller: Sat2,
                                                      ontap: () {
                                                        _selectTime(context, Sat2);
                                                      }),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: ScreenUtil().setWidth(
                                                        90),
                                                    height: ScreenUtil().setHeight(
                                                        40),
                                                    child: LiteRollingSwitch(
                                                      value: OnSun,
                                                      textOn: days[1],
                                                      textOff: days[1],
                                                      colorOn: mainColor,
                                                      textOffColor: Colors.white,
                                                      textOnColor: Colors.white,
                                                      colorOff: Colors.grey,
                                                      iconOff: Icons.delete,
                                                      iconOn: Icons.add,
                                                      // animationDuration: const Duration(milliseconds: 300),
                                                      onChanged: (bool state) {
                                                        setState(() {
                                                          OnSun = state;
                                                          print(
                                                              "boooooooooooooooolllllllll ");
                                                          print(OnSun);
                                                        });
                                                      },
                                                      onDoubleTap: () {},
                                                      onSwipe: () {},
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                  ItemField(

                                                      controller: Sun1,
                                                      ontap: () {
                                                        _selectTime(context, Sun1);
                                                      }),
                                                  ItemField(

                                                      controller: Sun2,
                                                      ontap: () {
                                                        _selectTime(context, Sun2);
                                                      }),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: ScreenUtil().setWidth(
                                                        90),
                                                    height: ScreenUtil().setHeight(
                                                        40),
                                                    child: LiteRollingSwitch(
                                                      value: OnMon,
                                                      textOn: days[2],
                                                      textOff: days[2],
                                                      colorOn: mainColor,
                                                      textOffColor: Colors.white,
                                                      textOnColor: Colors.white,
                                                      colorOff: Colors.grey,
                                                      iconOff: Icons.delete,
                                                      iconOn: Icons.add,
                                                      // animationDuration: const Duration(milliseconds: 300),
                                                      onChanged: (bool state) {
                                                        setState(() {
                                                          OnMon = state;
                                                          print(
                                                              "boooooooooooooooolllllllll ");
                                                          print(OnMon);
                                                        });
                                                      },
                                                      onDoubleTap: () {},
                                                      onSwipe: () {},
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                  ItemField(
                                                      controller: Mon1,
                                                      ontap: () {
                                                        _selectTime(context, Mon1);
                                                      }),
                                                  ItemField(

                                                      controller: Mon2,
                                                      ontap: () {
                                                        _selectTime(context, Mon2);
                                                      }),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: ScreenUtil().setWidth(
                                                        90),
                                                    height: ScreenUtil().setHeight(
                                                        40),
                                                    child: LiteRollingSwitch(
                                                      value: OnTue,
                                                      textOn: days[3],
                                                      textOff: days[3],
                                                      colorOn: mainColor,
                                                      textOffColor: Colors.white,
                                                      textOnColor: Colors.white,
                                                      colorOff: Colors.grey,
                                                      iconOff: Icons.delete,
                                                      iconOn: Icons.add,
                                                      // animationDuration: const Duration(milliseconds: 300),
                                                      onChanged: (bool state) {
                                                        setState(() {
                                                          OnTue = state;
                                                          print(
                                                              "boooooooooooooooolllllllll ");
                                                          print(OnTue);
                                                        });
                                                      },
                                                      onDoubleTap: () {},
                                                      onSwipe: () {},
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                  ItemField(
                                                      controller: Tue1,
                                                      ontap: () {
                                                        _selectTime(context, Tue1);
                                                      }),
                                                  ItemField(

                                                      controller: Tue2,
                                                      ontap: () {
                                                        _selectTime(context, Tue2);
                                                      }),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: ScreenUtil().setWidth(
                                                        90),
                                                    height: ScreenUtil().setHeight(
                                                        40),
                                                    child: LiteRollingSwitch(
                                                      value: OnWen,
                                                      textOn: days[4],
                                                      textOff: days[4],
                                                      colorOn: mainColor,
                                                      textOffColor: Colors.white,
                                                      textOnColor: Colors.white,
                                                      colorOff: Colors.grey,
                                                      iconOff: Icons.delete,
                                                      iconOn: Icons.add,
                                                      // animationDuration: const Duration(milliseconds: 300),
                                                      onChanged: (bool state) {
                                                        setState(() {
                                                          OnWen = state;
                                                          print(
                                                              "boooooooooooooooolllllllll ");
                                                          print(OnWen);
                                                        });
                                                      },
                                                      onDoubleTap: () {},
                                                      onSwipe: () {},
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                  ItemField(

                                                      controller: Wen1,
                                                      ontap: () {
                                                        _selectTime(context, Wen1);
                                                      }),
                                                  ItemField(

                                                      controller: Wen2,
                                                      ontap: () {
                                                        _selectTime(context, Wen2);
                                                      }),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: ScreenUtil().setWidth(
                                                        90),
                                                    height: ScreenUtil().setHeight(
                                                        40),
                                                    child: LiteRollingSwitch(
                                                      value: OnFri,
                                                      textOn: days[5],
                                                      textOff: days[5],
                                                      colorOn: mainColor,
                                                      textOffColor: Colors.white,
                                                      textOnColor: Colors.white,
                                                      colorOff: Colors.grey,
                                                      iconOff: Icons.delete,
                                                      iconOn: Icons.add,
                                                      // animationDuration: const Duration(milliseconds: 300),
                                                      onChanged: (bool state) {
                                                        setState(() {
                                                          OnFri = state;
                                                          print(
                                                              "boooooooooooooooolllllllll ");
                                                          print(OnFri);
                                                        });
                                                      },
                                                      onDoubleTap: () {},
                                                      onSwipe: () {},
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                  ItemField(

                                                      controller: Fri1,
                                                      ontap: () {
                                                        _selectTime(context, Fri1);
                                                      }),
                                                  ItemField(

                                                      controller: Fri2,
                                                      ontap: () {
                                                        _selectTime(context, Fri2);
                                                      }),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: ScreenUtil().setWidth(
                                                        90),
                                                    height: ScreenUtil().setHeight(
                                                        40),
                                                    child: LiteRollingSwitch(
                                                      value: OnThu,
                                                      textOn: days[6],
                                                      textOff: days[6],
                                                      colorOn: mainColor,
                                                      textOffColor: Colors.white,
                                                      textOnColor: Colors.white,
                                                      colorOff: Colors.grey,
                                                      iconOff: Icons.delete,
                                                      iconOn: Icons.add,
                                                      // animationDuration: const Duration(milliseconds: 300),
                                                      onChanged: (bool state) {
                                                        setState(() {
                                                          OnThu = state;
                                                          print(
                                                              "boooooooooooooooolllllllll ");
                                                          print(OnThu);
                                                        });
                                                      },
                                                      onDoubleTap: () {},
                                                      onSwipe: () {},
                                                      onTap: () {},
                                                    ),
                                                  ),
                                                  ItemField(

                                                    controller: Thu1,
                                                    ontap: () {
                                                      _selectTime(context, Thu1);
                                                    },
                                                  ),
                                                  ItemField(

                                                    controller: Thu2,
                                                    ontap: () {
                                                      _selectTime(context, Thu2);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: defaultbutton(
                                                  function: () {
                                                    SearchTeacherCubit.get(context).enrollmentTeacher(
                                                        id: widget.searchTeacher!.id!,
                                                        saturday: OnSat?1:0,
                                                        sunday: OnSun?1:0,
                                                        monday: OnMon?1:0,
                                                        tuesday: OnTue?1:0,
                                                        wednsday: OnWen?1:0,
                                                        thursday: OnThu?1:0,
                                                        friday: OnFri?1:0,
                                                        start_saturday: Sat1.text,
                                                        start_sunday: Sun1.text,
                                                        start_monday: Mon1.text,
                                                        start_tuesday: Tue1.text,
                                                        start_wednsday: Wen1.text,
                                                        start_thursday: Thu1.text,
                                                        start_friday: Fri1.text,
                                                        end_saturday: Sat2.text,
                                                        end_sunday: Sun2.text,
                                                        end_monday: Mon2.text,
                                                        end_tuesday: Tue2.text,
                                                        end_wednsday: Wen2.text,
                                                        end_thursday: Thu2.text,
                                                        end_friday: Fri2.text
                                                    );
                                                  },
                                                  text: 'Enroll',
                                                  //textColor: Colors.white,
                                                  width: 128.w,
                                                  height: 41.h,
                                                  fontSizeText: 18.sp,
                                                  textColor: fillColorInTextFormField,
                                                  backround: mainColor
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        );
                      },
                      text: 'Enroll',
                      //textColor: Colors.white,
                      width: 128.w,
                      height: 41.h,
                      fontSizeText: 18.sp,
                      textColor: fillColorInTextFormField,
                      backround: mainColor
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
    );
  }

  DateTime _selectedTime = DateTime.now();

  void _selectTime(BuildContext context,
      TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );

    if (pickedTime != null) {
      final int hour = pickedTime.hour;
      final int minute = pickedTime.minute;

      // Convert the pickedTime to 24-hour format
      int hour24 = hour;
      if (pickedTime.period == DayPeriod.pm && hour < 12) {
        hour24 = hour + 12;
      } else if (pickedTime.period == DayPeriod.am && hour == 12) {
        hour24 = 0;
      }

      if (hour24 >= 0 && hour24 <= 5) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Time'),
              content: Text('Please select a time after 6 AM.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        final DateTime selectedDateTime = DateTime(
          _selectedTime.year,
          _selectedTime.month,
          _selectedTime.day,
          hour24,
          minute,
        );

        setState(() {
          _selectedTime = selectedDateTime;
          controller.text = DateFormat.Hm().format(_selectedTime);
        });
      }
    }
  }
}