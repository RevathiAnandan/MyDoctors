
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myarogya_mydoctor/pages/chat_screen.dart';
import 'package:myarogya_mydoctor/pages/contact_screen.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_new_dashboard.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Doctor/Appointments.dart';
import 'Doctor/doctor_new_dashboard.dart';

class DashBoardScreen extends StatefulWidget {
//  final List<CameraDescription> cameras;
  final String  mobile;
  final String  category;
  final String id;
  DashBoardScreen(this.mobile,this.category,this.id);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
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


    var db = fb.reference().child("User").child(widget.mobile);
    db.once().then((DataSnapshot snapshot) {
      print(snapshot.value['Name']);
      setState(() {
        //_image =  snapshot.value['image'];
        dname = snapshot.value['Name'];
        //print ("image"+_image);
      });
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.redAccent),
            onPressed: ()async{
              (widget.category=="MY DOCTOR")?
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatientNewDashboard(widget.id,widget.mobile)),
              )
              :
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorNewDashboard(widget.id,widget.mobile)),
              );
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
              Tab(text: widget.category),
              Tab(
                text: "CONTACTS",
              ),
            ],
          ),
          actions: [
            IconButton(icon: Icon(Icons.add,color: Colors.redAccent),
              onPressed: (){
                _openPopup(context);
              },),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            MyScreen(widget.id,widget.mobile,widget.category),
            ContactsPage(widget.mobile,widget.category),
          ],
        ),
      ),
    );
  }
  _openPopup(context) {
    Alert(
        context: context,
        title: "Add "+widget.category.toLowerCase(),
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Name',
              ),
              controller: name,
            ),
            TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                icon: Icon(Icons.phone_android),
                labelText: 'Mobile Number',
              ),
              controller: phone,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: (){
              print("Button is pressed");
              print(widget.category);
              checkDuplication("+91" + phone.text, name.text);
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }

  checkDuplication(String phone,String name){
    if(widget.category == "MY PATIENT") {
      var db = fb.reference().child("User").child(widget.mobile).child(
          "myPatient");
      db.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        print(snapshot.value);
        if (values == null) {
          duplicate = false;
        } else {
          values.forEach((key, values) {
            var refreshToken = values["phone"].toString();
            if (refreshToken == phone) {
              duplicate = true;
            }
            print("Values!!!" + values["phone"].toString());
            print(refreshToken);
            print(duplicate);
          });
        }
        checkDuplicate(phone, name);
      }
      );
    }else {
      var db = fb.reference().child("User").child(widget.mobile).child(
          "myDoctor");
      db.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        print(snapshot.value);
        if (values == null) {
          duplicate = false;
        } else {
          values.forEach((key, values) {
            var refreshToken = values["phone"].toString();
            if (refreshToken == phone) {
              duplicate = true;
            }
            print("Values!!!" + values["phone"].toString());
            print(refreshToken);
            print(duplicate);
          });
        }
        checkDuplicate(phone, name);
      }
      );
    }
  }
  checkDuplicate(String mobile,String name) async{
    if(duplicate == false){
      if(widget.category == "MY PATIENT") {
        final PermissionStatus permission = await Permission.contacts.status;
        if(permission == PermissionStatus.granted){
          Contact newContact = new Contact();
          newContact.givenName = name;
          newContact.phones = [
            Item(label: "mobile", value:mobile)
          ];
          await ContactsService.addContact(newContact);
          ApiService().addPatientToDoctor(mobile, widget.mobile, name);
          ApiService().addDoctorToPatient(mobile, widget.mobile, name);
          AuthService().toast("Added Successfully");
          Navigator.of(context).pop();
        }

      }else{
        final PermissionStatus permission = await Permission.contacts.status;
        if(permission == PermissionStatus.granted){
          Contact newContact = new Contact();
          newContact.givenName = name;
          newContact.phones = [
            Item(label: "mobile", value:mobile)
          ];
          await ContactsService.addContact(newContact);
          ApiService().addPatientToDoctor(widget.mobile, mobile, name);
          ApiService().addDoctorToPatient(widget.mobile,mobile, name);
          AuthService().toast("Added Successfully");
          Navigator.of(context).pop();
        }
      }
      print("not"+ duplicate.toString());
    }else if(duplicate == true){
      Navigator.pop(context);
      AuthService().toast("The Number Already Exist");
      duplicate = false;
      print("exist"+ duplicate.toString());
    }
  }

}
