import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:treasure_hunt/loader.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  var snap = Firestore.instance.collection("questions").getDocuments();
  bool check = false;
  var level = 1, answer;
  var teamId;
  List<Map> question = List(10);

  _getquestion() {
    snap.then((doc) {
      var list = doc.documents;
      list.forEach((qdata) {
        var data = {"question": qdata["question"], "answer": qdata["answer"]};
        question[qdata["level"] - 1] = data;
        if (data != null) {
          setState(() {
            check = true;
          });
        }
      });
    });
  }

  _getLevel(String teamId) {
    Firestore.instance.collection("teams").document(teamId).get().then((doc) {
      setState(() {
        level = doc.data['level'];
        print("level is --- ");
        print(level);
        _getquestion();
      });
    });
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
        _getLevel(teamId);
      });
    }
  }

  _changeLevel() {
    Firestore.instance
        .collection("teams")
        .document(teamId)
        .updateData({'level': level + 1}).then((onValue) {
      setState(() {
        level++;
        check = true;
      });
    });
  }

  _showAlert(String type, String title, String text) {
    Alert(
      context: context,
      type: type == "error" ? AlertType.error : AlertType.success,
      title: title,
      desc: text,
      buttons: [
        DialogButton(
          child: Text(
            "Continue",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (type != "error") {
              _changeLevel();
              setState(() {
                check = false;
              });
            }

            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !check
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Loader(),
              ),
            )
          : ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Center(
                      child: SingleChildScrollView(
                        child: StreamBuilder(
                            stream: Firestore.instance
                                .collection("teams")
                                .document(teamId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return Center(
                                  child: Loader(),
                                );

                              int point = snapshot.data.data["level"];

                              if (snapshot.data.data["level"] > 7) {
                                return Padding(
                                  padding: const EdgeInsets.only(top:80.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left:20.0),
                                          child: Text("Congratulations!!!",style: TextStyle(fontSize: MediaQuery.of(context).size.width/10),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "assets/images/treasure.gif",
                                            height:
                                                MediaQuery.of(context).size.height /
                                                    5,
                                          ),
                                        ),
                                      ],
                                    ),
                                );
                              }

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    snapshot.data.data["level"] > 6
                                        ? Text(
                                            "Final Level",
                                            style: TextStyle(fontSize: 50),
                                          )
                                        : Text(
                                            "Level ${snapshot.data.data["level"]}",
                                            style: TextStyle(fontSize: 50),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        question[point - 1]["question"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    )),
                  ],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(

          // color: Color(0xFF00162b),
          onPressed: () {
            _scanQR();
          },
          child: Icon(FontAwesome.getIconData("qrcode"))),
    );
  }

  _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();

      if (qrResult == question[level - 1]['answer']) {
        _showAlert("correct", "Success!", "Correct Answer!");
      } else {
        _showAlert("error", "Wrong", "Try Again!");
      }
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          // result = "Camera permission was denied";
        });
      } else {
        setState(() {
          // result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        // result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        // result = "Unknown Error $ex";
      });
    }
  }
}
