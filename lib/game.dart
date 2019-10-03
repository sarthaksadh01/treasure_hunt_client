import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  var snap = Firestore.instance.collection("questions").getDocuments();
  bool check = false;
  var level = 1, answer;
  List<Map> question = List(10);
  // getlevel() {
  //   // Firestore.instance
  //   // .collection("questions")
  //   // .where("level",isEqualTo :"${snapshot.data.data["level"]}").
  //   // Firestore.instance.collection("teams").where("teamId",isEqualTo:"BTlSYoCGqtmVgwIpHJmM").snapshots();
  //   Firestore.instance
  //       .collection("teams")
  //       .document("BTlSYoCGqtmVgwIpHJmM")
  //       .get()
  //       .then((doc) {
  //     print(doc["level"]);
  //     setState(() {
  //       level = doc["level"];
  //     });
  //     getquestion();
  //   });
  // }

  getquestion() {
    snap.then((doc) {
      var list = doc.documents;
      list.forEach((qdata) {
         var data = {
          "question": qdata["question"],
          "answer":qdata["answer"]
        };
        question[qdata["level"]-1] = data;
      });
      setState(() {
       check= true; 
      });
      //  doc.forEach((data){

      //  })
    });
    // snap.get().then((data) {
    //   print(data["question"]);
    //   print(data["answer"]);
    //   setState(() {
    //     question = data["question"];
    //     answer = data["answer"];
    //     check = true;
    //   });
    // });
  }

  @override
  void initState() {
    // getlevel();
    getquestion();
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
                      .document("BTlSYoCGqtmVgwIpHJmM")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    int point = snapshot.data.data["level"];
                    if (snapshot.data.data["level"] > 10) {
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
                          style: TextStyle(fontSize: 40),
                        ),
                       
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            question[point-1]["question"],
                            textAlign: TextAlign.center,
                            style: TextStyle(),
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
      setState(() {
        print("qr result is ---------------------");
        print(qrResult);
        // result = qrResult;
      });
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

  _scan() async {
    String text = await BarcodeScanner.scan();
    print(text);
  }
}
