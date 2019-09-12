import 'package:dog_care1/src/screens/detail_dog_screen.dart';
import 'package:dog_care1/src/screens/home_screen.dart';
import 'package:dog_care1/src/screens/login_screen.dart';
import 'package:dog_care1/src/screens/new_dog_screen.dart';
import 'package:dog_care1/src/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DOG CARE",
      home: SplashScreen(),
      theme: ThemeData(
          primaryColor: Colors.green, accentColor: Colors.greenAccent),
      routes: <String, WidgetBuilder>{
        SplashScreen.identifier: (BuildContext context) => SplashScreen(),
        LoginScreen.identifier: (BuildContext context) => LoginScreen(),
        HomeScreen.identifier: (BuildContext context) => HomeScreen(),
        NewDogScreen.identifier: (BuildContext context) => NewDogScreen(),
        DetailDogScreen.identifier: (BuildContext context) => DetailDogScreen()
      },
    );
  }
}
