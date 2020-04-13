import 'package:flutter/material.dart';
import 'package:logintest/pages/homepage.dart';
import 'package:logintest/sidebar/sidebar.dart';

import 'sidebar.dart';

class  SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomePage(),
          SideBar(),
        ],
      ),
    );
 }
}
  
