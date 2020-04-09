import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.yellow[700],
            ),
          ),
          Align(
            alignment: Alignment(0, -0.9),
            child: Container(
              width: 35.0,
              height: 110.0,
              color: Colors.yellow[700],
            ),
          )
        ],
       ),
    );
  }
}
