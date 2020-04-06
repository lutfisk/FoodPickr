import 'package:app_maybe/party_list.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'auth.dart';
import 'party_list.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();
    widget.auth.currentUser().then((userID){
      setState(() {
        authStatus = userID == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override 
  Widget build(BuildContext context) {
    switch (authStatus){
      case AuthStatus.notSignedIn:
        return LoginPage(auth: widget.auth,
        onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return PartyList(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
    return LoginPage(auth: widget.auth);
  }
}
