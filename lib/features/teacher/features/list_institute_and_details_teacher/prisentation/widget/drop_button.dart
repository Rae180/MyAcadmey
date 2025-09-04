import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../util/colors.dart';



class DropListItem extends StatefulWidget {
  DropListItem({Key? key,required this.item,required this.s, this.w=449, this.h=55}) : super(key: key);
  List<String> s;
  String? item;
  int h= 55;
  int w=449;
  @override
  State<DropListItem> createState() => _DropListItemState();
}

class _DropListItemState extends State<DropListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(widget.w),
      height: ScreenUtil().setHeight(widget.h),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        elevation: 2.0,
        child: DropdownButton<String>(
          alignment: Alignment.center,
          iconEnabledColor: mainColor,
          isExpanded: true,
          value: widget.item,
          underline: Container(
            color: Colors.transparent,
          ),
          items: widget.s.map((String value) {
            return DropdownMenuItem<String>(
              alignment: Alignment.center,
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (selectedItem) {
            setState(() {
              widget.item = selectedItem;
            });
          },
        ),
      ),
    );
  }
}
