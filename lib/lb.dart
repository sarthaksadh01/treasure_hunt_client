import 'package:flutter/material.dart';
class Lb extends StatefulWidget {
  @override
  _LbState createState() => _LbState();
}

class _LbState extends State<Lb> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context,index){
          return Card(
            child: Row(
              children: <Widget>[
                CircleAvatar(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Team Under pressure"),
                ),
                Spacer(),
                Text("${index+1}"),
              ],
            ),
          );
        },

      ),
    );
  }
}