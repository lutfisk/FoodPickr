import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'party.dart';

class FoodPickr extends InheritedWidget{
  FoodPickr({
    Key key,

    @required Widget child,
  }) : super(key: key, child: child);

  List<Party> parties = [];

  void syncUpload() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    String uid;
    Auth().currentUser().then((String val) {
      uid = val;
      ref = ref.child("Accounts/$uid");

      Map<String, dynamic> json = {
        "Parties" : parties.map((Party party) {
          return party.toJson();
        }).toList(),
      };

      ref.set(json).catchError((err) {
        print(err);
      });
    });
  }

  void syncDownload() {
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  String uid;
  Auth().currentUser().then((String val) {
    uid = val;
    print(uid);
    ref = ref.child("Accounts/$uid");

    DatabaseReference partiesRef = ref.child("/Parties");

    partiesRef.once().then((DataSnapshot ds) {
      parties = [];
      print(ds.value);

      ds.value.forEach((k, v) {
        if (!parties.contains(Party(partyName: v))) parties.add(Party(partyName: v));
      });
      }).catchError((err) {
        print(err);
      });
    });
  }  

  static FoodPickr of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FoodPickr>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}