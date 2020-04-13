import 'package:flutter/material.dart';
import 'package:logintest/sidebar/sidebar.dart';

showAlertDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text("NU"),
    onPressed: () {},
  );
  Widget continueButton = FlatButton(
    child: Text("DA"),
    onPressed: () {
      //onIconPressed();
       //BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.LogOutClickedEvent);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Sigur?"),
    content: Text(
        "Daca sunteti sigur/a ca doriti sa iesiti din cont, apasati butonul 'DA', altfel apasati pe 'NU'!"),
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
