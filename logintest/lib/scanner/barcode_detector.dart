import 'dart:async';

import 'package:logintest/pages/qrcodedata.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';

class ScanScreen extends StatefulWidget with NavigationStates{
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      }, 
      child: Scaffold(
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /*Icon(
                  Icons.filter_center_focus,
                  size: 150.0,
                  color: Colors.deepOrange[700],
                )*/
                Image.asset(
                'assets/varianta_rotunda.png',
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.height/4,
                //fit: BoxFit.scaleDown,
                ),
                SizedBox(height: MediaQuery.of(context).size.height/30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    elevation: 5.0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)
                    ),
                    color: Colors.yellow[700],
                    onPressed: scan,
                    child: new Text(
                      'Scaneaza cod QR!',
                    style: new TextStyle(
                      color: Colors.deepOrange[700],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }

  

  Future scan() async {
    try {
      String barcode = await scanner.scan();
      setState(() => this.barcode = barcode);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> QrData(barcode)));
    } on PlatformException catch (e) {
      if (e.code == scanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}