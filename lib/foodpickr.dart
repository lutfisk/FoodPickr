import 'package:flutter/material.dart';
import 'party.dart';

class FoodPickr extends InheritedWidget{
  FoodPickr({
    Key key,

    @required Widget child,
  }) : super(key: key, child: child);

  List<Party> parties = [];

  static FoodPickr of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FoodPickr>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}