import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loader.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var loading = false;
  var teamId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).accentColor
                      ],
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.account_box,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 62),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            teamId = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          hintText: 'Team Id',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            _login();
          },
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width / 1.2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: loading == false
                  ? Text(
                      'Join'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  _login() {
    setState(() {
      loading = true;
    });

    if (teamId.trim() == "") {
      _showError("Invalid Team Name!");
      return;
    }

    _checkTeamId();
  }

  _checkTeamId() {
    Firestore.instance
        .collection('teams')
        .where('teamId', isEqualTo: teamId.trim())
        .getDocuments()
        .then((docSnapshot) {
      int _numberOfUsers = docSnapshot.documents.length;
      if (_numberOfUsers > 0) {
        print("number of users are--");
        print(_numberOfUsers);
        print(docSnapshot.documents[0].data);
        if (docSnapshot.documents[0].data['login'] ==
            docSnapshot.documents[0].data['members']) {
          _showError("Maximum Login Limit Reached");
        } else {
          _saveData(docSnapshot.documents[0].documentID,
              docSnapshot.documents[0].data['login'] + 1);
        }
      } else {
        _showError("Team not Registered!");
      }
    });
  }

  _saveData(String docId, int loginNumber) async {
    Firestore.instance
        .collection("teams")
        .document(docId)
        .updateData({'login': loginNumber}).then((onValue) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('teamId', docId.toString());
      Navigator.pushReplacementNamed(context, "/Home");
    });
  }

  _showError(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    setState(() {
      loading = false;
    });
  }
}
