

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWid extends StatefulWidget {
  String txt ;
  Color color;
  FontWeight fontWeight;
  double size;


  TextWid({super.key, required this.txt,required this.color, required this.fontWeight,required this.size});

  @override
  State<TextWid> createState() => _TextWidState();
}

class _TextWidState extends State<TextWid> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.txt,style: TextStyle(color: widget.color,fontSize: widget.size.sp,fontWeight: widget.fontWeight),);
  }
}
