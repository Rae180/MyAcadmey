import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

Widget myTextField({
  required TextEditingController controller,
  double height = 46,
  double width = 354,
  bool obscureText = false,
  String validatorValue = "",
  String labelText = "",
  String hintText = "",
  Widget? suffixIcon,
  TextInputType? keyboardType,
  Icon? prefixIcon,
  ValueChanged<String>? onFieldSubmitted,
  Color colorfillColor=fillColorInTextFormField,
  double radios =30,
  ValueChanged<String>?onChanged

}) =>
    SizedBox(
      height: height,
      width: width,

      child: TextFormField(
        //  style: TextStyle(),
        controller: controller,
        cursorColor: mainColor,
onChanged: onChanged,
        keyboardType: keyboardType,
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) {
          if (value!.isEmpty) {
            return validatorValue;
          }
          return null;
        },
          style: TextStyle(color: Color(0xff210440)),
        obscureText: obscureText,
        decoration: InputDecoration(
            filled: true,
            fillColor: colorfillColor,
            labelText: labelText,
            labelStyle:  TextStyle(color:mainColor),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radios.r),
                borderSide: BorderSide(
                  width: 2.w,
                    color: mainColor
                )
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            suffixIconColor:mainColor,
            prefixIconColor: mainColor,
            hintText: hintText,
            hintStyle: TextStyle(color: mainColor),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: mainColor,
                width: 2.0,
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Color(0xFF210440),)
)
        )
      )
    );