import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:message_app/helpers/db_helper.dart';
import 'package:message_app/screens/whatsapp/whatsapp.dart';
import 'package:message_app/widgets/custom_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(),
            GestureDetector(
              onTap: () {
                // navigate
              },
              child: CustomCard(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.mobile_screen_share,
                      size: 50,
                    ),
                    Text('Messenger')
                  ],
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // navigate
              },
              child: CustomCard(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.message,
                      size: 50,
                    ),
                    Text('Ig message')
                  ],
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WhatsappScreen(),
                    ));
              },
              child: CustomCard(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.whatshot,
                      size: 50,
                    ),
                    Text('Whatsapp message')
                  ],
                ),
              ),
            ),
            Spacer(),
            OutlineButton(child: Text('clear whatsapp'), onPressed: () {
              dbHelper.clearHieve();
            },)
          ],
        ),
      ),
    );
  }
}
