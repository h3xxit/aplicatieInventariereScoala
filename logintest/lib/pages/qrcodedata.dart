import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logintest/pages/homepage.dart';
import 'package:logintest/pages/modifyobject.dart';

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

  Future<Map<dynamic, dynamic>> getData () async
  {
      Map<dynamic, dynamic> map;
      await databaseReference.child('Objects/' + _email + '/' + _id).once().then((DataSnapshot snapshot){
        
        map = snapshot.value;

        _name = map["Name"];
        _room = map["Room"];
        
        _nameText.text = "Obiect: " + _name;
        _roomText.text = "Sala: " + _room;
      });
      
      return map;
  }

  Widget showData(var txt)
  {
    return TextField(
        readOnly: true,
        controller: txt,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w900, fontSize: 28, color:Colors.deepOrange[700]),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
    );
  }

  Widget showIcon()
  {
      return Icon(
        Icons.filter_center_focus,
        size: 150.0,
        color: Colors.deepOrange[700],
      );
  }
  
  Widget showDeleteButton(String text, BuildContext context)
  {
      return Center(
        child: Wrap( 
          children: <Widget>[ 
              RaisedButton(
                elevation: 5.0,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)
                ),
                color: Colors.yellow[700],
                onPressed: () => showAlertDialog(context),
                child: new Text(
                  text,
                style: new TextStyle(
                  color: Colors.deepOrange[700],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ]
        )
      );
  }

  Widget showModifyButton(String text, BuildContext context)
  {
      return Center(
        child: Wrap( 
          children: <Widget>[ 
              RaisedButton(
                elevation: 5.0,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)
                ),
                color: Colors.yellow[700],
                onPressed: ()
                {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ModifyObject(_email, _id, _name, _room)));
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
          ]
        )
      );
  }

  Future<void> deleteObject() async
  {
      databaseReference.child('Objects/' + _email + '/' + _id).remove();
  }

  showAlertDialog(BuildContext context) {
        Widget cancelButton = FlatButton(
          child: Text("NU"),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        Widget continueButton = FlatButton(
          child: Text("DA"),
          onPressed: () async{
            Navigator.pop(context);
            await deleteObject();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
          },
        );

        AlertDialog alert = AlertDialog(
          title: Text("Sigur?"),
          content: Text(
              "Daca sunteti sigur/a ca doriti sa stergeti obiectul, apasati butonul 'DA', altfel apasati pe 'NU'!"),
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
    databaseReference.child('Objects/' + _email + '/' + _id).update({
        "HasBeenChecked": true,
    });
  }

  @override

  Widget build(BuildContext context){
    getEmailId(this._barcode);

    return FutureBuilder<Map<dynamic, dynamic>>(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
                    
                    List<Widget> children;
                    
                    if (snapshot.hasData) {
                        updateData();
                        children = <Widget>[
                          showIcon(),
                          SizedBox(height: MediaQuery.of(context).size.height/50),
                          showData(_nameText),
                          showData(_roomText),
                          SizedBox(height: MediaQuery.of(context).size.height/50),
                          showDeleteButton('Stergeti obiectul', context),
                          SizedBox(height: MediaQuery.of(context).size.height/100),
                          showModifyButton('Modificati obiectul', context),
                        ];
                    }
                    else
                    {
                        children= <Widget>[
                          Center(
                            child: Text(
                            'Obiect negasit',
                            style: new TextStyle(
                                color: Colors.deepOrange[700],
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                fontSize: 45
                              ),
                            )
                          )
                        ];
                    }
                    return new Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.yellow[700],
                        title: new Text("Informatii obiect", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w900, fontSize: 20, color:Colors.deepOrange[700])),
                        
                      ),
                      body: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: children, 
                      ), 
                    );
                  },
              
          );

    
  }
}