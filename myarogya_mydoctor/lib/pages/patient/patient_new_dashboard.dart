import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:myarogya_mydoctor/pages/Doctor/Appointments.dart';
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
  String id;
  String mobile;
  PatientNewDashboard(this.id,this.mobile);
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
    Text('My Hospitals'),
//    Text('My Labs'),
    Text('My Ads'),
    GestureDetector(
      onTap:() {
        AuthService().signOut(context);
      },
      child:Text('Setting'),
    ),
  ];
  final widgetName = [
    Text('  My Doctors',style: TextStyle(color: Colors.white),),
    Text('  My Hospitals',style: TextStyle(color: Colors.white),),
//    Text('My Labs'),
    Text('  My Ads',style: TextStyle(color: Colors.white),),
//    Text('Settings'),
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
    _getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // appBar: GradientAppBar(
        //   title: widgetName.elementAt(selectedIndex),
        //   backgroundColorStart: Colors.white,
        //   backgroundColorEnd: Colors.white,
        //
        // ),
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 250.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Align(
                      alignment: Alignment.bottomLeft,
                      child: widgetName.elementAt(selectedIndex),
                    ),
                    background: Image.network(
                      "https://www.connect5000.com/wp-content/uploads/2016/07/blog-pic-117-1.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                    actions: [
                      IconButton(icon: Icon(Icons.add,color: Colors.white),
                        onPressed: (){
                          _openPopup(context);
                        },),
                      IconButton(icon: Icon(Icons.account_circle,color: Colors.white),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  DashBoardScreen(
                                                                widget.mobile,
                                                                "MY DOCTOR",widget.id))
                          );
                        },),
                      PopupMenuButton<String>(
                        onSelected: choiceAction,
                        itemBuilder: (BuildContext context){
                          return Constants.choices.map((String choice){
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      )
                    ],
                ),
//                 new SliverPadding(
//                   padding: new EdgeInsets.all(1.0),
//                   sliver: new SliverList(
//                       delegate: SliverChildListDelegate([
//                         Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             // Container(
//                             //   padding: EdgeInsets.only(top: 16),
//                             //   child: Row(
//                             //     mainAxisSize: MainAxisSize.max,
//                             //     children: <Widget>[
//                             //       Column(
//                             //         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             //         children: <Widget>[
//                             //           Container(
//                             //             width: 130,
//                             //             height: 40,
//                             //             child: Card(
//                             //               color: new Color(0xffFFFFFF),
//                             //               elevation: 6,
//                             //               shape: RoundedRectangleBorder(
//                             //                   borderRadius:
//                             //                   BorderRadius.circular(20)),
//                             //               child: Center(
//                             //                   child: GestureDetector(
//                             //                       onTap: () => Navigator.push(
//                             //                         context,
//                             //                         MaterialPageRoute(
//                             //                             builder: (context) =>
//                             //                                 MyPendings(widget.id,widget.mobile,"MY DOCTOR")
//                             //                         ),
//                             //                       ),
//                             //                       child: Text("My Pendings",
//                             //                           style: new TextStyle(
//                             //                               color: Colors.redAccent,
//                             //                               fontSize: 14,
//                             //                               fontWeight: FontWeight.bold,
//                             //                               fontFamily: "Lato")))),
//                             //             ),
//                             //           ),
//                             //           Text("",
//                             //               style: new TextStyle(
//                             //                   color: Colors.black,
//                             //                   fontSize: 16,
//                             //                   fontWeight: FontWeight.bold,
//                             //                   fontFamily: "Lato")),
//                             //         ],
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                             Container(
//                               padding: EdgeInsets.only(top: 16),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                     children: <Widget>[
//                                       Container(
//                                         width: 160,
//                                         height: 40,
//                                         child: Card(
//                                           color: new Color(0xffFFFFFF),
//                                           elevation: 6,
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                               BorderRadius.circular(20)),
//                                           child: Center(
//                                               child: GestureDetector(
//                                                   onTap: () => Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             DashBoardScreen(
//                                                                 widget.mobile,
//                                                                 "MY DOCTOR",widget.id)),
//                                                   ),
//                                                   child: Text("My Doctors",
//                                                       style: new TextStyle(
//                                                           color: Colors.redAccent,
//                                                           fontSize: 14,
//                                                           fontWeight: FontWeight.bold,
//                                                           fontFamily: "Lato")))),
//                                         ),
//                                       ),
//                                       SizedBox(height: 5.0),
//                                       Text("",
//                                           style: new TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               fontFamily: "Lato")),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(top: 16),
//                               child: Row(
// //                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: <Widget>[]),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(top: 16),
//                               child: Row(
// //                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Column(
// //                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                     children: <Widget>[
//                                       Container(
//                                         width: 160,
//                                         height: 40,
//                                         child: Card(
//                                           color: new Color(0xffFFFFFF),
//                                           elevation: 6,
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                               BorderRadius.circular(20)),
//                                           child: Center(
//                                               child: GestureDetector(
//                                                   onTap: () => Navigator.pop(context),
//                                                   child: Text("My Appointments",
//                                                       style: new TextStyle(
//                                                           color: Colors.redAccent,
//                                                           fontSize: 14,
//                                                           fontWeight: FontWeight.bold,
//                                                           fontFamily: "Lato")))),
//                                         ),
//                                       ),
//                                       SizedBox(height: 5.0),
//                                       Text("",
//                                           style: new TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                               fontFamily: "Lato")),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ])),
//                 ),
              ];

            },
          body: Center(
            child: _widgetOptions()[selectedIndex],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.people,color: Colors.redAccent), title: Text('MyDoctor')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.hotel,color: Colors.redAccent), title: Text('My Hospital')),
//              BottomNavigationBarItem(icon: Icon(Icons.local_pharmacy,color: Colors.grey,size: 25), title: Text('My Labs')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list,color: Colors.redAccent), title: Text('My Ads')),
//              BottomNavigationBarItem(
//                  icon: Icon(Icons.settings,color: Colors.redAccent), title: Text('Settings'))
            ],
            currentIndex: selectedIndex,
            fixedColor: Colors.redAccent,
            onTap: onItemTapped
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
    if(choice == Constants.Profile){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProfileScreen(widget.id,widget.mobile),
        ),
      );
    }else if(choice == Constants.SignOut){
      AuthService().signOut(context);
    }else if(choice == Constants.Settings){
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
