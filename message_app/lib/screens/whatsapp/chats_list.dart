import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:message_app/helpers/db_helper.dart';
import 'package:message_app/models/ChatUser.dart';
import 'package:message_app/screens/whatsapp/edit_chats.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
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
                context, MaterialPageRoute(builder: (a) => EditChats()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: Text('Chats'),
        ),
        body: getList());
  }

  getList() {
    return ValueListenableBuilder(
      builder: (BuildContext context, Box<dynamic> values, Widget child) {
        if (values == null) return CircularProgressIndicator();
        if (values.keys.length == 0)
          return Center(
            child: Text('No chats click + to add'),
          );
        return ListView.builder(
          itemCount: values.keys.toList().length,
          itemBuilder: (BuildContext context, int index) {
            final key = values.keys.toList()[index];
            final user = values.get(key) as ChatUser;
            return ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: FileImage(File(user.imageURL)),
              ),
              title: Text(user?.name.toString()),
              subtitle: Text(user?.message),
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
                                builder: (a) => EditChats(
                                      chatUser: user,
                                    )));
                      }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        dbHelper.deletChatUser(key);
                        showSnackBar(user?.name.toString() + " Chat Is Deleted", Colors.redAccent);
                      }),
                ],
              ),
            );
          },
        );
      },
      valueListenable: dbHelper.getChatUsersListenable(),
    );
  }
}
