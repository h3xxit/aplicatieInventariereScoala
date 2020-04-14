import 'package:firebase_auth/firebase_auth.dart';
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

  initUser() async{
    user = await _auth.currentUser();
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
        onPressed: () async {
            await initUser();
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
