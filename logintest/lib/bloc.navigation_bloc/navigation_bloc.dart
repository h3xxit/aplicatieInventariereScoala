import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logintest/pages/homepage.dart';
import 'package:logintest/pages/myaccount.dart';
import 'package:logintest/pages/inventory.dart';

enum NavigationEvents {
  HomePageClickedEvent, 
  MyAccountClickedEvent,
  InventoryClickedEvent,
}

abstract class NavigationStates{}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates>{
  @override
  NavigationStates get initialState => HomePage();

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
      }
  }

}