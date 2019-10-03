import 'package:cloud_firestore/cloud_firestore.dart';
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
        child: StreamBuilder(
          stream: Firestore.instance
              .collection("teams")
              .orderBy("level", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return CircularProgressIndicator();
            }
            print("${snapshot.data.data["teamId"]}");
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${snapshot.data}"),
                      ),
                      Spacer(),
                      // Text("${index+1}"),
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
