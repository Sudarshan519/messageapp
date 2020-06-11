import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:message_app/models/ChatUser.dart';
import 'package:message_app/models/Message.dart';
import 'package:message_app/models/status.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:message_app/screens/home.dart';

import 'models/CallsDetails.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await p.getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(ChatUserAdapter());
  Hive.registerAdapter(CallDetailsAdapter());
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(StatusAdapter());

  await Hive.openBox("chatUsersWhatsapp");
  await Hive.openBox("callsWhatsapp");
  await Hive.openBox("statusWhatsapp");
  await Hive.openBox("messagesWhatsapp");
  await Hive.openBox("messageWhatsapp");

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e.code + e.description);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Message App',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(7, 94, 84, 1.0),
        secondaryHeaderColor: Color.fromRGBO(37, 211, 102, 1.0),
        highlightColor: Color.fromRGBO(18, 140, 126, 1.0),
        cardColor: Color.fromRGBO(250, 250, 250, 1.0),
        accentColor: Color.fromRGBO(236, 229, 221, 1.0),
      ),
      home: Home(),
    );
  }
}

List<CameraDescription> cameras = [];
