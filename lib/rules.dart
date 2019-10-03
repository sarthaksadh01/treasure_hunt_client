import 'package:flutter/material.dart';

class Rules extends StatefulWidget {
  @override
  _RulesState createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Column(
        children: <Widget>[
          Text("Rules",style: TextStyle(fontSize: 50),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text( "All the teams must have 3 members.\n\nOnce registration is done no further changes will be entertained.\n\nEach team must required a smart phone with internet connection\n\nOnly those who qualified prelims will participate in final round\n\nAll the team members will have to adhere to rules & regulations\n\nTeam not adhering to any guidelines will be disqualified\n\nDecision taken by the heads will be final",),
          )
        ],
      )),
    );
  }
}
