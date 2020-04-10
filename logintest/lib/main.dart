import 'package:flutter/material.dart';
import 'signup.dart';
//import 'package:logintest/pages/homepage.dart';
import 'package:logintest/sidebar/sidebar_layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, 
          primaryColor: Colors.white
      ),
      home: SideBarLayout(),
      //home: LoginPage(),
    );
  }
}