import 'package:flutter/material.dart';
const teamName = "Cryptx";
const teamId = 'Abcd_12#4';
const phone = '+918076911425';
const level = 4;


class Profile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
         
            Text(
              'Team - Cryptx',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
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
              text: "Sarthak Sadh",
              icon: Icons.web,
             
            ),
            InfoCard(
              text: phone,
              icon: Icons.phone,
            
            ),
            InfoCard(
              text: teamId,
              icon: Icons.email,
            
            ),
            InfoCard(
              text: "level - $level",
              icon: Icons.web,
             
            ),
          
          ],
        ),
      ),
      backgroundColor:Theme.of(context).primaryColor,
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