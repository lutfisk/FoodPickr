import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'foodpickr.dart';
import 'party_page.dart';

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
      padding: EdgeInsets.all(5),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => 
              PartyPage(FoodPickr.of(context).parties.indexOf(widget), widget.partyName)));
          },
          child: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.redAccent[600],
                leading: Icon(Icons.people,
                color: Colors.grey[400],
                ),
                title: Text(widget.partyName.toString(), 
                  style: GoogleFonts.courgette(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[200],
                    fontSize: 24,
                  )
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete,
                    color: Colors.black,
                    ),
                    tooltip: 'Delete party',
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