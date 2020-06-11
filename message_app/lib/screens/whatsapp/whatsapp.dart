import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:message_app/screens/whatsapp/chats_list.dart';
import 'package:message_app/screens/whatsapp/status_list.dart';
import 'call_lists.dart';
import 'Calls.dart';
import 'Camera.dart';
import 'Status.dart';
import 'chats.dart';

class WhatsappScreen extends StatefulWidget {
  @override
  _WhatsappScreenState createState() => _WhatsappScreenState();
}

class _WhatsappScreenState extends State<WhatsappScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double tabWidth = MediaQuery.of(context).size.width / 5;
    ScreenUtil.init(context);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: Text("WhatsApp"),
          actions: <Widget>[
            Icon(
              Icons.search,
            ),
            SizedBox(),
            Icon(Icons.more_vert)
          ],
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: [
              Container(
                padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(15.0)),
                alignment: Alignment.bottomCenter,
                child: Center(
                    child: Icon(
                  Icons.camera_alt,
                  size: ScreenUtil().setSp(40.0),
                )),
              ),
              Container(
                  height: ScreenUtil().setHeight(50.0),
                  alignment: Alignment.center,
                  width: tabWidth,
                  child: Text("CHATS")),
              Container(
                height: ScreenUtil().setHeight(50.0),
                alignment: Alignment.center,
                width: tabWidth,
                child: Text("STATUS"),
              ),
              Container(
                height: ScreenUtil().setHeight(50.0),
                alignment: Alignment.center,
                width: tabWidth,
                child: Text("CALLS"),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            CameraScreen(),
            ChatScreen(),
            StatusScreen(),
            CallsScreen()
          ],
        ),
        floatingActionButton: _buildFAB(_tabController.index));
  }

  Widget _buildFAB(int index) {
    if (index == 1) {
      return FloatingActionButton(
        heroTag: "btn1",
        onPressed: () {
          //dbHelper.clearHieve();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => ChatList()));
        },
        child: Icon(
          Icons.message,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      );
    } else if (index == 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {},
            mini: true,
            child: Icon(
              Icons.create,
              color: Theme.of(context).primaryColor,
            ),
            backgroundColor: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(12.0),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (a) => StatusList()));
            },
            child: Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).secondaryHeaderColor,
          ),
        ],
      );
    } else if (index == 3) {
      return FloatingActionButton(
        heroTag: "btn3",
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => CallLists()));
        },
        child: Icon(
          Icons.add_call,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      );
    } else
      return SizedBox();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
