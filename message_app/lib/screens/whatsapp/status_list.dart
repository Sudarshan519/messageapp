import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:message_app/helpers/db_helper.dart';
import 'package:message_app/models/status.dart';
import 'package:message_app/screens/whatsapp/edit_status.dart';

class StatusList extends StatefulWidget {
  @override
  _StatusListState createState() => _StatusListState();
}

class _StatusListState extends State<StatusList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   void showSnackBar(String value, var color) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: color,
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (a) => EditStatus()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: Text('Status'),
        ),
        body: getList());
  }

  getList() {
    return ValueListenableBuilder(
      builder: (BuildContext context, Box<dynamic> values, Widget child) {
        if (values == null) return CircularProgressIndicator();
        if (values.keys.length == 0)
          return Center(
            child: Text('No Status click + to add'),
          );
        return ListView.builder(
          itemCount: values.keys.toList().length,
          itemBuilder: (BuildContext context, int index) {
            final key = values.keys.toList()[index];
            final user = values.get(key) as Status;
            return ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                      width: 3.0,
                      color: user.isSeen != true
                          ? Theme.of(context).secondaryHeaderColor
                          : Colors.grey),
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: FileImage(File(user.imageURL)),
                ),
              ),
              title: Text(user?.name.toString()),
              subtitle: Text(user?.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (a) => EditStatus(statusUser: user)));
                      }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        dbHelper.deletStatus(key);
                        showSnackBar(user?.name.toString() + " Status Is Deleted", Colors.redAccent);
                      }),
                ],
              ),
            );
          },
        );
      },
      valueListenable: dbHelper.getStatusListenable(),
    );
  }
}
