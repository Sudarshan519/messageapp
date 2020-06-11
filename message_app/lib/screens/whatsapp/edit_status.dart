import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_app/models/status.dart';
import '../../helpers/constants.dart';
import '../../helpers/db_helper.dart';

class EditStatus extends StatefulWidget {
  final Status statusUser;

  const EditStatus({Key key, this.statusUser}) : super(key: key);
  @override
  _EditStatusState createState() => _EditStatusState();
}

class _EditStatusState extends State<EditStatus> {
  bool isEdit = false;
  bool autovalidate = false;
  final focus1 = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.statusUser != null) {
      setState(() {
        this.statusUser = widget.statusUser;
        a.text = statusUser.name;
        b.text = statusUser.imageURL;
        isEdit = true;
      });
    }
  }

  Status statusUser = Status(isSeen: false);
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

  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();

  getImageFromSource(source) async {
    Navigator.pop(context);
    var file = await ImagePicker.pickImage(source: source);
    setState(() {
      statusUser.imageURL = file.path;
    });
  }

  void showSnackBar(String value, var color) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      backgroundColor: color,
    ));
  }

  void saveButtonAction() {
    if (!_formKey.currentState.validate()) {
      showSnackBar('Please Don\'t Leave Any Field Empty', Colors.redAccent);
    } else if (statusUser.imageURL == null) {
      showSnackBar("Please Choose An Image  To Continue", Colors.redAccent);
    } else {
      _formKey.currentState.save();
      int total = 10000000;
      int key = Random().nextInt(total);
      if (isEdit) {
        dbHelper.editstatus(statusUser);
      } else {
        statusUser.id = key.toString();
        statusUser.timeStamp = DateTime.now().millisecondsSinceEpoch;
        dbHelper.editstatus(statusUser);
      }
      isEdit != true
          ? showSnackBar("New Status Is Added", Colors.green)
          : showSnackBar("Status Is Edited", Colors.green);
    }
  }

  getImageProvider() {
    if (statusUser?.imageURL != null)
      return FileImage(File(statusUser.imageURL));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: isEdit == true ? Text('Edit Status') : Text('Add Status'),
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
                  child: Icon(
                    Icons.add_a_photo,
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
                    statusUser.name = val.trim();
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
              SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                  title: Text(
                    'Seen',
                    style: TextStyle(color: Colors.grey),
                  ),
                  activeColor: Colors.amber,
                  value: statusUser?.isSeen ?? false,
                  onChanged: (v) {
                    setState(() {
                      statusUser.isSeen = v;
                    });
                  }),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    autovalidate = true;
                  });
                  saveButtonAction();
                  Navigator.pop(context);
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
