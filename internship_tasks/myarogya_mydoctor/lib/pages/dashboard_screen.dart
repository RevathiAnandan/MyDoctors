
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/chat_screen.dart';
import 'package:myarogya_mydoctor/pages/contact_screen.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:permission_handler/permission_handler.dart';

class DashBoardScreen extends StatefulWidget {
//  final List<CameraDescription> cameras;
  final String  mobile;
  final String  category;
  DashBoardScreen(this.mobile,this.category);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
      with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;
  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    _getPermission();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }


//Get Contact Permission//
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Arogya My Doctor"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
//            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: widget.category),
//            Tab(
//              text: "STATUS",
//            ),
            Tab(
              text: "CONTACTS",
            ),
          ],
        ),
//        actions: <Widget>[
//          Icon(Icons.search),
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 5.0),
//          ),
//         IconButton(
//           icon:Icon(Icons.more_vert),
//           onPressed: (){
//
//           },
//         )
//        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          MyScreen(widget.mobile,widget.category),
          ContactsPage(widget.mobile,widget.category),
        ],
      ),
//      floatingActionButton: showFab
//          ? FloatingActionButton(
//        backgroundColor: Theme.of(context).accentColor,
//        child: Icon(
//          Icons.message,
//          color: Colors.white,
//        ),
//        onPressed: () async{
//
//        },
//      )
//          : null,
    );
  }
}
