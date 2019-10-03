import 'package:flutter/material.dart';

import './splash.dart';
import './login.dart';
import './home.dart';
import './profile.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.blue, accentColor: Colors.blueAccent),
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