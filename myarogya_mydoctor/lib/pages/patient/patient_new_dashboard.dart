import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:myarogya_mydoctor/improvement/hospitals.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';
import 'package:myarogya_mydoctor/pages/Ads/home_page.dart';
import 'package:myarogya_mydoctor/pages/Doctor/Appointments.dart';
import 'package:myarogya_mydoctor/pages/complains/DisplayComplains.dart';
import 'package:myarogya_mydoctor/pages/dashboard_screen.dart';

import 'package:myarogya_mydoctor/pages/patient/NavDrawer.dart';

import 'package:myarogya_mydoctor/pages/Doctor/update_profile_screen.dart';
import 'package:myarogya_mydoctor/pages/patient/mypendings.dart';
import 'package:myarogya_mydoctor/pages/patient/patientprofile.dart';
import 'package:myarogya_mydoctor/pages/patient/patientsettings.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../chat_screen.dart';
class PatientNewDashboard extends StatefulWidget {
  final String id;
  final String mobile;
  final String category;
  PatientNewDashboard(this.id,this.mobile,this.category);
  @override
  _PatientNewDashboardState createState() => _PatientNewDashboardState();
}

class _PatientNewDashboardState extends State<PatientNewDashboard> {
  int selectedIndex = 0;
  bool duplicate = false;
  String dname;
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  FirebaseDatabase fb = FirebaseDatabase.instance;
  final _formKey = GlobalKey<FormState>();

  List<Widget> _widgetOptions() => [
    MyPendings(widget.id,widget.mobile,"MY DOCTOR"),
    Hospitals(widget.mobile,widget.id,widget.category),
    HomeScreen(widget.id,widget.mobile),
    DisplayComplains(widget.id,widget.mobile)
  ];
  final widgetName = [
    Text('  My Appointments',style: TextStyle(color: Colors.white),),
    Text('  My Hospitals',style: TextStyle(color: Colors.white),),
    Text('  My Ads',style: TextStyle(color: Colors.white),),
    Text('  My Complains',style: TextStyle(color: Colors.white),),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPermission();
    var db = fb.reference().child("User").child(widget.mobile);
    db.once().then((DataSnapshot snapshot){
      print (snapshot.value['Name']);
      setState(() {
        dname =  snapshot.value['Name'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          // appBar: GradientAppBar(
          //   title: widgetName.elementAt(selectedIndex),
          //   backgroundColorStart: Colors.white,
          //   backgroundColorEnd: Colors.white,
          //
          // ),
          body: Center(
            child: _widgetOptions()[selectedIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle: TextStyle(color: Colors.redAccent),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.people,color: Colors.redAccent), title: Text('Appointments')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.hotel,color: Colors.redAccent), title: Text('My Hospital')),
//              BottomNavigationBarItem(icon: Icon(Icons.local_pharmacy,color: Colors.grey,size: 25), title: Text('My Labs')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list,color: Colors.redAccent), title: Text('My Ads')),
             BottomNavigationBarItem(
                 icon: Icon(Icons.add_comment,color: Colors.redAccent), title: Text('My Complains'))
              ],
              currentIndex: selectedIndex,
              fixedColor: Colors.redAccent,
              onTap: onItemTapped
          ),
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  _openPopup(context) {
    Alert(
        context: context,
        title: "Add my doctor",
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
              checkDuplication("+91"+phone.text,name.text);
//              addDoctor(name.text,"+91"+phone.text);
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
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
  checkmobile(String pname,String phone){
    var db = fb.reference().child("User");
    db.once().then((DataSnapshot snapshot){
      ApiService().addPatientToDoctor(widget.mobile,phone,dname);
      ApiService().addDoctorToPatient(widget.mobile,phone,pname);
      AuthService().toast("Added Successfully!!");
      duplicate = false;
      Map<dynamic, dynamic > values = snapshot.value;
      values.forEach((key,values) {
        var refreshToken = values;
        print(refreshToken);
      });
    });
  }
  checkDuplication(String phone,String name){
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
      checkDuplicate(phone,name);
    }

    );

  }
  checkDuplicate(String phone,String name){
    if(duplicate == false){
      addDoctor(name , phone);
      print("not"+ duplicate.toString());
    }else if(duplicate == true){
      Navigator.pop(context);
      AuthService().toast("The Number Already Exist");
      duplicate = false;
      print("exist"+ duplicate.toString());
    }
  }
  void choiceAction(String choice){
    // if(choice == ConstantsD.Profile){
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) =>
    //           ProfileScreen(widget.id,widget.mobile),
    //     ),
    //   );
    // }else
      if(choice == ConstantsD.Settings){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PatientSettings(widget.id,widget.mobile),
        ),
      );
    }
  }

}
