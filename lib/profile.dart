import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/flutter_icons.dart';



class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var teamId;
  var loading = true;

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection("teams")
                      .document(teamId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    return Container(
                      height: MediaQuery.of(context).size.height,
                       width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).primaryColor,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          snapshot.data['team_name'],
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 200,
                          child: Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        InfoCard(
                          text: snapshot.data['team_leader'],
                          icon: Icons.portrait,
                        ),
                        InfoCard(
                          text: snapshot.data['phone'],
                          icon: Icons.phone,
                        ),
                        InfoCard(
                          text: snapshot.data['teamId'],
                          icon: Icons.apps,
                        ),
                        InfoCard(
                          text: "level - ${snapshot.data['level']}",
                          icon: AntDesign.getIconData("linechart"),
                        ),
                      ],
                    ),
                    );
                  }),
            ),
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
        loading=false;
      });
    }
  }
}

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  InfoCard({
    @required this.text,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: ListTile(
        leading: Icon(
          icon,
          // color: Colors.teal,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            // color: Colors.teal,
          ),
        ),
      ),
    );
  }
}
