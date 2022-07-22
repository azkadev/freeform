// ignore_for_file: unused_local_variable, duplicate_ignore

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
            var horicontal = details.localPosition.dx;
            if (horicontal < 0) {
              return;
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
            if (kDebugMode) {
              print("oke");
            }
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

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  late int count = 0;
  @override
  Widget build(BuildContext context) {
    return ResizebleWidget(
      child: Scaffold(
        body: Center(
          child: Text(
            "Count: ${count.toString()}",
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}

class ResizebleWidget extends StatefulWidget {
  const ResizebleWidget({Key? key, required this.child});

  final Widget child;
  @override
  _ResizebleWidgetState createState() => _ResizebleWidgetState();
}

const ballDiameter = 10.0;

class _ResizebleWidgetState extends State<ResizebleWidget> {
  late double height = 400;
  late double width = 200;

  late double heightBackup = 0;
  late double widthBackup = 0;
  late bool isMaxiMize = false;
  late double top = 0;
  late double left = 0;
  late double topBackup = 0;
  late double leftBackup = 0;

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
          Positioned(
            top: top,
            left: left,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.red[200],
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cManipulatingBall(
                    child: Container(
                      height: 35,
                      width: width,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Row(
                        children: [
                          const Spacer(),
                          const Text(
                            "Application",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: InkWell(
                              onTap: () {
                                return setState(() {
                                  isMaxiMize = false;
                                  height = 0;
                                  width = 0;
                                });
                              },
                              child: const Icon(
                                Icons.minimize,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: InkWell(
                              onTap: () {
                                var getFullheight = MediaQuery.of(context).size.height;
                                var getFullWidth = MediaQuery.of(context).size.width;
                                if (getFullheight == height && getFullWidth == width) {
                                  return setState(() {
                                    isMaxiMize = false;
                                    top = topBackup;
                                    left = leftBackup;
                                    height = heightBackup;
                                    width = widthBackup;
                                  });
                                }
                                setState(() {
                                  isMaxiMize = true;
                                  topBackup = top;
                                  leftBackup = left;
                                  top = 0;
                                  left = 0;
                                  heightBackup = height;
                                  widthBackup = width;
                                  height = MediaQuery.of(context).size.height;
                                  width = MediaQuery.of(context).size.width;
                                });
                              },
                              child: const Icon(
                                Icons.maximize,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: InkWell(
                              onTap: () {
                                if (kDebugMode) {
                                  print("oke");
                                }
                              },
                              child: const Icon(
                                Icons.close,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onDrag: (dx, dy) {
                      setState(() {
                        top = top + dy;
                        left = left + dx;
                      });
                    },
                  ),
                  Expanded(child: widget.child)
                ],
              ),
            ),
          ),
          // top left
          Positioned(
            top: top - ballDiameter / 2,
            left: left - ballDiameter / 2,
            child: ManipulatingBall(
              cursor: SystemMouseCursors.resizeDownRight,
              onDrag: (dx, dy) {
                var mid = (dx + dy) / 2;
                var newHeight = height - 2 * mid;
                var newWidth = width - 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  top = top + mid;
                  left = left + mid;
                });
              },
            ),
          ),
          // top middle
          Positioned(
            top: top - ballDiameter / 2,
            left: left + width / 2 - width / 2,
            child: ManipulatingBall(
              cursor: SystemMouseCursors.resizeDown,
              width: width,
              onDrag: (dx, dy) {
                var newHeight = height - dy;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  top = top + dy;
                });
              },
            ),
          ),
          // top right
          Positioned(
            top: top - ballDiameter / 2,
            left: left + width - ballDiameter / 2,
            child: ManipulatingBall(
              cursor: SystemMouseCursors.resizeDownLeft,
              onDrag: (dx, dy) {
                var mid = (dx + (dy * -1)) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
              },
            ),
          ),
          // center right
          Positioned(
            top: top + height / 2 - height / 2,
            left: left + width - ballDiameter / 2,
            child: ManipulatingBall(
              cursor: SystemMouseCursors.resizeLeft,
              height: height,
              onDrag: (dx, dy) {
                var newWidth = width + dx;

                setState(() {
                  width = newWidth > 0 ? newWidth : 0;
                });
              },
            ),
          ),
          // bottom right
          Positioned(
            top: top + height - ballDiameter / 2,
            left: left + width - ballDiameter / 2,
            child: ManipulatingBall(
              cursor: SystemMouseCursors.resizeUpLeft,
              onDrag: (dx, dy) {
                var mid = (dx + dy) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
              },
            ),
          ),
          // bottom center
          Positioned(
            top: top + height - ballDiameter / 2,
            left: left + width / 2 - width / 2,
            child: ManipulatingBall(
              cursor: SystemMouseCursors.resizeUp,
              width: width,
              onDrag: (dx, dy) {
                var newHeight = height + dy;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                });
              },
            ),
          ),
          // bottom left
          Positioned(
            top: top + height - ballDiameter / 2,
            left: left - ballDiameter / 2,
            child: ManipulatingBall(
              cursor: SystemMouseCursors.resizeUpRight,
              onDrag: (dx, dy) {
                var mid = ((dx * -1) + dy) / 2;

                var newHeight = height + 2 * mid;
                var newWidth = width + 2 * mid;

                setState(() {
                  height = newHeight > 0 ? newHeight : 0;
                  width = newWidth > 0 ? newWidth : 0;
                  top = top - mid;
                  left = left - mid;
                });
              },
            ),
          ),
          //left center
          Positioned(
            top: top + height / 2 - height / 2,
            left: left - ballDiameter / 2,
            child: ManipulatingBall(
              cursor: SystemMouseCursors.resizeRight,
              height: height,
              onDrag: (dx, dy) {
                var newWidth = width - dx;

                setState(() {
                  width = newWidth > 0 ? newWidth : 0;
                  left = left + dx;
                });
              },
            ),
          ),
        ],
      
    );
  }
}

class ManipulatingBall extends StatefulWidget {
  const ManipulatingBall({
    Key? key,
    required this.onDrag,
    required this.cursor,
    this.height,
    this.width,
  });

  final Function onDrag;
  final MouseCursor cursor;
  final double? height;
  final double? width;

  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}

class _ManipulatingBallState extends State<ManipulatingBall> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: MouseRegion(
        cursor: widget.cursor,
        child: Container(
          width: widget.width ?? ballDiameter,
          height: widget.height ?? ballDiameter,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class cManipulatingBall extends StatefulWidget {
  const cManipulatingBall({Key? key, required this.onDrag, required this.child});
  final Widget child;
  final Function onDrag;

  @override
  cManipulatingBallState createState() => cManipulatingBallState();
}

class cManipulatingBallState extends State<cManipulatingBall> {
  late double initX;
  late double initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }

  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onPanStart: _handleDrag, onPanUpdate: _handleUpdate, child: widget.child);
  }
}
