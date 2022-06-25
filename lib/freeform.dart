// ignore_for_file: unused_local_variable, duplicate_ignore

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FreeForm extends StatefulWidget {
  const FreeForm({
    Key? key,
    this.isShowStatusBar = false,
    this.isFullScreen = false,
    required this.app,
  }) : super(key: key);
  final bool isShowStatusBar;
  final bool isFullScreen;
  final Widget app;
  @override
  State<FreeForm> createState() => _FreeFormState();
}

class _FreeFormState extends State<FreeForm> {
  double x1 = 100.0;
  double x2 = 200.0;
  double y1 = 100.0;
  double y2 = 200.0;
  @override
  Widget build(BuildContext context) {
    double leftPostitioned = x2;
    double topPostitioned = y2;
    double minHeight = 0;
    double minWidth = 0;
    Widget bodyWidget = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (kDebugMode) {
              print(details.globalPosition.dx);
            }
            setState(() {
              x2 = details.localPosition.dx;
              y2 = details.localPosition.dy;
            });
          },
          child: Container(
            width: 512,
            height: 25,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              color: Colors.white,
            ),
            child: Row(
              children: const [
                Spacer(),
                Text("application debug"),
                Spacer(),
              ],
            ),
          ),
        ),
        Container(
          width: 512,
          height: 512,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
            color: Colors.white,
          ),
          child: widget.app,
        ),
      ],
    );

    if (widget.isFullScreen) {
      leftPostitioned = 0;
      topPostitioned = 0;
      minHeight = MediaQuery.of(context).size.height;
      minWidth = MediaQuery.of(context).size.width;
      bodyWidget = Container(
        width: minWidth,
        height: minHeight,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          ),
          color: Colors.white,
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          primary: false,
          body: Center(
            child: Text(
              'Hello World',
            ),
          ),
        ),
      );
    }
    return Positioned(
      left: leftPostitioned,
      top: topPostitioned,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          minHeight: minHeight,
        ),
        child: InkWell(
          onLongPress: () {
            print("oke");
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
              color: Colors.white,
            ),
            child: bodyWidget,
          ),
        ),
      ),
    );
  }
}
