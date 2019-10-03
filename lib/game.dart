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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Text("Treasure 1",style: TextStyle(fontSize: 40),),
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: Text("Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book.",textAlign: TextAlign.center,style: TextStyle(),),
           ),
          RaisedButton(
            onPressed: () {
              _scanQR();
            },
            child: Text("Scan"),
          ),
        ],
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
