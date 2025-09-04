import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../util/colors.dart';


Widget CheckBoxLanguage ({
  required String language,
  required bool valueCheckBox,

}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(language,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
    Checkbox(value: valueCheckBox, onChanged:(value){},hoverColor:mainColor ,focusColor: mainColor,),
  ]
  );
}

Widget LanguageInDetailsInstitute({
  required bool english,
  required bool french,
  required bool spanish,
  required bool germany,
}){
  return  Container(height:260.h ,width: 290.w,
      decoration: BoxDecoration(
          color: fillColorInTextFormField,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: borderContainer,
          )
      ),
      child:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("the courses are :",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
            CheckBoxLanguage(language: 'English', valueCheckBox: english),
            CheckBoxLanguage(language: 'French', valueCheckBox: french),
            CheckBoxLanguage(language: 'Spanish', valueCheckBox: spanish),
            CheckBoxLanguage(language: 'germany', valueCheckBox: germany),

          ],),
      )
  );
}