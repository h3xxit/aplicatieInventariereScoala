import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';
/*
class  MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> with NavigationStates{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  initUser() async{
    user = await _auth.currentUser();
  }
  @override
  void initState() {
     super.initState();
     initUser();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
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
        Text(
          "mailymail",
          style: TextStyle(
              color: Colors.amber[900],
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
         SizedBox(
        height: 30,
      ),
        Text(
          "Ana Maria Pintiliciuc",
          style: TextStyle(
              color: Colors.deepOrange[700],
              fontSize: 30,
              fontWeight: FontWeight.w800),
        ),

        SizedBox(
        height: 60,
      ),
      FlatButton(
        onPressed: (){
            _auth.sendPasswordResetEmail(email:user.email);
        },
        child: Text(
          "Schimbare Parola", 
          style: TextStyle(
            color: Colors.deepOrange[700],
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
     
    ]
            //child: Text(
            // "Contul Meu",
            //style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
            ));
  }
}
*/

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
          child: Text("NU"),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        Widget continueButton = FlatButton(
          child: Text("DA"),
          onPressed: () async{
            Navigator.pop(context);
            await _auth.sendPasswordResetEmail(email: user.email);
            //Navigator.push(context, MaterialPageRoute(builder: (context)=> SideBarLayout()));
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
      databaseReference.child("Teachers/" + user.email.replaceAll('.', ',')).update({
        "Name": nameTxt.text
      });
    }

  @override
  Widget build(BuildContext context) {
    initUser();
    return Center(
        child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.center,
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
                fontWeight: FontWeight.w500),
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
            /*onEditingComplete: () {
              databaseReference
                  .child("Teachers/" + user.email.replaceAll('.', ','))
                  .update({"Name": nameTxt.text});
            },*/
            controller: nameTxt,
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            decoration: InputDecoration(
              //border: InputBorder.none,
              //hintText: 'Nume vechi: ' + _name,
              labelText: 'Introduceti nume:',
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow[700])
              ),
            ),
            /*decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(
                 color: Colors.amber[900], 
                
                // width: 5.0
                ),            
              ),
                /*enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: 
                  Colors.yellow[700], 
                  //width: 5.0
                ),*/
              ),
         ),
       /* decoration: InputDecoration(
          border:  color: Colors.amber[900],
                          indent: 32,
                          endIndent: 32,
        ),*/*/
            ),
          ),
          /*Divider(
            height: 64.0,
            thickness: 0.5,
            color: Colors.amber[900],
            indent: 32,
            endIndent: 32,
          ),*/
          SizedBox(
            height: 70,
          ),
          FlatButton(
            onPressed: () => showAlertDialog(context), 
            child: Text(
              "Schimbare Parola",
              style: TextStyle(
                color: Colors.deepOrange[700],
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          /*SizedBox(
            height: 25,
          ),*/
          FlatButton(
            onPressed: () => updateData(), 
            child: Text(
              "Salvare Nume",
              style: TextStyle(
                color: Colors.deepOrange[700],
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          /*ListTile(

        title: Text(
          "Ana Maria Pintiliciuc",
          style: TextStyle(
              color: Colors.deepOrange[700],
              fontSize: 30,
              fontWeight: FontWeight.w800),
        ),
        leading: CircleAvatar(
          child: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
          radius: 40,
        ),
      ),*/
        ]
            //child: Text(
            // "Contul Meu",
            //style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
            ));

      
  }
}
