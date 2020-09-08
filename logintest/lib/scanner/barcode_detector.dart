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
  String code="";
  var txt = TextEditingController();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                controller: txt,
                decoration: new InputDecoration(
                    hintText: 'ex: 123456 ' ,
              hintStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.amber[900],
              ),
              labelText: 'Introduceti codul:',
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.amber[900],
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[700])
              ), ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: Text(
                'Anuleaza', 
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[900],
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: Text(
                'Continua',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[900],
                ),
              ),
              onPressed: () {
                //Navigator.pop(context);
                this.code="Code: " + txt.text;
                Navigator.push(context, MaterialPageRoute(builder: (context)=> QrData(code)));
              })
        ],
      ),
    );
  }

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
                SizedBox(height: MediaQuery.of(context).size.height/70),
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
              SizedBox(height: MediaQuery.of(context).size.height/1400),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    elevation: 5.0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)
                    ),
                    color: Colors.yellow[700],
                    onPressed: _showDialog,
                    child: new Text(
                      'Cauta dupa cod!',
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

