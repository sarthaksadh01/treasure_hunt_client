import 'package:flutter/material.dart';
const url = 'http://thinkdiff.net';
const email = 'mahmud@example.com';
const phone = '+880 123 456 78';


class Profile extends StatelessWidget {
  void _showDialog(BuildContext context, {String title, String msg}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        RaisedButton(
          color: Colors.teal,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (x) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/Mahmud_200.jpg'),
            ),
            Text(
              'Mahmud Ahsan',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            Text(
              'Software Engineer',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                fontSize: 30.0,
                color: Colors.teal[50],
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.teal.shade700,
              ),
            ),
            InfoCard(
              text: phone,
              icon: Icons.phone,
            
            ),
            InfoCard(
              text: email,
              icon: Icons.email,
            
            ),
            InfoCard(
              text: url,
              icon: Icons.web,
             
            ),
            InfoCard(
              text: 'Melaka, Malaysia',
              icon: Icons.location_city,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.teal[200],
    );
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
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 20.0,
              color: Colors.teal,
            ),
          ),
        ),
      );
    
  }
}