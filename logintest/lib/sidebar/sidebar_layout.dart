import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:logintest/pages/homepage.dart';
import 'package:logintest/sidebar/sidebar.dart';

//import 'sidebar.dart';

class  SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocProvider <NavigationBloc> (
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(),
          ],
        ),
      ),
    );
   }
}
  
