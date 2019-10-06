import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
      });
      setState(() {
        check = true;
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
    return Center(
      child: !check
          ? CircularProgressIndicator()
          : Container(
              child: Center(
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
                    int point = snapshot.data.data["level"];
                    if (snapshot.data.data["level"] > 7) {
                      return Container(
                        child: Center(
                          child: Text("Win"),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Treasure ${snapshot.data.data["level"]}",
                          style: TextStyle(fontSize: 50),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            question[point - 1]["question"],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _scanQR();
                          },
                          child: Text("Scan"),
                        ),
                      ],
                    );
                  }),
            )),
    );
  }

  Future _scanQR() async {
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
