import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_annotation/json_annotation.dart';
import 'party_page.dart';

part 'party.g.dart';

@JsonSerializable()
class Party extends StatefulWidget {
  final state = _PartyState();
  final String partyName;
  final List<String> pastWinners;

  Party({@required this.partyName, this.pastWinners});

  @override
  State<StatefulWidget> createState() => _PartyState();

  factory Party.fromJson(Map<String, dynamic> json) => _$PartyFromJson(json);
  Map<String, dynamic> toJson() => _$PartyToJson(this);
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
              PartyPage(party: widget)));
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
                // actions: <Widget>[
                //   IconButton(
                //     icon: Icon(Icons.delete,
                //     color: Colors.black,
                //     ),
                //     tooltip: 'Delete party',
                //     onPressed: delete(widget.partyName),
                //   )
                // ],
              )
            ],
          ),
        )
      ),
    );
  }
  delete(String name){
    return null;
  }
}