import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_app/helpers/constants.dart';
import 'package:message_app/helpers/db_helper.dart';
import 'package:message_app/models/ChatUser.dart';

class EditChats extends StatefulWidget {
  final ChatUser chatUser;

  EditChats({Key key, this.chatUser}) : super(key: key);

  @override
  _EditChatsState createState() => _EditChatsState();
}

class _EditChatsState extends State<EditChats> {
  bool isEdit = false;
  final focus1 = FocusNode(), focus2 = FocusNode(), focus3 = FocusNode();
  bool autovalidate = false;
  @override
  void initState() {
    super.initState();
    if (widget.chatUser != null) {
      setState(() {
        this.chatUser = widget.chatUser;
        a.text = chatUser.name;
        b.text = chatUser.message;
        c.text = chatUser.date;
        d.text = chatUser.newMessages.toString();
        isEdit = true;
      });
    }
  }

  ChatUser chatUser = ChatUser(seen: false, sent: false);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

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
                child: Column(
                  children: <Widget>[
                    Text(
                      'Choose Source',
                      style: TEXT_STYLE.copyWith(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
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

  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();
  TextEditingController c = TextEditingController();
  TextEditingController d = TextEditingController();

  getImageFromSource(source) async {
    Navigator.pop(context);
    var file = await ImagePicker.pickImage(source: source);
    setState(() {
      if (file != null) {
        chatUser.imageURL = file.path;
      }
    });
  }

  void showSnackBar(String value, var color) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: color,
    ));
  }

  void saveButtonAction(context) {
    if (!_formKey.currentState.validate()) {
      showSnackBar('Please Don\'t Leave Any Field Empty', Colors.redAccent);
    } else if (chatUser.imageURL == null) {
      showSnackBar("Please Choose An Image  To Continue", Colors.redAccent);
    } else {
      _formKey.currentState.save();
      int total = 10000000;
      int key = Random().nextInt(total);
      if (isEdit) {
        dbHelper.editChatUser(chatUser);
      } else {
        chatUser.id = key.toString();
        dbHelper.editChatUser(chatUser);
        Navigator.pop(context);
      }
      isEdit != true
          ? showSnackBar("New Chat Is Added", Colors.green)
          : showSnackBar("Chat Is Edited", Colors.green);
    }
  }

  getImageProvider() {
    if (chatUser?.imageURL != null) return FileImage(File(chatUser.imageURL));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: isEdit == true ? Text("Edit Chat") : Text('Add Chat'),
      ),
      body: Form(
        autovalidate: autovalidate,
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: showImagePicker,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 70,
                  child: Align(
                    alignment: Alignment.centerRight,
                                      child: Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                  backgroundImage: getImageProvider(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: a,
                  onSaved: (val) {
                    chatUser.name = val.trim();
                  },
                  validator: (v) {
                    if (v.isEmpty) return 'This field can\'t be empty';
                    return null;
                  },
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(focus1);
                  },
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Jhon Doe',
                      labelText: 'Name'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  focusNode: focus1,
                  controller: b,
                  onSaved: (val) {
                    chatUser.message = val.trim();
                  },
                  validator: (v) {
                    if (v.isEmpty) return 'This field can\'t be empty';
                    return null;
                  },
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(focus2);
                  },
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Hi! whats up',
                      labelText: 'Message'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  focusNode: focus2,
                  controller: c,
                  keyboardType: TextInputType.datetime,
                  onSaved: (val) {
                    chatUser.date = val.trim();
                  },
                  validator: (v) {
                    if (v.isEmpty) return 'This field can\'t be empty';
                    return null;
                  },
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).requestFocus(focus3);
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'dd/mm/yyyy',
                      labelText: 'Date'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  focusNode: focus3,
                  controller: d,
                  keyboardType: TextInputType.number,
                  onSaved: (val) {
                    chatUser.newMessages = int.parse(val.trim());
                  },
                  validator: (v) {
                    if (v.isEmpty) return 'This field can\'t be empty';
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '2',
                      labelText: 'New Message count'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                  title: Text(
                    'Seen',
                    style: TextStyle(color: Colors.grey),
                  ),
                  activeColor: Colors.amber,
                  value: chatUser?.seen ?? false,
                  onChanged: (v) {
                    setState(() {
                      chatUser.seen = v;
                    });
                  }),
              SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                  title: Text(
                    'Sent',
                    style: TextStyle(color: Colors.grey),
                  ),
                  activeColor: Colors.amber,
                  value: chatUser?.sent ?? false,
                  onChanged: (v) {
                    setState(() {
                      chatUser.sent = v;
                    });
                  }),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    autovalidate = true;
                  });

                  saveButtonAction(context);
                },
                child: isEdit == true ? Text('Edit') : Text('Save'),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
