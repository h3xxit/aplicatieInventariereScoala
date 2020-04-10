//import 'dart:html';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> sidebarIsOpenedStreamController;
  Stream<bool> sidebarIsOpenedStream;
  StreamSink<bool> sidebarIsOpenedStreamSink;
  //final bool sidebarIsOpened = false;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    sidebarIsOpenedStreamController = PublishSubject<bool>();
    sidebarIsOpenedStream = sidebarIsOpenedStreamController.stream;
    sidebarIsOpenedStreamSink = sidebarIsOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    sidebarIsOpenedStreamController.close();
    sidebarIsOpenedStreamSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      sidebarIsOpenedStreamSink.add(false);
      _animationController.reverse();
    } else {
      sidebarIsOpenedStreamSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: sidebarIsOpenedStream,
      builder: (context, sidebarIsOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: sidebarIsOpenedAsync.data ? 0 : 0,
          right: sidebarIsOpenedAsync.data ? 0 : screenWidth - 35,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.yellow[700],
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: Container(
                    width: 35.0,
                    height: 110.0,
                    color: Colors.yellow[700],
                    alignment: Alignment.centerLeft,
                    child: AnimatedIcon(
                      progress: _animationController.view,
                      icon: AnimatedIcons.menu_close,
                      color: Colors.amber[900],
                      size: 25,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
