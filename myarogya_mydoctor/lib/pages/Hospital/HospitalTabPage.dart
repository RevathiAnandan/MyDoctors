
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myarogya_mydoctor/pages/Hospital/CompletedPage.dart';
import 'package:myarogya_mydoctor/pages/chat_screen.dart';
import 'package:myarogya_mydoctor/pages/contact_screen.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_new_dashboard.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'PendingPage.dart';


class HospitalTabPage extends StatefulWidget {
//  final List<CameraDescription> cameras;
  final String  mobile;
  final String id;
  HospitalTabPage(this.mobile,this.id);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  _HospitalTabPageState createState() => _HospitalTabPageState();
}

class _HospitalTabPageState extends State<HospitalTabPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;
  bool duplicate = false;
  FirebaseUser user;
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  String dname;
  FirebaseDatabase fb = FirebaseDatabase.instance;
  String uid;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 1);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.redAccent),
            onPressed: ()async{
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          // title: Text("My Arogya My Doctor"),
          // elevation: 0.7,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.redAccent,
            labelColor: Colors.redAccent,
            tabs: <Widget>[
              // Tab(text: 'PENDING',),
              Tab(
                text: "COMPLETED",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            // PendingPage(),
            CompletedPage()
//            MyScreen(widget.id,widget.mobile),
//            ContactsPage(widget.mobile),
          ],
        ),
      ),
    );
  }

}
