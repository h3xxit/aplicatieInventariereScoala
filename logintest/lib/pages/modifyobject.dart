import 'package:flutter/material.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logintest/pages/qrcodedata.dart';

class ModifyObject extends StatelessWidget {
  @override
  String _email, _id, _name, _room, _obs;
  final databaseReference = FirebaseDatabase.instance.reference();
  final myController = TextEditingController();
  final myController1 = TextEditingController();
  final obsController = TextEditingController();
  ModifyObject(this._email, this._id, this._name, this._room, this._obs);

  Widget changeNameInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
        child: new TextField(
          controller: myController,
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          style: TextStyle(
              color: Colors.deepOrange[700],
              fontFamily: 'Montserrat',
              //fontSize: 20,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            //border: InputBorder.none,
            hintText: 'Nume vechi: ' + _name,
            hintStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.amber[900],
            ),
            labelText: 'Introduceti noul nume:',
            labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.amber[900],
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[700])),
          ),
          //print(_name);
          //onSaved: (value) => _email = value.trim(),
        ));
  }

  Widget changeRoomInput() {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
            child: new TextField(
              controller: myController1,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              style: TextStyle(
                  color: Colors.deepOrange[700],
                  fontFamily: 'Montserrat',
                  //fontSize: 20,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                //border: InputBorder.none,
                hintText: 'Locatie veche: ' + _room,
                hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[900],
                ),
                labelText: 'Introduceti noua locatie:',
                labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[900],
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow[700])),
              ),
              //onSaved: (value) => _email = value.trim(),
            )));
  }

  Future<void> updateData() async {
    databaseReference.child('Objects/' + _email + '/' + _id).update({
      'Name': (myController.text == "") ? _name : myController.text,
      'Room': (myController1.text == "") ? _room : myController1.text,
      //'Price': (priceController.text == "") ? _price : priceController.text,
      //'Date': (dateController.text == "") ? _price : priceController.text,
      'Observations': (obsController.text == "") ? _obs : obsController.text
    });
  }

  Widget showModifyButton(String text, BuildContext context) {
    return Center(
        child: Wrap(children: <Widget>[
      RaisedButton(
        elevation: 5.0,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.yellow[700],
        onPressed: () async {
          //print(_name);
          await updateData();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QrData(
                      'https://inventarscoalaweb.herokuapp.com/#/' +
                          _email +
                          '/' +
                          _id)));
        },
        child: new Text(
          text,
          style: new TextStyle(
            color: Colors.deepOrange[700],
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    ]));
  }

  Widget showObsTextField() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
        child: new TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: obsController,
          autofocus: false,
          style: TextStyle(
              color: Colors.deepOrange[700],
              fontFamily: 'Montserrat',
              //fontSize: 20,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            //border: InputBorder.none,
            hintText: 'Observatii vechi: ' + _obs,
            hintStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.amber[900],
            ),
            labelText: 'Introduceti noile observatii:',
            labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.amber[900],
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[700])),
          ),
          //print(_name);
          //onSaved: (value) => _email = value.trim(),
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: new Text(
          "Modificare obiect",
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: Colors.deepOrange[700]),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          ListView(shrinkWrap: true, children: <Widget>[
            changeNameInput(),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            changeRoomInput(),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            showObsTextField(),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            showModifyButton('Modifica', context),
          ])
        ],
      ),
    );
  }
}
