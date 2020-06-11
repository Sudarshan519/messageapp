import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:message_app/helpers/db_helper.dart';

import 'package:message_app/helpers/my_flutter_app_icons.dart';
import 'package:message_app/helpers/utils.dart';
import 'package:message_app/models/ChatUser.dart';
import 'package:message_app/models/Message.dart';
//import 'package:message_app/widgets/custom_input.dart';

class InChatScreen extends StatefulWidget {
  final ChatUser user;

  InChatScreen({@required this.user});
  @override
  _InChatScreenState createState() => _InChatScreenState();
}

class _InChatScreenState extends State<InChatScreen> {
  final ScrollController listScrollController = new ScrollController();
  TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //  _messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          titleSpacing: 0.0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
            IconButton(icon: Icon(Icons.call), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: FileImage(File(widget.user.imageURL)),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(10.0), 0.0, 0.0, 0.0),
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: Text(
                    widget.user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: ScreenUtil().setSp(50.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ValueListenableBuilder(
              builder: (BuildContext context, values, Widget child) {
                return ListView.builder(
                  controller: listScrollController,
                  itemCount: values.keys.toList().length,
                  itemBuilder: (context, index) {
                    final key = values.keys.toList()[index];
                    final message = values.get(key) as Message;
                    return MessageCard(
                      message: message,
                      index: index,
                    );
                  },
                );
              },
              valueListenable: dbHelper.getWhatsappMessagesListenable(),
            )),
            customInput(_messageController),
          ],
        ));
  }

  Widget customInput(_messageController) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 30,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    onChanged: (val) {
                      if (val.trim().length > 0) {
                      } else
                        setState(() {});
                    },
                    controller: _messageController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(
                              right: ScreenUtil().setWidth(20.0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.attachment,
                                color: Colors.grey,
                              ),
                              SizedBox(width: ScreenUtil().setWidth(15.0)),
                              Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.sentiment_satisfied,
                          size: ScreenUtil().setSp(70.0),
                          color: Colors.grey,
                        )),
                  ),
                ),
              ),
            ),
            CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).primaryColor,
                child: Center(
                  child: IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 15,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        int key = DateTime.now().millisecondsSinceEpoch;

                        Message message = Message()
                          ..id = key.toString()
                          ..isImage = false
                          ..isMe = key.isOdd
                          ..msg = _messageController.text.trim()
                          ..seen = true
                          ..timeStamp = DateTime.now().millisecondsSinceEpoch
                          ..sent = false
                          ..received = false;

                        dbHelper.addWhatsappMessages(message);
                        listScrollController.animateTo(0.0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                        _messageController.clear();
                      }),
                ))
          ],
        ),
      ),
    );
  }
}

class MessageCard extends StatefulWidget {
  final Message message;
  final int index;

  const MessageCard({Key key, this.message, this.index}) : super(key: key);
  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    
    //make image and list proper sorting
    return widget.message.isMe
        ? Bubble(
            // padding: BubbleEdges.fromLTRB(0, 0, 0, 10),
            margin: BubbleEdges.only(
              top: widget.index == 0 ? 10 : 5,
              left: ScreenUtil().setWidth(100.0),
            ),
            nip: BubbleNip.rightTop,
            color: Color.fromRGBO(225, 255, 199, 1.0),
            nipHeight: ScreenUtil().setHeight(12.0),
            alignment: Alignment.centerRight,
            elevation: 0.4,
            child: Wrap(
              alignment: WrapAlignment.end,
              children: <Widget>[
                Text(
                  widget.message.msg,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20.0),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        getFormattedTime(widget.message.timeStamp),
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(15.0)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Icon(
                        widget.message.sent
                            ? Icons.check
                            : MyFlutterApp.icons8_double_tick_50,
                        color: widget.message.seen ? Colors.blue : Colors.grey,
                        size: ScreenUtil().setSp(35.0),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        : Bubble(
            margin: BubbleEdges.only(
                top: ScreenUtil().setHeight(5.0),
                right: ScreenUtil().setWidth(100.0)),
            nip: BubbleNip.leftTop,
            nipHeight: ScreenUtil().setHeight(12.0),
            alignment: Alignment.centerLeft,
            elevation: 0.4,
            child: Wrap(
              alignment: WrapAlignment.end,
              children: <Widget>[
                Text(
                  widget.message.msg,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: ScreenUtil().setWidth(20.0)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    getFormattedTime(widget.message.timeStamp),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
              ],
            ),
          );
  }
}
