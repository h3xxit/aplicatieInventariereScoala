/*import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:logintest/scanner/barcode_detector.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new RaisedButton(
          onPressed: (){

                ImagePicker.pickImage(source: ImageSource.camera).then((photo){
                BarcodeDetector detector = 
                        FirebaseVision.instance.barcodeDetector(
                          BarcodeDetectorOptions(
                              barcodeFormats: BarcodeFormat.qrCode
                          )
                        );
                detector
                      .detectInImage(FirebaseVisionImage.fromFile(photo))
                      .then((barcodes) {
                        if(barcodes.length>0)
                        {
                          var barcode = barcodes[0];
 
                          showDialog(context: context, builder: (context) {
                            return new AlertDialog(
                              title: new Text("QR Code Contents"),
                              content: new Text(barcode.rawValue),
                              actions: <Widget>[new FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: new Text("OK")
                              )],
                            );
                          });
                        }
                        //else return new AlertDialog(title: new Text("nop"),);
                      });
              });
          },
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)
          ),
          color: Colors.yellow[700],
          child: new Text(
              'Scaneaza cod QR!!',
              style: new TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
        ),
      )
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:logintest/scanner/barcode_detector.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('QR Code Scanner & Generator'),
        ),
        body: Center(
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          splashColor: Colors.blueGrey,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScanScreen()),
                            );
                          },
                          child: const Text('SCAN QR CODE')
                      ),
                    ),
                ],
              )
          ),
        );
  }
}