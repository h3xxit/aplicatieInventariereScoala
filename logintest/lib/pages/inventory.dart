import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:logintest/models/text_field_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:logintest/sidebar/sidebar_layout.dart';

class InventoryPage extends StatefulWidget with NavigationStates {
  @override
  State<StatefulWidget> createState() => new _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  TextEditingController nameTxt = new TextEditingController();
  TextEditingController roomTxt = new TextEditingController();
  TextEditingController idTxt = new TextEditingController();
  TextEditingController pretTxt = new TextEditingController();
  TextEditingController dataTxt = new TextEditingController();
  TextEditingController obsTxt = new TextEditingController();
  String formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool _loading = false;

  Future<int> genereazaId() async {
    Map<dynamic, dynamic> map;
    String email;

    user = await _auth.currentUser();
    await databaseReference
        .child('Teachers/' + user.email.replaceAll('.', ','))
        .once()
        .then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> map = snapshot.value;
          email = map['SchoolEmail'].toString().replaceAll('.', ',');
        });

    await databaseReference
            .child('Objects/' + email)
            .once()
            .then((DataSnapshot snapshot) {
              map = snapshot.value;
            });

    await databaseReference
            .child('PendingForPrint/' + email)
            .once()
            .then((DataSnapshot snapshot) {
              map.addAll(snapshot.value);
            });

    /*var sortedList = map.entries.toList()
      ..sort((e1, e2) =>
          e1.value["Id"].compareTo(e2.value["Id"]));
    int length = sortedList.length;*/

    int maxId=0;
    for(var entry in map.entries) {
      int x;
      if(entry.key == "-1" || entry.value["Id"] == null)
        continue;

      try {
        x=int.parse(entry.value["Id"]);
      } catch(FormatException) {
        x=entry.value["Id"];
      }
      if(x > maxId) {
        maxId=x;
      }
    }
    int nr = maxId + 1;
    return nr;
  }

  Future<void> modificaIdObiectPrinting(String email, var key) async {
    String newId = (await genereazaId()).toString();
    await databaseReference.child('PendingForPrint/' + email + '/' + key).update({
      'Id': newId
    });
  }

  Future<int> verificaId() async {
    Map<dynamic, dynamic> map;
    String email;
    int ok=1;

    user = await _auth.currentUser();
    await databaseReference
        .child('Teachers/' + user.email.replaceAll('.', ','))
        .once()
        .then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> map = snapshot.value;
          email = map['SchoolEmail'].toString().replaceAll('.', ',');
        });

    await databaseReference
        .child('PendingForPrint/' + email)
        .once()
        .then((DataSnapshot snapshot) {
          map = snapshot.value;
        });

    for(var entry in map.entries) {
      if((entry.value["Id"]).toString() == idTxt.text) {
            Widget cancelButton = FlatButton(
              child: Text(
                "NU",
                style: new TextStyle(fontFamily: 'Montserrat'),
              ),
              onPressed: () {
                Navigator.pop(context);
                ok=0;
              },
            );
            Widget continueButton = FlatButton(
              child: Text(
                "DA",
                style: new TextStyle(fontFamily: 'Montserrat'),
              ),
              onPressed: () async {
                ok=1;
                Navigator.pop(context);
                await modificaIdObiectPrinting(email, entry.key);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SideBarLayout()));
              },
            );

            AlertDialog alert = AlertDialog(
              title: Text(
                "Sigur?",
                style: new TextStyle(fontFamily: 'Montserrat'),
              ),
              content: Text(
                "Exista un obiect neprintat cu acest Id. Daca doriti sa ii modificati Id-ul, apasati butonul 'DA', altfel apasati 'NU'",
                style: new TextStyle(fontFamily: 'Montserrat'),
              ),
              actions: [
                cancelButton,
                continueButton,
              ],
            );
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
            
            break;
      }
    }

    await databaseReference
        .child('Objects/' + email)
        .once()
        .then((DataSnapshot snapshot) {
          map = snapshot.value;
        });

    for(var entry in map.entries) {
      if((entry.value["Id"]).toString() == idTxt.text) {
        Widget cancelButton = FlatButton(
              child: Text(
                "ANULARE",
                style: new TextStyle(fontFamily: 'Montserrat'),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
            AlertDialog alert = AlertDialog(
              title: Text(
                "Eroare",
                style: new TextStyle(fontFamily: 'Montserrat'),
              ),
              content: Text(
                "Exista deja un obiect cu acest Id.",
                style: new TextStyle(fontFamily: 'Montserrat'),
              ),
              actions: [
                cancelButton,
              ],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
        
        ok=0;
        break;
      }
    }

    return ok;
  }

  Future<void> adauga() async {
    setState(() {
      _loading = true;
    });
    try {
      if (idTxt.text.isEmpty) {
        idTxt.text = (await genereazaId()).toString();
      } else {
        if(await verificaId() == 0) {
          hideLoadingBar();
          return;
        }
          
      }

      user = await _auth.currentUser();
      await databaseReference
          .child('Teachers/' + user.email.replaceAll('.', ','))
          .once()
          .then((DataSnapshot snapshot) async {
        Map<dynamic, dynamic> map = snapshot.value;
        await databaseReference
            .child('PendingForPrint/' +
                map['SchoolEmail'].toString().replaceAll('.', ','))
            .push()
            .set({
          "Name": nameTxt.text,
          "Room": roomTxt.text,
          "Id": idTxt.text,
          "Date": dataTxt.text,
          "Price": pretTxt.text,
          "Observations": obsTxt.text,
          "HasBeenChecked": false
        });
        hideLoadingBar();
      });
    } catch (Exception) {
      hideLoadingBar();
    }
  }

  void hideLoadingBar() {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    dataTxt.text = formattedDate;

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
            )),
        SizedBox(
          height: 50,
        ),
        TextField(
          controller: nameTxt,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.amber[900],
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.yellow[700])),
            labelText: 'Nume/tip',
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.deepOrange[700],
              fontFamily: 'Montserrat',
            ),
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
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.yellow[700])),
            labelText: 'Sala',
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.deepOrange[700],
              fontFamily: 'Montserrat',
            ),
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
        TextField(
          controller: idTxt,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.amber[900],
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.yellow[700])),
            labelText: 'Id',
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.deepOrange[700],
              fontFamily: 'Montserrat',
            ),
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
        TextField(
          controller: pretTxt,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.amber[900],
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.yellow[700])),
            labelText: 'Pret',
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.deepOrange[700],
              fontFamily: 'Montserrat',
            ),
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
        Theme(
          data: ThemeData(
              primarySwatch: Colors.deepOrange, splashColor: Colors.amber[900]),
          child: MyTextFieldDatePicker(
            labelText: "Data",
            prefixIcon: Icon(Icons.date_range),
            suffixIcon: Icon(Icons.arrow_drop_down),
            lastDate: DateTime.now().add(Duration(days: 366)),
            firstDate: DateTime(1900),
            initialDate: DateTime.now().add(Duration(days: 1)),
            onDateChanged: (selectedDate) {
              formattedDate = DateFormat('dd.MM.yyyy').format(selectedDate);
              dataTxt.text = formattedDate;
            },
          ),
        ),

        /*TextField(
          controller: dataTxt,
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
            labelText: 'Data',
            labelStyle: TextStyle(fontSize: 16,color: Colors.deepOrange[700],fontFamily: 'Montserrat',),
            //hintText: "Sala",
            /* prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.green,
                ),*/
          ),
        ),*/
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: obsTxt,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.amber[900],
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.yellow[700])),
            labelText: 'Observatii',
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.deepOrange[700],
              fontFamily: 'Montserrat',
            ),
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
              borderRadius: new BorderRadius.circular(30.0)),
          color: Colors.yellow[700],
          onPressed: () async {
            await adauga();
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
                  borderRadius: new BorderRadius.circular(10.0)),
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
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.deepOrange[700]),
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
          decoration: new BoxDecoration(color: Colors.white),
          child: _loading ? bodyProgress : body),
    );
  }
}
