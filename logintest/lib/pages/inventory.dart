import 'package:flutter/material.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';

class InventoryPage extends StatelessWidget with NavigationStates {
  TextEditingController nameTxt = new TextEditingController();
  TextEditingController roomTxt = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: <Widget>[
        SizedBox(
          height: 90,
        ),
        Text(
          "Adauga un nou obiect",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.deepOrange[700],
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 100,
        ),
        TextField(
          controller: nameTxt,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.amber[900],
              fontSize: 20,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.yellow[700])),
            labelText: 'Nume/tip',
            labelStyle: TextStyle(fontSize: 16,color: Colors.deepOrange[700]),
            //hintText: "Nume/tip",
            /* prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.green,
                ),*/
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: roomTxt,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.amber[900],
              fontSize: 20,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.yellow[700])),
            labelText: 'Sala',
            labelStyle: TextStyle(fontSize: 16,color: Colors.deepOrange[700]),
            //hintText: "Sala",
            /* prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.green,
                ),*/
          ),
        ),
        SizedBox(
          height: 30,
        ),
        RaisedButton(
                elevation: 5.0,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)
                ),
                color: Colors.yellow[700],
                onPressed: (){
                  
                },
                child: new Text(
                  'Adauga obiectul',
                style: new TextStyle(
                  color: Colors.deepOrange[700],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
      ]),
    ));
  }
}

