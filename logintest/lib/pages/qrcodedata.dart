import 'package:flutter/material.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logintest/main.dart';

class QrData extends StatelessWidget{
 

  String _barcode;
  String _email, _id, _name="", _room="";
  var _nameText = TextEditingController();
  var _roomText = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  QrData(this._barcode);

  void getEmailId(_barcode)
  {
      List<String> v=this._barcode.split('/');
      this._email=v[v.length-2];
      this._id=v[v.length-1];
  }

  void getData()
  {
      databaseReference.child('Objects/' + _email + '/' + _id).once().then((DataSnapshot snapshot){
        
        Map<dynamic, dynamic> map = snapshot.value;

        _name = map.values.toList()[2].toString();
        _room = map.values.toList()[1].toString();

        _nameText.text = "Obiect: " + _name;
        _roomText.text = "Sala: " + _room;
      });
      
  }

  Widget showData(var txt)
  {
    return TextField(
        readOnly: true,
        controller: txt,
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28, color:Colors.pink),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
    );
  }

  @override

  Widget build(BuildContext context) {
    getEmailId(this._barcode);
    getData();
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[700],
        ),
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          showData(_nameText),
          showData(_roomText),
        ],
       )
      );
  }
}