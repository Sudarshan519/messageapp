import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../helpers/db_helper.dart';
import '../../models/CallsDetails.dart';
import 'edit_calls.dart';

class CallLists extends StatefulWidget {
  @override
  _CallListsState createState() => _CallListsState();
}

class _CallListsState extends State<CallLists> {
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
                context, MaterialPageRoute(builder: (a) => EditCalls()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: Text('Calls'),
        ),
        body: getList());
  }

  getList() {
    return ValueListenableBuilder(
      builder: (BuildContext context, Box<dynamic> values, Widget child) {
        if (values == null) return CircularProgressIndicator();
        if (values.keys.length == 0)
          return Center(
            child: Text('No calls click + to add'),
          );
        return ListView.builder(
          itemCount: values.keys.toList().length,
          itemBuilder: (BuildContext context, int index) {
            final key = values.keys.toList()[index];
            final user = values.get(key) as CallDetails;
            return ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: FileImage(File(user.imageURL)),
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
                                builder: (a) => EditCalls(
                                      callDetails: user,
                                    )));
                      }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        dbHelper.deletcall(key);
                        showSnackBar(user?.name.toString() + " Call Is Deleted",
                            Colors.redAccent);
                      }),
                ],
              ),
            );
          },
        );
      },
      valueListenable: dbHelper.getCallsListenable(),
    );
  }
}
