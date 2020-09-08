import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logintest/sidebar/sidebar_layout.dart';
import 'package:logintest/pages/modifyobject.dart';

class QrData extends StatelessWidget{
 

  String _barcode;
  String _email, _id, _name="", _room="";
  var _nameText = TextEditingController();
  var _roomText = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  QrData(this._barcode);
  bool updated=false;
  List<Widget> children;
  int ok=1;

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
          if(map!=null)
          {
          
            _name = map["Name"];
            _room = map["Room"];
        
            _nameText.text = "Obiect: " + _name;
            _roomText.text = "Sala: " + _room;
          }
          else ok=0;
        
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
          child: Text("NU", style: new TextStyle(fontFamily: 'Montserrat'),),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        Widget continueButton = FlatButton(
          child: Text("DA", style: new TextStyle(fontFamily: 'Montserrat'),),
          onPressed: () async{
            Navigator.pop(context);
            await deleteObject();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SideBarLayout()));
          },
        );

        AlertDialog alert = AlertDialog(
          title: Text("Sigur?", style: new TextStyle(fontFamily: 'Montserrat'),),
          content: Text(
              "Daca sunteti sigur/a ca doriti sa stergeti obiectul, apasati butonul 'DA', altfel apasati pe 'NU'!",
               style: new TextStyle(fontFamily: 'Montserrat'),
              ),
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SideBarLayout()));
        return false;
      },
      child: FutureBuilder<Map<dynamic, dynamic>>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<Map<dynamic, dynamic>> snapshot) {
          
          
          

          if (snapshot.hasData) {
              if(!updated)
              {
                updateData();
                updated=true;
              }
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
          else if(ok==0)
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
          else
          {
              var contrl=TextEditingController();
              contrl.text="Obiect in curs de cautare...";
              children= <Widget>[
                  Center(
                    child: TextField(
                    readOnly: true,
                    controller: contrl,
                    maxLines: null,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.deepOrange[700],
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        fontSize: 45
                      ),
                      decoration: InputDecoration(
                      border: InputBorder.none,
                      ),
                    ),
                )
              ];
          }
          return new Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow[700],
              title: new Text("Informatii obiect", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w900, fontSize: 20, color:Colors.deepOrange[700])),
              leading: IconButton(
                icon: Icon(Icons.arrow_back,),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SideBarLayout()));
                },
              ), 
            ),
            body: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children, 
            ), 
          );
        },
          
      )// Your Scaffold goes here.
    );
  }
}