import 'package:flutter/material.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';

class MyAccountPage extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Contul Meu",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}