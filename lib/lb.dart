import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treasure_hunt/profile.dart';

import 'loader.dart';

class Lb extends StatefulWidget {
  @override
  _LbState createState() => _LbState();
}

class _LbState extends State<Lb> {
  String _teamId;
  bool check = false;
  int rank;
  rankteam(l) {
    rank = l + 1;
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _teamId = prefs.getString('teamId');
    });
    if (_teamId != null) {
      print("apki id haii " + _teamId);
      setState(() {
        check = true;
      });
    }
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !check
        ? Loader()
        : Padding(
            padding: const EdgeInsets.all(25.0),
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection("teams")
                  .orderBy("level", descending: true)
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return Loader();
                }
                // print("${snapshot.data.data["teamId"]}");
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(),
                    SliverToBoxAdapter(
                      // child: Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Text(
                      //       "Your Rank : ",
                      //       style: TextStyle(fontSize: 30),
                      //     ),
                      //     Spacer(),
                      //     Flexible(
                      //         child: Text(
                      //       "$rank",
                      //       style: TextStyle(
                      //         fontSize: 30,
                      //       ),
                      //       overflow: TextOverflow.clip,
                      //     )),
                      //   ],
                      // ),
                    ),
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            List<DocumentSnapshot> ls = snapshot.data.documents;

                            if (ls[index].documentID == _teamId) {
                              rankteam(index);
                              print(rank);
                            }
                            String team_name = ls[index]["team_name"];
                            // return Text("hahahha");
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Color(0xFF00162b),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      index < 2
                                          ? CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/images/prize.gif"),
                                              backgroundColor: Colors.white,
                                              // child: Image.asset("assets/images/prize.gif",height:100),
                                              // child: Text("${index + 1}",style: TextStyle(color: Color(0xFF00162b)),),
                                            )
                                          : CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Text(
                                                "${index + 1}",
                                                style: TextStyle(
                                                    color: Color(0xFF00162b)),
                                              ),
                                            ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          team_name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )),
                    SliverList(
                      delegate: SliverChildListDelegate([]),
                    ),
                  ],
                );
              },
            ));
  }
}
