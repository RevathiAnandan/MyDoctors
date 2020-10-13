
import 'package:barcode_scan/barcode_scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_dashboard.dart';
import 'package:myarogya_mydoctor/pages/chat_screen.dart';
import 'package:myarogya_mydoctor/pages/contact_screen.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:permission_handler/permission_handler.dart';

import 'newdoctor.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String uid;

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => DoctorDashboard(uid, widget.mobile),
            ),
            );
          },
        ),
          actions: [
            // IconButton(
            //   iconSize:30,
            //   icon: Icon(Icons.qr_code_scanner),
            //   padding: EdgeInsets.all(15.0),
            //   onPressed: () async {
            //     String codeScanner = await BarcodeScanner.scan();    //barcode scanner
            //     //setState(() {
            //     //TODO: To display the Doctors profile after scanning barcode
            //     //qrCodeResult = codeScanner;
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) =>NewDoctorScreen(codeScanner,widget.mobile),
            //       ),);
            //     //});
            //
            //     // try{
            //     //   BarcodeScanner.scan()    this method is used to scan the QR code
            //     // }catch (e){
            //     //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
            //     //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
            //     // }
            //   },
            // )
          ],

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
