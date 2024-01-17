import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSpacer extends StatefulWidget {
  double value;
  bool height;


  CustomSpacer({super.key, required this.value, required this.height});

  @override
  State<CustomSpacer> createState() => _CustomSpacerState();
}

class _CustomSpacerState extends State<CustomSpacer> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height:widget.height?widget.value.h:0,
      width:widget.height?0:widget.value.w,
    );
  }
}
