import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:store/style/app_style.dart';
import 'package:flutter/material.dart';

class OverlayWindow extends StatelessWidget {
  OverlayEntry? overlayEntry;

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
      double height = size.height * pHeight;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.8,
                    height: height * 0.5,
                    child: Text(
                      msg,
                      style: AppTextStyle.tipsStyle,
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
                            child: Text(buttonMsg),
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
                      child: Text("关闭"),
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
