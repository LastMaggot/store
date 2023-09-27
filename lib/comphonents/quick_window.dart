import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/style/app_style.dart';

class QuickWindow extends StatefulWidget {
  double width, height;
  String msg;
  String buttonMsg;
  bool visiability = true;
  void Function()? buttonFunction;

  void changeVisiability() {
    visiability = !visiability;
  }

  QuickWindow(
      {Key? key,
      this.width = 0.5,
      this.height = 0.5,
      required this.msg,
      required this.buttonMsg,
      this.buttonFunction})
      : super(key: key);
  QuickWindowState createState() => QuickWindowState();
}

class QuickWindowState extends State<QuickWindow> {
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * widget.width;
    double height = size.height * widget.height;
    double top = (size.height - height) / 2;
    double left = (size.width - width) / 2;

    return Visibility(
      visible: widget.visiability,
      child: Stack(
        children: [
          Positioned(
            top: top,
            left: left,
            width: width,
            height: height,
            child: Container(
              color: Color.fromARGB(255, 255, 245, 238),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.8,
                    height: height * 0.5,
                    child: Text(
                      widget.msg,
                      style: AppTextStyle.tipsStyle,
                    ),
                  ),
                  Visibility(
                    visible: widget.buttonMsg != null,
                    child: InkWell(
                      onTap: () {
                        widget.buttonFunction!();
                        widget.changeVisiability();
                        setState(() {

                        });
                      },
                      child: SizedBox(
                        width: width * 0.8,
                        height: height * 0.2,
                        child: Text(widget.buttonMsg),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.changeVisiability();
                      setState(() {

                      });
                    },
                    child: SizedBox(
                      width: width * 0.8,
                      height: height * 0.2,
                      child: Text("关闭"),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
