import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start/features/util/colors.dart';

Widget ShowMoreShowLess({required String? text}) {
  return Container(
    margin: const EdgeInsets.only(left: 10, top: 0.0, right: 10.0, bottom: 0.0),
// padding: const EdgeInsets.all(3.0),
    child: DescriptionTextWidget(
      text: text,
    ),
    decoration: BoxDecoration(
        color: fillColorInTextFormField,
        border: Border.all(color: borderContainer),
        borderRadius: new BorderRadius.circular(10.0)),
  );
}

class DescriptionTextWidget extends StatefulWidget {
  final String ?text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text!.length > 200) {
      firstHalf = widget.text!.substring(0, 200);
      secondHalf = widget.text!.substring(200, widget.text!.length);
    } else {
      firstHalf = widget.text!;
      secondHalf = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290.w,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
              style: TextStyle(color: mainColor,fontSize: 16.sp,fontWeight: FontWeight.bold),
            )
          : Column(
              children: <Widget>[
                Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                    style: TextStyle(color: mainColor,fontSize: 16.sp,fontWeight: FontWeight.bold)),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "show more" : "show less",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
