// ignore_for_file: unused_local_variable, duplicate_ignore, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ResizebleWidget extends StatefulWidget {
  final String? title;
  final Color? colors;
  final Color? statusBarsColors;
  final Widget child;
  final double minHeight;
  final double minWidht;
  final BuildContext buildContext;

  const ResizebleWidget({
    super.key,
    required this.buildContext,
    required this.child,
    this.colors,
    this.statusBarsColors,
    this.title,
    this.minHeight = 100,
    this.minWidht = 100,
  });

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
    if (isMaxiMize) {
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
    }
    if (height < widget.minHeight) {
      height = widget.minHeight;
    }

    if (width < widget.minWidht) {
      width = widget.minWidht;
    }
    return Stack(
      children: [
        Positioned(
          top: top,
          left: left,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: widget.colors,
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
                    decoration: BoxDecoration(
                      color: widget.statusBarsColors,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular((isMaxiMize) ? 0 : 5),
                        topRight: Radius.circular((isMaxiMize) ? 0 : 5),
                      ),
                    ),
                    padding: const EdgeInsets.all(6),
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.title ?? "Application",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              child: InkWell(
                                onTap: () {
                                  return setState(() {
                                    isMaxiMize = false;
                                    height = widget.minHeight;
                                    width = widget.minWidht;
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
