import 'package:flutter/material.dart';

class RoundedRectangle extends StatelessWidget {

  double? width,height,borderWidth;
  Color? borderColor,backgroundColor;
  Alignment? alignment;
  Widget? child;

  RoundedRectangle({Key?key, this.width,this.height,this.borderWidth,this.borderColor,this.backgroundColor,this.alignment,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment??Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: borderWidth??1.0,
          color: borderColor??Colors.black,
        ),
      ),
      child: child,
    );
  }
}