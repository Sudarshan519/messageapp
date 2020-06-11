import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:message_app/helpers/constants.dart';
import 'package:message_app/helpers/db_helper.dart';
import 'package:message_app/models/CallsDetails.dart';

class CallsScreen extends StatefulWidget {
  @override
  _CallsScreenState createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, values, Widget child) {
        if (values == null) return CircularProgressIndicator();
        if (values.keys.length == 0)
          return Center(
            child: Text(
              "No any call records",
              style: TEXT_STYLE2.copyWith(color: Colors.grey),
            ),
          );
        else
          return ListView.builder(
              itemCount: values.keys.toList().length,
              itemBuilder: (context, index) {
                final key = values.keys.toList()[index];
                final callDetails = values.get(key) as CallDetails;
                print(values.keys.toList().length);
                return CallItem(callDetails: callDetails);
              });
      },
      valueListenable: dbHelper.getCallsListenable(),
    );
  }
}

class CallItem extends StatelessWidget {
  final CallDetails callDetails;
  const CallItem({
    Key key,
    this.callDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        callDetails.name,
      ),
      subtitle: Row(
        children: <Widget>[
          callDetails.incomingTrue
              ? Icon(
                  Icons.call_received,
                  size: ScreenUtil().setWidth(30.0),
                  color: Colors.red.shade700,
                )
              : Icon(
                  Icons.call_made,
                  size: ScreenUtil().setWidth(30.0),
                  color: Colors.green.shade700,
                ),
          callDetails.times > 0 ? Text(" (${callDetails.times}) ") : Text(""),
          Text(callDetails.time),
        ],
      ),
      leading: CircleAvatar(
          radius: 25, backgroundImage: FileImage(File(callDetails.imageURL))),
      trailing: IconButton(
        icon: callDetails.callTrue
            ? Icon(
                Icons.call,
                color: Theme.of(context).primaryColor,
              )
            : Icon(
                Icons.videocam,
                color: Theme.of(context).primaryColor,
              ),
        onPressed: () {},
      ),
    );
  }
}
