import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'auth.dart';
import 'party.dart';
import 'party_user.dart';

class PartyList extends StatefulWidget {
  PartyList({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() => _PartyListState();
}

class _PartyListState extends State<PartyList> {
  BaseAuth auth;
  VoidCallback onSignedOut;

  void _signOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    }
    catch (e) {
      print(e);
    }
  }

  List<PartyUser> users = [];

  Future<String> createAlertDialog(BuildContext context){
    TextEditingController control = TextEditingController();

    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Name your party:'),
            content: TextFormField(
              validator: MinLengthValidator(2, errorText: 'Party name cannot be empty!'),
              controller: control,
              onSaved: (val) => PartyUser().partyName = val, 
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red[900],
                elevation: 5,
                child: Text('Create'),
                onPressed: () {
                  Navigator.of(context).pop(control.text.toString());
                },
              )
            ],
          );
        }
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text("FoodPickr", 
        style: GoogleFonts.lobster(
          color: Colors.black, 
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          letterSpacing: 2,
          fontSize: 26,)
        ),
        leading: new IconButton(
        icon: new Icon(Icons.accessibility),
        onPressed: () {},
        tooltip: 'Profile'
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text('Logout', 
            style: TextStyle(fontSize: 17, 
            color: Colors.red[200])),
            onPressed: _signOut
          )
        ],
      ),
      body: users.length <= 0 ? Center(
        child: Text('Looks like you have no parties at the moment, try pressing the [+] button below!',
        style: TextStyle(
          color: Colors.blueGrey[700],
          fontSize: 26,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
        ),
      ): ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, i) => Party(user: users[i],
        onDelete: () => OnDelete),
      ),  
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          createAlertDialog(context).then((onValue){
            onAddParty();
          });
        },
        child: new Icon(Icons.add),
        backgroundColor: Colors.red[800],
        tooltip: 'Add a new party!',
      ),
    );
  }

  void onDelete(int index) {
    setState((){
      users.removeAt(index);
    });
  }

  void onAddParty() {
    setState(() {
      users.add(PartyUser());
    });
  }
}
