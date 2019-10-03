import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter_icons/flutter_icons.dart';

import './game.dart';
import './lb.dart';
import './rules.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  
}

class _HomeState extends State<Home> {
  var currentPage;
  @override
  void initState() {
    currentPage= new Rules();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:currentPage ,
       bottomNavigationBar: FancyBottomNavigation(
          circleColor: Color(0xfffd6a02),
          inactiveIconColor: Color(0xfffd6a02),
          tabs: [
            TabData(iconData: MaterialCommunityIcons.getIconData("file-document"), title: "Rules"),
            TabData(iconData: MaterialCommunityIcons.getIconData("treasure-chest"), title: "Game"),
            TabData(iconData: AntDesign.getIconData("linechart"), title: "LeaderBoard"),
          ],
          onTabChangedListener: (position) {
            setState(() {
              if (position == 0) currentPage = new Rules();
              if (position == 1) currentPage = new Game();
              if (position == 2) currentPage = new Lb();
            });
          },
        ));
    
  }
}