import 'package:flutter/material.dart';

import './splash.dart';
import './login.dart';
import './home.dart';

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
      
      // '/Profile': (context) => Profile(),
      // '/AddDesc': (context) => AddDescFull(),
      // '/SignUpA': (context) => SignupAFull(),
      // '/SignUpB': (context) => SignupBFull(),
      // '/Sub': (context) => SubCategoryFull(),
      // '/ScreenRecord': (context) => ScreenRecord(),
      // '/ViewLive': (context) => ViewLive(),
      // '/OtherProfile': (context) => OtherProfile(),
      // '/Donate': (context) => Donate(),
      // '/Wallet': (context) => Wallet(),
      // 'Search': (context) => Search(),

    },
  ));
}