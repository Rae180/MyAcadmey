import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Future showMessageOnScreen({
 required BuildContext context,
  required String titleText,
  required String messageText,
  Color backgroundColor=Colors.red,
  Color titleColor=Colors.yellow,
  Color messageColor=Colors.green
}){
  return   Flushbar(
  titleText: Text(titleText, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: titleColor, fontFamily:"ShadowsIntoLightTwo"),),
  messageText: Text(messageText, style: TextStyle(fontSize: 16.0, color: messageColor),),
  duration:  Duration(seconds: 3),
  backgroundColor: backgroundColor,
  margin: EdgeInsets.all(8),
  borderRadius: BorderRadius.circular(8)
  ).show(context);
}