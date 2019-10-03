import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Image.asset(
          "assets/treasure.png",
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
        ),
        )
        );
  }

  _getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String teamId = prefs.getString('teamId');
    if (teamId == null) {
      _moveToPage("/Login");
    } else {
      _moveToPage("/Home");
    }
  }

  _moveToPage(String page) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacementNamed(context, page);
    });
  }
}
