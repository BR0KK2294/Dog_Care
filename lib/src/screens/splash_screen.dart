import 'package:dog_care1/src/blocs/splash_bloc.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const identifier = '/splashScreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    // WillPopScope se ocupa para prohibir hacer pop a la pantalla
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Center(child: Text("Bienvenido"));
            }),
      ),
    );
  }

  getData() async {
    final bool isLogged = await splashBloc.isLogged();
    print("response: $isLogged");

    if (isLogged) {
      //redireccion al Home
      Navigator.pushReplacementNamed(context, HomeScreen.identifier);
    } else {
      //redireccion al Login
      Navigator.pushReplacementNamed(context, LoginScreen.identifier);
    }
  }
}
