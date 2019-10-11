import 'package:flutter/material.dart';

class Rules extends StatefulWidget {
  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SingleChildScrollView(
                      child: Container(
              child: Center(
                  child: Column(
                children: <Widget>[
                  Text(
                    "Rules",
                    style: TextStyle(fontSize: 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      "1. All the teams must have 3 members.\n\n2) Once registration is done no further changes will be entertained.\n\n3) Each team must required a smart phone with internet connection\n\n4) Only those who qualified prelims will participate in final round\n\n5) All the team members will have to adhere to rules and regulations\n\n6) Team not adhering to any guidelines will be disqualified\n\n7) Team size will be the maximum login limit.\n\n8) Decision taken by the Organizers will be final \n",
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
