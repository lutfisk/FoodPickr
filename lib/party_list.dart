import 'package:flutter/material.dart';
import 'auth.dart';

class PartyList extends StatelessWidget {
  PartyList({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    }
    catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text("FoodPickr"),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout', 
            style: TextStyle(fontSize: 17, 
            color: Colors.blue)),
            onPressed: _signOut
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Text('Welcome!', style: new TextStyle(fontSize: 32))
        ),
      ),
    );
  }


}