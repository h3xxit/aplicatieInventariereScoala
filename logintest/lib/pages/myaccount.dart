import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';

class MyAccountPage extends StatelessWidget with NavigationStates {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  TextEditingController emailTxt = TextEditingController();
  TextEditingController nameTxt = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();

  initUser() async {
    user = await _auth.currentUser();
    emailTxt.text = user.email;
    databaseReference
        .child('Teachers/' + user.email.replaceAll('.', ','))
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      nameTxt.text = map['Name'].toString();
    });
  }

  showAlertDialog(BuildContext context) {
        Widget cancelButton = FlatButton(
          child: Text("NU", style: new TextStyle(fontFamily: 'Montserrat'),),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        Widget continueButton = FlatButton(
          child: Text("DA", style: new TextStyle(fontFamily: 'Montserrat'),),
          onPressed: () async{
            Navigator.pop(context);
            await _auth.sendPasswordResetEmail(email: user.email);
          },
        );

        AlertDialog alert = AlertDialog(
          title: Text("Sigur?", style: new TextStyle(fontFamily: 'Montserrat'),),
          content: Text(
              "Daca sunteti sigur/a ca doriti sa va modificati parola, apasati butonul 'DA', altfel apasati pe 'NU'!",
              style: new TextStyle(fontFamily: 'Montserrat'),),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
    }

    void updateData(){
      databaseReference.child("Teachers/" + user.email.replaceAll('.', ',')).update({
        "Name": nameTxt.text
      });
    }

  @override
  Widget build(BuildContext context) {
    initUser();
    return Center(
        child: ListView(
            children: <Widget>[
          SizedBox(
            height: 100,
          ),
          CircleAvatar(
            child: Icon(
              Icons.perm_identity,
              color: Colors.white,
            ),
            radius: 50,
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            readOnly: true,
            controller: emailTxt,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.amber[900],
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding( 
            padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
            child: TextField(
            controller: nameTxt,
            style: TextStyle(
                color: Colors.deepOrange[700],
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',),
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            decoration: InputDecoration(
              labelText: 'Introduceti nume:',
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.amber[900],
                
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[700])
              ),
            ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          FlatButton(
            onPressed: () => updateData(), 
            child: Text(
              "Salvare Nume",
              style: TextStyle(
                color: Colors.deepOrange[700],
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          FlatButton(
            onPressed: () => showAlertDialog(context), 
            child: Text(
              "Schimbare Parola",
              style: TextStyle(
                color: Colors.deepOrange[700],
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ]
      ));

      
  }
}
