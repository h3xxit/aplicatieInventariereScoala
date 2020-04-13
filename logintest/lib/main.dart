import 'package:flutter/material.dart';
import 'package:logintest/loginstuff/authentication.dart';
import 'package:logintest/pages/rootpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new RootPage(auth: new Auth()),
    );
  }
}

