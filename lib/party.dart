import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Party extends StatefulWidget {
  final state = _PartyState();
  final String partyName;
  final Function delete;

  Party({this.partyName, this.delete});

  @override
  State<StatefulWidget> createState() => _PartyState();
}

class _PartyState extends State<Party>{
  final party = GlobalKey<_PartyState>();

  @override 
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(6),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: (){
            print("party clicked!");
          },
          child: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.redAccent[600],
                leading: Icon(Icons.people,
                color: Colors.grey[400],
                ),
                title: Text(widget.partyName, 
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w700,
                  )
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete,
                    color: Colors.black,),
                    onPressed: widget.delete,
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}