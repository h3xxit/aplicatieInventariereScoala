import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logintest/loginstuff/authentication.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget{

    LoginPage({this.auth, this.loginCallback});

    final BaseAuth auth;
    final VoidCallback loginCallback;

    @override
    State <StatefulWidget> createState() => new _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {

  bool _isLoading=false;
  String _email, _password, _errorMessage="";
  final _formKey = new GlobalKey<FormState>();

   bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
      
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        Toast.show("Email/Parola incorecte!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  Widget showCircularProgress(){
    if(_isLoading){
      return Center(child: new CircularProgressIndicator(
                              value: null,
                              strokeWidth: 7.0,
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange[700]),
                            ),
                          );
    }
    return Container(
        height: 0.0,
        width: 0.0,
    );
  }

  Widget showText(String word, double a, double b, Color colour){
    return new Padding(
        padding: EdgeInsets.fromLTRB(a, b, 0.0, 0.0),
        child: new Text(
          word,
          style: TextStyle(
          fontSize: 80.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          color: colour,
          )
          ),
      );
  }

  String validate(String value, String text){
    if(value.isEmpty){
      setState((){
        _isLoading=false;
      });
      
      return 'Va rugam introduceti' + text;

    } else {

      if(text==" emailul" && (!value.contains("@") || !value.contains("."))){
        setState((){
        _isLoading=false;
        });

        return "Va rugam introduceti un email valid";
      }

      return null;
    }
  }

  Widget showEmailInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child:  new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(
                color: Colors.deepOrange[700],
                fontFamily: 'Montserrat',
                //fontSize: 20,
                fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: 'EMAIL',
          labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.amber[900],
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow[700])
          ),
        ),
        validator: (value) => validate(value, " emailul"),
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }
  
  Widget showPasswordInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child:  new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        style: TextStyle(
                color: Colors.deepOrange[700],
                fontFamily: 'Montserrat',
                //fontSize: 20,
                fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: 'PASSWORD',
          labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.amber[900],
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow[700])
          ),
        ),
        validator: (value) => validate(value, " parola"),
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showLoginButton(){
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)
          ),
          color: Colors.yellow[700],
          child: new Text(
              'Intra in cont!',
              style: new TextStyle(
                color: Colors.deepOrange[700],
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          onPressed: validateAndSubmit,
        ),
      ),
    );
  }

  Widget showErrorMessage(){
    if(_errorMessage.length > 0 && _errorMessage != null){
      return new Text(
        _errorMessage,
        style: TextStyle(
          fontSize: 13.0,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w300,
          fontFamily: 'Montserrat',
        ),
      );
    }
    else
    {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showForm(){
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showText('Buna', 0.0, 0.0, Colors.amber[900]),
            showText('Ziua!', 15.0, 0.0, Colors.yellow[700]),
            //showText('!', 190.0, 0.0, Colors.yellow[700]),
            showEmailInput(),
            showPasswordInput(),
            showLoginButton(),
            //showErrorMessage(),
          ],
        ),
      ),
    );
  }

  @override
  
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
        //Navigator.of(context).pop();
        return false;
      },
      child: new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          _showForm(),
          showCircularProgress(),
          //showErrorMessage(),
        ],
      )  
     )
    );
  }
}
