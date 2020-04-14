import 'package:flutter/material.dart';
import 'party_list.dart';
import 'party_user.dart';

typedef OnDelete();

class Party extends StatefulWidget {
  final state = _PartyState();
  final OnDelete onDelete;
  final PartyUser user;

  Party({this.user, this.onDelete});

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
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.people),
                title: Text(PartyUser().partyName),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
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