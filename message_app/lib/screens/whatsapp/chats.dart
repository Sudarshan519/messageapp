import 'dart:io';

import 'package:flutter/material.dart';
import 'package:message_app/helpers/constants.dart';
import 'package:message_app/helpers/db_helper.dart';
import 'package:message_app/models/ChatUser.dart';

import 'chat_detail.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, values, Widget child) {
        if (values == null) return CircularProgressIndicator();
        if (values.keys.length == 0)
          return Center(
            child: Text(
              "No any chats",
              style: TEXT_STYLE2.copyWith(color: Colors.grey),
            ),
          );
        else
          return ListView.builder(
              itemCount: values.keys.toList().length,
              itemBuilder: (context, index) {
                final key = values.keys.toList()[index];
                final user = values.get(key) as ChatUser;
               // print(values.keys.toList().length);
                return ChatItemWidget(user: user);
              });
      },
      valueListenable: dbHelper.getChatUsersListenable(),
    );
  }
}

class ChatItemWidget extends StatelessWidget {
  final ChatUser user;
  const ChatItemWidget({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(8),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => InChatScreen(user: user)));
          },
          leading: CircleAvatar(
            backgroundImage: FileImage(File(user.imageURL)),
            radius: 25,
          ),
          title: Text(user.name),
          trailing: Column(
            children: <Widget>[
              Text(
                user.date,
                style: !user.seen ? TEXT_STYLE2 : TEXT_STYLE3,
              ),
              SizedBox(
                height: 5,
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                child: Text(
                  user.newMessages.toString(),
                  style: TEXT_STYLE,
                ),
              )
            ],
          ),
          subtitle: Text(
            user.message,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(
          indent: 70,
        ),
      ],
    );
  }
}
