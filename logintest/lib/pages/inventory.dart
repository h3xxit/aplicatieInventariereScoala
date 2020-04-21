import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';

class InventoryPage extends StatefulWidget with NavigationStates{

    @override
    State <StatefulWidget> createState() => new _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage>  {
  TextEditingController nameTxt = new TextEditingController();
  TextEditingController roomTxt = new TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
   bool _loading = false;
  void adauga() async{
    setState(() {
          
        _loading = true;
    });
    try{
        user = await _auth.currentUser();
        databaseReference
            .child('Teachers/' + user.email.replaceAll('.', ','))
            .once()
            .then((DataSnapshot snapshot) async {
            Map<dynamic, dynamic> map = snapshot.value;
            await databaseReference
            .child('PendingForPrint/' + map['SchoolEmail'].toString().replaceAll('.', ','))
            .push().set({"Name" : nameTxt.text, "Room" : roomTxt.text, "HasBeenChecked" : false});
            hideLoadingBar();
          });
    }
    catch (Exception){
        hideLoadingBar();
    }

  }

  void hideLoadingBar()
  {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

   
     
    var body = Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(children: <Widget>[
        SizedBox(
          height: 90,
        ),
        FittedBox( 
          fit: BoxFit.fitWidth,
          child: Text(
          "Adauga un nou obiect",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.deepOrange[700],
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
            ),
          )
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
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.yellow[700])),
            labelText: 'Nume/tip',
            labelStyle: TextStyle(fontSize: 16,color: Colors.deepOrange[700],fontFamily: 'Montserrat',),
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
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.yellow[700])),
            labelText: 'Sala',
            labelStyle: TextStyle(fontSize: 16,color: Colors.deepOrange[700],fontFamily: 'Montserrat',),
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
                onPressed: adauga,
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
    var bodyProgress = new Container(
            child: new Stack(
              children: <Widget>[
                body,
                new Container(
                  alignment: AlignmentDirectional.center,
                  decoration: new BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: new BorderRadius.circular(10.0)
                    ),
                    width: 300.0,
                    height: 200.0,
                    alignment: AlignmentDirectional.center,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Center(
                          child: new SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: new CircularProgressIndicator(
                              value: null,
                              strokeWidth: 7.0,
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange[700]),
                            ),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(top: 25.0),
                          child: new Center(
                            child: new Text(
                              "loading.. wait...",
                              style: new TextStyle(
                                color: Colors.deepOrange[700],
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
          return new Scaffold( 
            body: new Container(
              decoration: new BoxDecoration(
                color: Colors.white
              ),
              child: _loading ? bodyProgress : body
            ),
          );
  }
}

