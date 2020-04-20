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

  static FoodPickr of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FoodPickr>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}