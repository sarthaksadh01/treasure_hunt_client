import 'package:flutter/material.dart';

import './splash.dart';
import './login.dart';
import './home.dart';
import './profile.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: "Ancient",
        primaryColor: Color(0xFF00162b), accentColor: Color(0xFF003366)),
    title: 'Treasure Hunt',
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/Login': (context) => Login(),
      '/Home': (context) => Home(),
      '/Profile':(context)=>Profile()
      

    },
  ));
}