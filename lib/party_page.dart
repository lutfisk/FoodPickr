import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_format/date_format.dart';
import 'dart:math';
import 'party_history.dart';

class PartyPage extends StatefulWidget {
  final int index;
  final String partyName;
  PartyPage(this.index, this.partyName);

  @override
  State<StatefulWidget> createState() => _PartyPageState();
}

class _PartyPageState extends State<PartyPage> {
  List<String> items = [];
  List<String> winners = [];
  Random rand = Random();
  
  String temp;
  String winner;

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

  showAlert(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('This is what you will be eating today!',
          textAlign: TextAlign.center,),
          content: Text(temp,
          textAlign: TextAlign.center,
          style: GoogleFonts.courgette(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black,
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red[800],
              minWidth: 100.0,
              elevation: 5,
              child: Text("REROLL"),
              onPressed: () {
                Navigator.of(context).pop();
                randomize();
              },
            ),
            MaterialButton(
              color: Colors.green[600],
              minWidth: 100.0,
              elevation: 5,
              child: Text("LET'S EAT!"),
              onPressed: () {
                winner = temp;
                var date = formatDate(DateTime.now(), [d, '-', M, '-', yyyy]);
                winners.add(date + ' you ate ' + winner);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
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
            fontSize: 26,)
          ),
          centerTitle: true,
           actions: <Widget>[
              IconButton(
                icon: Icon(Icons.access_time),
                tooltip: 'Past winners',
                onPressed: () {
                  print(winners);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PartyHistory(winners)));
                },
              ),
            ],
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
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext item, int index) => buildItemCard(context, index),
                ),  
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text("Add Item", style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: (){
                    createAlertDialog(context).then((onValue) {
                      setState((){
                        items.add(onValue);
                      });
                    });  
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: MaterialButton(
                  color: Colors.redAccent[700],
                  height: 40.0,
                  minWidth: 100.0,
                  textColor: Colors.white,
                  child: Text("Randomize", style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: (){
                    randomize();
                  }
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget buildItemCard(BuildContext item, int index) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
        child: Card(
          color: Colors.transparent,
          elevation: 5,
          child: InkWell(
            onTap: (){
              setState(() {
                  items.removeAt(index);
                });
            },
            child: Column(
              children: <Widget>[
                Text(items[index], 
                  style: GoogleFonts.courgette(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.grey[200],
                  ),
                ),
              ],
            ),
          ),  
        ),
      )
    );
  }

  randomize(){
    temp = items[rand.nextInt(items.length)];
      showAlert(context);
      print(temp);
  }
}
