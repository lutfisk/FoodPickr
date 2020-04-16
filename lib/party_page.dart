import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PartyPage extends StatefulWidget {
  final int index;
  final String partyName;
  PartyPage(this.index, this.partyName);

  @override
  State<StatefulWidget> createState() => _PartyPageState();
}

class _PartyPageState extends State<PartyPage> {
  List<String> items = List();
  String temp;

    Future<String> createAlertDialog(BuildContext context) {
    TextEditingController control = TextEditingController();

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add an item:'),
          content: TextFormField(
            controller: control,
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red[900],
              elevation: 5,
              child: Text('Add'),
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
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.red[900],
          title: Text(widget.partyName,
          style: GoogleFonts.lobster(
            color: Colors.grey[300],
            fontStyle: FontStyle.italic,
            letterSpacing: 3,
            fontSize: 32,)
          ),
          centerTitle: true,
        ),
        preferredSize: Size.fromHeight(65)),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
          image: AssetImage("assets/crabby.jpg"),
          fit: BoxFit.cover,
          color: Colors.black87,
          colorBlendMode: BlendMode.darken,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text("Let's figure out where you're eating today!", 
                textAlign: TextAlign.center,
                style: GoogleFonts.caveat(
                  color: Colors.blueGrey[400],
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                  fontSize: 28,)
                ),
              ),
              RaisedButton(
                child: Text("Add Item", style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: (){
                  createAlertDialog(context).then((onValue) {
                    setState((){
                      items.add(onValue);
                    });
                  });  
                },
              ),
              MaterialButton(
                color: Colors.redAccent[700],
                height: 40.0,
                minWidth: 100.0,
                textColor: Colors.white,
                child: Text("Randomize", style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: (){}
              ),
            ],
          ),
        ],
      )
    );
  }
}
