import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'foodpickr.dart';
import 'root.dart';

void main() => runApp(FoodPickr(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red
        ),
      home: RootPage(auth: Auth())
    );
  }
}
