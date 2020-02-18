import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/painting.dart';

import 'party_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.red
        )
    );
  }
}

class LoginPage extends StatefulWidget{
  @override
  State createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  AnimationController _logoAnimationController;
  Animation<double> _logoAnimation;

  @override
  void initState(){
    super.initState();
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000)
      );
      _logoAnimation = CurvedAnimation(
        parent: _logoAnimationController, curve: Curves.easeInExpo
        );
        _logoAnimation.addListener(() => this.setState((){}));
        _logoAnimationController.forward();
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage("assets/model1.jpg"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/temp_logo.png"),
                  width: _logoAnimation.value * 350,
                  height: _logoAnimation.value * 250,
                  fit: BoxFit.contain,
                  ),
                  Form(
                    child: Theme(
                      data: ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.red, 
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 18.0
                          )
                        )
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(35.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Enter Email",
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Enter Password",
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              ),
                              MaterialButton(
                                color: Colors.redAccent[700],
                                height: 40.0,
                                minWidth: 100.0,
                                textColor: Colors.white,
                                child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () => {
                                  //Navigator.push(
                                  //context, MaterialPageRoute(builder: (context) => PartyList()),
                                  //)
                                },
                                splashColor: Colors.black87,
                              ),
                          ],
                        ),
                      ),
                    )
                  )
              ],
            )
        ],
      ),
    );
  }
}
