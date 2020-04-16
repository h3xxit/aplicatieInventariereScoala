import 'package:flutter/material.dart';
import 'package:logintest/loginstuff/authentication.dart';
import 'package:logintest/pages/rootpage.dart';
import 'package:logintest/pages/qrcodedata.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new QrData("https://inventarscoalaweb.herokuapp.com/#/admin@admin,com/cd0febca7f57454589d7ff21e47e410c"),
      //new RootPage(auth: new Auth()),
    );
  }
}

