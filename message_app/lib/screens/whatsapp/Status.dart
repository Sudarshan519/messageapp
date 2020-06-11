import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_app/helpers/constants.dart';
import 'package:message_app/helpers/db_helper.dart';
import 'package:message_app/models/status.dart';
import 'package:timeago/timeago.dart' as timeago;

class StatusScreen extends StatefulWidget {
  final Status statusUser;
  StatusScreen({Key key, this.statusUser}) : super(key: key);
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  Status statusUser = Status(isSeen: false);

  bool picked = false;

  showImagePicker() async {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 35,
              color: Theme.of(context).primaryColor,
              child: Text(
                'Choose Source',
                style: TEXT_STYLE.copyWith(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            ListTile(
              onTap: () {
                getImageFromSource(ImageSource.camera);
              },
              leading: Icon(Icons.camera_alt),
              title: Text("From Camera"),
            ),
            ListTile(
                onTap: () {
                  getImageFromSource(ImageSource.gallery);
                },
                leading: Icon(Icons.image),
                title: Text("From Gallery")),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(20.0),
                bottomRight: const Radius.circular(20.0)),
          ),
        );
      },
    );
  }

  getImageFromSource(source) async {
    Navigator.pop(context);
    var file = await ImagePicker.pickImage(source: source);
    setState(() {
      statusUser.imageURL = file.path;
      statusUser.isSeen = false;
      statusUser.name = "My Status";
      statusUser.timeStamp = DateTime.now().millisecondsSinceEpoch;
      int total = 10000000;
      int key = Random().nextInt(total);
      statusUser.id = key.toString();
      picked = true;
      dbHelper.editstatus(statusUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: dbHelper.getStatusListenable(),
          builder: (BuildContext context, values, Widget child) {
            var muser = Status();
            final key = values.keys.toList();
            for (var i = 0; i < key.length; i++) {
              final user = values.get(key[i]) as Status;
              if (user.name == "My Status") {
                muser = user;
              }
            }

            return GestureDetector(
              onTap: showImagePicker,
              child: ListTile(
                leading: LeadingWidget(statusUser: muser),
                title: Text(muser.name ?? "My Status"),
                subtitle: Text(muser.timeStamp != null
                    ? (timeago
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            muser?.timeStamp ?? 0))
                        .toString())
                    : "Tap to add your status"),
              ),
            );
          },
        ),
        Container(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(20.0)),
          height: ScreenUtil().setHeight(90.0),
          color: Colors.grey.shade300,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Recent updates",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            builder: (BuildContext context, Box<dynamic> values, Widget child) {
              if (values == null) return CircularProgressIndicator();
              if (values.keys.length == 0)
                return Center(
                  child: Text(
                    "No recent Updates",
                    style: TEXT_STYLE2.copyWith(color: Colors.grey),
                  ),
                );
              else
                return ListView.builder(
                  itemCount: values.keys.toList().length,
                  itemBuilder: (BuildContext context, int index) {
                    final key = values.keys.toList()[index];
                    var user;
                    final tempuser = values.get(key) as Status;
                    if (tempuser.name != "My Status") user = tempuser;
                    return user == null
                        ? SizedBox()
                        : ListTile(
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
                            subtitle: Text(timeago
                                .format(DateTime.fromMillisecondsSinceEpoch(
                                    user?.timeStamp ?? 0))
                                .toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                            ),
                          );
                  },
                );
            },
            valueListenable: dbHelper.getStatusListenable(),
          ),
        ),
      ],
    );
  }
}

class LeadingWidget extends StatefulWidget {
  const LeadingWidget({
    Key key,
    @required this.statusUser,
  }) : super(key: key);

  final Status statusUser;

  @override
  _LeadingWidgetState createState() => _LeadingWidgetState();
}

class _LeadingWidgetState extends State<LeadingWidget> {
  @override
  void didUpdateWidget(LeadingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      isSeen = widget.statusUser.isSeen ?? true;
    });
  }

  bool isSeen;
  @override
  void initState() {
    super.initState();
    isSeen = widget.statusUser.isSeen ?? true;
    setState(() {});
  }

  getImageProvider() {
    if (widget.statusUser.imageURL == null)
      return NetworkImage(
          "https://s3.amazonaws.com/wll-community-production/images/no-avatar.png");
    else
      return FileImage(File(widget.statusUser.imageURL));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
                width: 3.0,
                color: !isSeen
                    ? Theme.of(context).secondaryHeaderColor
                    : Colors.grey),
          ),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: getImageProvider(),
          ),
        ),
        widget.statusUser.imageURL == null
            ? Positioned(
                bottom: 0.0,
                right: 1.0,
                child: Container(
                  height: 20,
                  width: 20,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
