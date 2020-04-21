import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'auth.dart';
import 'foodpickr.dart';
import 'party.dart';

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
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController control = TextEditingController();

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Name your party:'),
          content: TextFormField(
            controller: control,
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red[900],
              elevation: 5,
              child: Text('Create'),
              onPressed: () {
                Navigator.pop(context, control.text.toString());
              },
            ),
          ],
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    FoodPickr fp = FoodPickr.of(context);
  
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.red[900],
            title: Text("FoodPickr",
                style: GoogleFonts.bilboSwashCaps(
                  color: Colors.grey[900],
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                  fontSize: 38,
                )),
            leading: new IconButton(
                icon: new Icon(Icons.accessibility),
                onPressed: () {},
                tooltip: 'Profile'),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                  child: Text('Logout',
                      style: TextStyle(fontSize: 17, color: Colors.red[200])),
                  onPressed: _signOut)
            ],
          ),
          preferredSize: Size.fromHeight(60),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
          image: AssetImage("assets/pizza.jpg"),
          fit: BoxFit.cover,
          color: Colors.black87,
          colorBlendMode: BlendMode.darken,
          ),
          fp.parties.length <= 0 ? Center(
            child: Text(
              'Looks like you have no parties at the moment, try pressing the [+] button below!',
              style: TextStyle(
                color: Colors.blueGrey[400],
                fontSize: 26,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: fp.parties.length,
            itemBuilder: (_, i) => Party(
              partyName: fp.parties[i].partyName,
              pastWinners: fp.parties[i].pastWinners ?? [],
              // delete: () {
              //   setState(() {
              //     fp.parties.removeAt(i);
              //   });  
              // },  
            ),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          createAlertDialog(context).then((onValue) {
            onAddParty(onValue);
          });
        },
        child: new Icon(Icons.add),
        backgroundColor: Colors.red[800],
        tooltip: 'Add a new party!',
      ),
    );
  }

  void onAddParty(String name) {
    setState(() {
      FoodPickr.of(context)
        ..parties.add(Party(partyName: name))
        ..syncUpload();
    });
  }
}
