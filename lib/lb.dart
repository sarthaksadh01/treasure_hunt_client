import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lb extends StatefulWidget {
  @override
  _LbState createState() => _LbState();
}

class _LbState extends State<Lb> {
  var teamId;
  var loading = true;

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: loading
            ? Center(child: CircularProgressIndicator(),)
            : StreamBuilder(
                stream: Firestore.instance
                    .collection("teams")
                    .orderBy("level", descending: true)
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.hasError) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      List<DocumentSnapshot> ls = snapshot.data.documents;
                      String teamName = ls[index]["team_name"];
                      if(index==0){



                        return Column(children: <Widget>[
                          Card(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color:Colors.white,
                            child: Row(
                         
                            children: <Widget>[

                               Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Rank"),
                              ),
                             
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Team Name"),
                              ),

                              Spacer(),

                                Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Level"),
                              ),
                            
                            ],
                          ),
                          )
                      
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color:teamId==ls[index].documentID?Colors.amberAccent:Colors.white,
                            child: Row(
                         
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text("${index + 1}"),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(teamName),
                              ),

                              Spacer(),

                                Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${ls[index]['level']}"),
                              ),
                            
                            ],
                          ),
                          )
                      
                      )

                        ],);

                      }
                      else{

                        return Card(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color:teamId==ls[index].documentID?Colors.amberAccent:Colors.white,
                            child: Row(
                         
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text("${index + 1}"),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(teamName),
                              ),

                              Spacer(),

                                Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${ls[index]['level']}"),
                              ),
                            
                            ],
                          ),
                          )
                      
                      );

                      }
                    },
                  );
                },
              ));
  }

  _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _teamId = prefs.getString('teamId');
    if (_teamId == null) {
      print("teamID is NULLLLL------");
    } else {
      setState(() {
        teamId = _teamId;
        print("team id is ---");
        print(teamId);
        loading = false;
      });
    }
  }
}
