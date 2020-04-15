//import 'dart:html';

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logintest/bloc.navigation_bloc/navigation_bloc.dart';
//import 'package:logintest/dialogs/dialogs.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logintest/sidebar/menu_item.dart';
import 'package:logintest/pages/rootpage.dart';
import 'package:logintest/loginstuff/authentication.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> sidebarIsOpenedStreamController;
  Stream<bool> sidebarIsOpenedStream;
  StreamSink<bool> sidebarIsOpenedStreamSink;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final VoidCallback _loginCallback =FirebaseAuth.instance;
  FirebaseUser user;
  //final bool sidebarIsOpened = false;
  final _animationDuration = const Duration(milliseconds: 500);
  TextEditingController nameTxt = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  String txt = "";
  bool _isSideBarOpen = false;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    sidebarIsOpenedStreamController = PublishSubject<bool>();
    sidebarIsOpenedStream = sidebarIsOpenedStreamController.stream;
    sidebarIsOpenedStreamSink = sidebarIsOpenedStreamController.sink;
    initUser();
  }

  initUser() async{
    user = await _auth.currentUser();
    databaseReference
        .child('Teachers/' + user.email.replaceAll('.', ','))
        .once()
        .then((DataSnapshot snapshot) {
           Map<dynamic, dynamic> map = snapshot.value;
           nameTxt.text = map['Name'].toString();
           txt = map['Name'].toString();
    });
    setState(() {});
  }
  @override
  void dispose() {
    _animationController.dispose();
    sidebarIsOpenedStreamController.close();
    sidebarIsOpenedStreamSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    
    initUser();
    //FocusScope.of(context).unfocus();
    
    if (isAnimationCompleted) {
      sidebarIsOpenedStreamSink.add(false);
      _animationController.reverse();
      _isSideBarOpen = false;
    } else {
      sidebarIsOpenedStreamSink.add(true);
      _animationController.forward();
      _isSideBarOpen = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: not working(close keyboard)
    if(_animationController.status == AnimationStatus.forward)
      FocusScope.of(context).unfocus();
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: sidebarIsOpenedStream,
      builder: (context, sidebarIsOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: sidebarIsOpenedAsync.data ? 0 : -screenWidth,
          right: sidebarIsOpenedAsync.data ? 0 : screenWidth - 35,
          child: new Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.yellow[700],
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        ListTile(
                          title: TextField(
                            readOnly: true,
                            controller: nameTxt,
                            maxLines: null,
                            style: TextStyle(
                                color: Colors.deepOrange[700],
                                fontSize: 30,
                                fontWeight: FontWeight.w800),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                          ),
                          subtitle: Text(
                            "${user?.email}",
                            style: TextStyle(
                              color: Colors.amber[900],
                              fontSize: 20,
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.perm_identity,
                              color: Colors.white,
                            ),
                            radius: 40,
                          ),
                        ),
                        Divider(
                          height: 64.0,
                          thickness: 0.5,
                          color: Colors.amber[900],
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.filter_center_focus,
                          title: "Scaneaza coduri QR",
                          onTap: (){
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.format_list_bulleted,
                          title: "Inventar",
                          onTap: (){
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.InventoryClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.person,
                          title: "Contul meu",
                          onTap: (){
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAccountClickedEvent);
                          },
                        ),
                        Divider(
                          height: 64.0,
                          thickness: 0.5,
                          color: Colors.amber[900],
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.exit_to_app,
                          title: "Logout",
                          onTap: (){
                            showAlertDialog(context);
                            //onIconPressed();
                            //BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.LogOutClickedEvent);
                          },
                        ),
                      ],
                    )
                  ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35.0,
                      height: 110.0,
                      color: Colors.yellow[700],
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.amber[900],
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
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
      await _auth.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context)=> RootPage(auth: new Auth())));
      //return await _auth.signOut();
      //onIconPressed();
      // BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.LogOutClickedEvent);
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

}

class CustomMenuClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width=size.width;
    final height=size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width-1, height/2-20, width, height/2);
    path.quadraticBezierTo(width+1, height/2+20, 10, height-16);
    path.quadraticBezierTo(0, height-8, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


