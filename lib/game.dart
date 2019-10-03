import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: RaisedButton(
        onPressed: () {
          _scanQR();
        },
        child: Text("Scan"),
      ),
    ));
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
