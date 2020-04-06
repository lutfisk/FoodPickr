import 'auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/painting.dart';
import 'package:email_validator/email_validator.dart' as email_val;
import 'package:form_field_validator/form_field_validator.dart' as form_val;

class LoginPage extends StatefulWidget{
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType{
  login,
  register
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  AnimationController _logoAnimationController;
  Animation<double> _logoAnimation;

  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async{
    if (validateAndSave()){
      try{
        if (_formType == FormType.login){
          String userID = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in as: $userID');
        }
        else{
          String userID = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userID');
        }
        widget.onSignedIn();
      } 
      catch (e){
        print('Error: $e');
      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState((){
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState((){
      _formType = FormType.login;
    });
  }

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
      resizeToAvoidBottomPadding: false,
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
                    key: formKey,
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
                          children: buildInputs() + buildSubmitButtons(),
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

  List<Widget> buildInputs(){
    if (_formType == FormType.login) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Email:"),
          validator: (value) => !email_val.EmailValidator.validate(value, true) ? 'Invalid email!' : null,
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) => _email = value,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Password:",
          ),
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: form_val.MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),
          onSaved: (value) => _password = value,
        ),
      ];
    } 
    else{
      return [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Enter your email"),
          validator: (value) => !email_val.EmailValidator.validate(value, true) ? 'Please provide a valid email' : null,
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) => _email = value,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Enter your password",
          ),
          keyboardType: TextInputType.text,
          obscureText: false,
          validator: form_val.MinLengthValidator(6, errorText: 'Please provide a password with at least 6 characters'),
          onSaved: (value) => _password = value,
        ),
      ];
    }
  }

  List<Widget> buildSubmitButtons(){
    if (_formType == FormType.login) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        MaterialButton(
          color: Colors.redAccent[700],
          height: 40.0,
          minWidth: 100.0,
          textColor: Colors.white,
          child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () =>
            validateAndSubmit(),
          splashColor: Colors.black87,
        ),
        FlatButton(
          textColor: Colors.white,
          child: Text("Signup"),
          onPressed: () =>
            moveToRegister(),
        ),
      ];
    } 
    else {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        MaterialButton(
          color: Colors.redAccent[700],
          height: 40.0,
          minWidth: 100.0,
          textColor: Colors.white,
          child: Text("Create an account", style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () =>
            validateAndSubmit(),
          splashColor: Colors.black87,
        ),
        FlatButton(
          textColor: Colors.white,
          child: Text("Already have an account? Log in"),
          onPressed: () =>
            moveToLogin(),
        ),
      ];
    }
  }
}
