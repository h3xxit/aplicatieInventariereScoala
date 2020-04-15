import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logintest/pages/homepage.dart';
import 'package:logintest/pages/rootpage.dart';
import 'package:logintest/pages/myaccount.dart';
import 'package:logintest/pages/inventory.dart';
import 'package:logintest/loginstuff/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum NavigationEvents {
  HomePageClickedEvent, 
  MyAccountClickedEvent,
  InventoryClickedEvent,
  LogOutClickedEvent,
}

abstract class NavigationStates{}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates>{
  @override
  NavigationStates get initialState => HomePage();
  BaseAuth auth;
  @override
  Stream <NavigationStates> mapEventToState(NavigationEvents event) async*{
      switch(event){
        case NavigationEvents.HomePageClickedEvent: 
          yield HomePage();
          break;
        case NavigationEvents.MyAccountClickedEvent: 
          yield MyAccountPage();
          break;
        case NavigationEvents.InventoryClickedEvent: 
          yield InventoryPage();
          break;
        case NavigationEvents.LogOutClickedEvent: 
          //showAlertDialog(context);
          //await FirebaseAuth.instance.signOut();
          //FirebaseUser user = FirebaseAuth.instance.currentUser;
          runApp(
            new MaterialApp(
              home: new RootPage(auth: new Auth()),
            )
          );
          //yield _RootPageState();
          break;
      }
  }

}