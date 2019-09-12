import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const identifier = '/loginScreen';
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              body: Center(
                child: loginForm(),
              ),
            )));
  }

  Form loginForm() {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            usernameField(),
            Container(height: 20.0),
            passwordField(),
            Container(height: 20.0),
            submitButton()
          ],
        ),
      ),
    );
  }

  TextFormField usernameField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: userTextController,
      onFieldSubmitted: (v) {
        FocusScope.of(_formKey.currentContext).requestFocus(focus);
      },
      style: TextStyle(fontSize: 20.0),
      decoration: InputDecoration(hintText: 'Usuario'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Este campo no puede estar vacio';
        }
        return null;
      },
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      textInputAction: TextInputAction.go,
      controller: passTextController,
      focusNode: focus,
      obscureText: true,
      /*onFieldSubmitted: (term) {
        (_submitAction);
      },*/
      style: TextStyle(fontSize: 20.0),
      decoration: InputDecoration(hintText: 'Contraseña'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Este campo no puede estar vacio';
        }
        return null;
      },
    );
  }

  RaisedButton submitButton() {
    return RaisedButton(
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text("Ingresar", style: TextStyle(fontSize: 20.0)),
      ),
    );
  }
}
