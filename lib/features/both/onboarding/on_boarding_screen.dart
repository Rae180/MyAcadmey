import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:start/features/Student/featuers/signup/prisentation/siginup.dart';
import 'package:start/features/teacher/features/signupTeacher/prisentation/siginup.dart';

// import '../../Student/featuers/signup/prisentation/siginup.dart';
// import '../../teacher/features/signupTeacher/prisentation/siginup.dart';
import '../../util/colors.dart';
import '../../util/defaultbutton.dart';
import '../splash/spalsh_screen.dart';

class BoarderModel
{
  final String image;
  final String title;
  final String body;
  BoarderModel({
    required this.image,
    required this.title,
    required this.body,
});
}


class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController=PageController();

  List<BoarderModel> boarding=[
     BoarderModel(
      image: 'assets/images/start1.jpg',
      title: 'Welcome to our Courses Management System! ',
      body: 'Our software is designed to help you manage your Instructor-Led Training and virtual Instructor-Led Training (ILT/vILT) courses with ease.',
    ),
    BoarderModel(
      image: 'assets/images/start2.jpg',
      title: 'We\'re thrilled to have you join our team!',
      body: ' Our Courses Management System software is designed to help you manage your courses and optimize your training programs.',
    ),
    BoarderModel(
      image: 'assets/images/start3.jpg',
      title: 'Congratulations on joining our training organization!',
      body: 'Our Courses Management System software is here to help you manage your courses and streamline your workflows.',
    ),
  ];
  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   actions: [
      //     TextButton(onPressed: (){
      //       Navigator.pushAndRemoveUntil(
      //           context,
      //           MaterialPageRoute(
      //           builder: (context) =>  Login()),
      //       (route)=>false);
      //     }, child: Text('SKIP',style: TextStyle(color: Colors.deepOrange),))
      //   ],
      // ),
  body:Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: boardController,
            onPageChanged: (int index){
              if(index==boarding.length-1){
                setState(() {
                  isLast=true;
                  ind=2;
                });
              }else{
                setState(() {
                  isLast=false;
                  ind =0;
                });
              }
            },
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildBoarderItem(boarding[index]),
            itemCount: boarding.length,

          ),
        ),
        SizedBox(height: 15.h,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           SmoothPageIndicator(
               controller: boardController,
               effect: ExpandingDotsEffect(
                 dotColor: Colors.grey,
                 activeDotColor: mainColor,
                 dotHeight: 10,
                 expansionFactor: 4,
                 dotWidth: 10,
                 spacing: 5.0
               ),
               count: boarding.length),
          //  Spacer(),
            SizedBox(height: 30.h,),



          ],
        ),
      ],
    ),
  )
    );
  }

  Widget buildBoarderItem(BoarderModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // const SizedBox(height: 20.0,),

      Image(image: AssetImage('${model.image}')),
     // const SizedBox(height: 20.0,),
      Text(
        '${model.title}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.sp,
          color: Colors.indigo
        ),
      ),
       SizedBox(height: 30.h,),
       Text(
        '${model.body}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
          color: mainColor
        ),
      ),
      SizedBox(height: 30.h,),
      Center(
          child: ind==2  ?  Row(
            children: [
              defaultbutton(backround: mainColor, text: 'Student', function: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) =>SignUpScreenStudent(),),
                );

              },width: 150.w,textColor: fillColorInTextFormField),
              SizedBox( width: 20.w,),
              defaultbutton(backround: mainColor, text: 'Teacher', function: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) =>SignUpScreenTeacher(),),
                );
              },width: 150.w,textColor: fillColorInTextFormField)
            ],
          ) :  Container()
      )
    ],
  );
  int ind=1;
}
