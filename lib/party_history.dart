import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PartyHistory extends StatelessWidget {
  final List<String> winners;
  PartyHistory(this.winners);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
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
                padding: EdgeInsets.fromLTRB(20, 45, 20, 20),
                child: Text("Party History",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.caveat(
                    color: Colors.blueGrey[400],
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2,
                    fontSize: 34,
                    )
                  ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: winners.length,
                  itemBuilder: (food, index) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 2, 20, 20),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Text(
                                winners[index],
                                style: GoogleFonts.courgette(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.grey[200],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                child: MaterialButton(
                  color: Colors.grey[300],
                  height: 40.0,
                  minWidth: 100.0,
                  textColor: Colors.black,
                  child: Text("Back",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ],
      )
    );
  }
}
