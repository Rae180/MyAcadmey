/*import 'package:flutter/material.dart';
import 'package:languages_project/modules/splash/components/body.dart';
class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
*/
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/colors.dart';
import '../onboarding/on_boarding_screen.dart';



class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({Key ? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> ? topCircleAnimation;
  Animation<double> ? bottomCircleAnimation;
  Animation<double> ? logoAnimation;
  AnimationController ? controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration:Duration(seconds: 3), vsync: this);
    topCircleAnimation = Tween<double>(begin: 0, end: 200).animate(controller!)
      ..addListener(() {
        setState(() {

        });
      });

    bottomCircleAnimation =
    Tween<double>(begin: 0, end: 350).animate(controller!)
      ..addListener(() {
        setState(() {

        });
      });

    logoAnimation = Tween<double>(begin: 0, end: 1).animate(controller!)
      ..addListener(() {
        setState(() {

        });
      });
    controller!.forward();

    Timer(Duration(seconds:3), () {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (BuildContext context) =>SharedPref.getData(key:'token')==null? SignInScreen():HomeScreen(getAllProductsModel: []),),
      // );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) =>OnBoardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Opacity(
                opacity: logoAnimation!.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/LangHub.png',fit: BoxFit.fill,height: 100.h,width: 160.w,),
                    SizedBox(height: 20),
                    Text("LangHub",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize:24.sp ),)
                  ],
                ),
              ),
            ),
          )
          ,


        ],
      ),
    );
  }
}