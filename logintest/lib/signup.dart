import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginPage extends StatefulWidget{

    @override
    State <StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Buna',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold)
                    ),
                  ),
                  Container(
                  padding: EdgeInsets.fromLTRB(30.0, 175.0, 0.0, 0.0),
                  child: Text(
                    'Ziua',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold)
                    ),
                  ),
                  Container(
                  padding: EdgeInsets.fromLTRB(190.0, 175.0, 0.0, 0.0),
                  child: Text(
                    '!',
                    style: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow[700])
                    ),
                  )   
                ]
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                  children: <Widget>[
                    TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow[700]),
                        ),
                      ),
                      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                      //onSaved: (value) => _email = value.trim(),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow[700]),
                        ),
                      ),
                      obscureText: true,
                    ),

                    SizedBox(height: 40.0),

                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.yellowAccent[700],
                        color: Colors.yellow[700],
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              'INTRA IN CONT',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),

                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
              ),

            ),  
          ],
        )
     );
  }
}
