import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/style/app_style.dart';
import 'package:flutter/material.dart';

class OverlayWindow extends StatelessWidget {
  OverlayEntry? overlayEntry;

  dynamic showConfirmationAlertDialog(BuildContext context,
      {
        required String title,
        required String content,
        String? buttonMsg,
        void Function()? buttonFunction}) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            buttonMsg!=null?MaterialButton(
              color: Colors.teal,
              child: Text(
                buttonMsg!,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if(buttonFunction == null) {
                  Fluttertoast.showToast(msg: "buttonFunction无效");
                  Navigator.pop(context);
                }
                else {
                  buttonFunction!.call();

                }
              },
            ):Container(),
            MaterialButton(
              color: Colors.red,
              child: const Text(
                '取消',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void buildQuickTips(
      {required BuildContext context,
      double pWidth = 0.5,
      double pHeight = 0.5,
      required String msg,
      String? buttonMsg,
      void Function()? buttonFunction}) {
    overlayEntry = new OverlayEntry(builder: (context) {
      Size size = MediaQuery.of(context).size;
      double width = size.width * pWidth;
      double height = size.height * pHeight / 2;
      double top = (size.height - height) / 2;
      double left = (size.width - width) / 2;
      return Stack(
        children: [
          Positioned(
            top: top,
            left: left,
            width: width,
            height: height,
            child: Material(
              color: Color.fromARGB(150, 255, 255, 255),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.8,
                    height: height * 0.5,
                    child: Text(
                      msg,
                      style: AppTextStyle.tipsStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  buttonMsg != null
                      ? InkWell(
                          onTap: () {
                            buttonFunction!();
                          },
                          child: SizedBox(
                            width: width * 0.8,
                            height: height * 0.2,
                            child: Text(
                              buttonMsg,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(),
                  InkWell(
                    onTap: () {
                      this.close(context: context);
                    },
                    child: SizedBox(
                      width: width * 0.8,
                      height: height * 0.2,
                      child: Text(
                        "关闭",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    });
  }

  void show({required BuildContext context}) {
    Overlay.of(context).insert(overlayEntry!);
  }

  void close({required BuildContext context}) {
    overlayEntry!.remove();
  }

  @override
  build(BuildContext context) {
    return Container();
  }
}
