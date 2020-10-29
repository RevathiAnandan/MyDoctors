
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
  DashBoardScreen(this.mobile,this.category);
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()async{
            uid = AuthService().getCurrentUser();
            (widget.category=="MY PATIENT")?
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientNewDashboard(uid,widget.mobile)),
            )
            :
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DoctorNewDashboard(uid,widget.mobile)),
            );
          },
        ),
        backgroundColor: Colors.redAccent,
          // title: Text("My Arogya My Doctor"),
          // elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
        tabs: <Widget>[
            Tab(text: widget.category),
            Tab(
              text: "CONTACTS",
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.add,color: Colors.white),
            onPressed: (){
              _openPopup(context);
            },),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          MyScreen(widget.mobile,widget.category),
          ContactsPage(widget.mobile,widget.category),
        ],
      ),
    );
  }
  _openPopup(context) {
    Alert(
        context: context,
        title: "Add Contact",
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
              checkDuplication("+91" + phone.text, name.text, widget.category);
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }
  addPatient(String name, String phone) async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission == PermissionStatus.granted) {
      Contact newContact = new Contact();
      newContact.givenName = name;
      newContact.phones = [Item(label: "mobile", value: phone)];
      await ContactsService.addContact(newContact);
      checkmobile(name, phone);
      Navigator.of(context).pop();
    }
  }
  addDoctor(String name , String phone)async {
    final PermissionStatus permission = await Permission.contacts.status;
    if(permission == PermissionStatus.granted){
      Contact newContact = new Contact();
      newContact.givenName = name;
      newContact.phones = [
        Item(label: "mobile", value:phone)
      ];
      await ContactsService.addContact(newContact);
      checkmobile(name,phone);
      Navigator.of(context).pop();
    }
  }
  checkmobile(String pname, String pmobile) {
    var db = fb.reference().child("User");
    db.once().then((DataSnapshot snapshot) {
      ApiService().addPatientToDoctor(pmobile, widget.mobile, pname);
      ApiService().addDoctorToPatient(pmobile, widget.mobile, dname);
      AuthService().toast("Added Successfully!!");
      duplicate = false;
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        print(values);
      });
    });
  }
  checkDuplication(String phone,String name,String category){
    if(category=="MY DOCTOR"){
        var db = fb.reference().child("User").child(widget.mobile).child("myDoctor");
        db.once().then((DataSnapshot snapshot){
        Map<dynamic, dynamic > values = snapshot.value;
        print(snapshot.value);
        if(values == null){
            duplicate = false;
        }else{
            values.forEach((key,values) {
            var refreshToken = values["phone"].toString();
            if(refreshToken == phone){
                duplicate = true;
            }
            print("Values!!!"+values["phone"].toString());
            print(refreshToken);
            print(duplicate);
            });
        }
        checkDuplicate(phone,name,category);
      }
    );
    }else if(category=="MY PATIENT"){
    var db = fb.reference().child("User").child(widget.mobile).child("myPatient");
    db.once().then((DataSnapshot snapshot){
    Map<dynamic, dynamic > values = snapshot.value;
    print(snapshot.value);
    if(values == null){
    duplicate = false;
    }else{
    values.forEach((key,values) {
    var refreshToken = values["phone"].toString();
    if(refreshToken == phone){
    duplicate = true;
    }
    print("Values!!!"+values["phone"].toString());
    print(refreshToken);
    print(duplicate);
    });
    }
    checkDuplicate(phone,name,category);
    }

    );
    }


  }
  checkDuplicate(String phone,String name,String category){
    if(category=="MY PATIENT"){
      if(duplicate == false){
          addDoctor(name , phone);
          print("not"+ duplicate.toString());
      }else if(duplicate == true){
        Navigator.pop(context);
        AuthService().toast("The Number Already Exist");
        duplicate = false;
        print("exist"+ duplicate.toString());
      }
    }else if(category=="MY PATIENT"){
    if(duplicate == false){
        addPatient(name , phone);
        print("not"+ duplicate.toString());
    }else if(duplicate == true){
        Navigator.pop(context);
        AuthService().toast("The Number Already Exist");
        duplicate = false;
        print("exist"+ duplicate.toString());
    }
    }
  }

}
