
import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/Doctor/update_profile_screen.dart';
import 'package:myarogya_mydoctor/pages/patient/NavDrawer.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/push_notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../dashboard_screen.dart';
import 'package:myarogya_mydoctor/pages/contact_screen.dart';
class DoctorDashboard extends StatefulWidget {
  String id;
  String mobile;
  DoctorDashboard(this.id,this.mobile);
  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  bool imageSet = false;
  String _image;
  String dname;
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseDatabase fb = FirebaseDatabase.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var db = fb.reference().child("User").child(widget.mobile);
    db.once().then((DataSnapshot snapshot){
      print (snapshot.value['Name']);
      setState(() {
        _image =  snapshot.value['image'];
        dname =  snapshot.value['Name'];
        print ("image"+_image);
      });
    });
    _getPermission();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: new Container(
          child: ListView(
            children: <Widget>[
              Column(
                children:
                <Widget>[
                  Container(
                      padding: EdgeInsets.only(left:20.0,right: 20.0,top: 10.0,bottom: 0.0),
                      height: MediaQuery.of(context).size.height/4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(
                            bottomLeft:Radius.circular(15) ,
                            bottomRight: Radius.circular(15)
                        ),
                      ),
                      child:Center(
                        child:  Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => NavDrawer(widget.mobile,dname)),
                                    );
                                  },
                                  child: Image.asset('assets/images/sidenav.png'),
                                ),
                                GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ProfileScreen(widget.id,widget.mobile)),
                                      );
                                    },
                                    child:new CircleAvatar(
                                      radius: 30,
                                      backgroundImage: (_image!= null)? new NetworkImage(_image):AssetImage('assets/images/user_profile.png'),
                                    )
                                ),
                              ],
                            ),
                            new Column(
                                children: [
                                  Text((dname== null)? "Hi" :dname,style: new TextStyle(color:Colors.white,fontSize: 35,fontWeight: FontWeight.bold,fontFamily: "Lato")),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(widget.mobile,style: new TextStyle(color:Colors.white,fontSize: 20,fontFamily: "Lato")),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     IconButton(
                                  //       icon:Icon(Icons.arrow_left,color: Colors.white,
                                  //       ),
                                  //       onPressed: (){
                                  //         AuthService().signOut(context);
                                  //       },
                                  //     ),
                                  //     Text("Logout",style: new TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontFamily: "Lato")),
                                  //
                                  //   ],
                                  // )
                                ]
                            )
                          ],
                        ),
                      )

                  )
                ],
              ),
              Container(
                height: 550,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 25,top: 16,right: 16,bottom: 16),
                      child: Text("My Patients",style: new TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Lato")),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      height: 120,
                      width: 350,
                      //color: Color.fromRGBO(245,247,250,0),
                      padding: EdgeInsets.only(bottom: 16,left: 16,right: 16,top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 60,
                                child:  GestureDetector(
                                  onTap: (){
                                    _openPopup(context);
//                                checkmobile();
                                  },
                                  child: Card(
                                    color: Color(0xff1264D1),
                                    //color: new Color(0xffACCCF8),
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    child: Center(
                                        child: Text('Add Patient',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)
//                               IconButton(
//                                 icon:Icon(Icons.add,color: Colors.white,
//                                 ),
//                                 onPressed: () {
//                                   _openPopup(context);
// //                                checkmobile();
//                                 },
//                               ),

                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 60,
                                child:  GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>DashBoardScreen(widget.mobile,"MY PATIENT"),
                                    //   ),
                                    // );
//                                checkmobile();
                                  },
                                  child: Card(
                                    color: Color(0xff1264D1),
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    child: Center(
                                        child: Text('See All',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),
                                        )
                                      //IconButton(
//                                 color: Colors.white,
//                                 icon:Image.asset('assets/images/grid.png'),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>DashBoardScreen(widget.mobile,"MY PATIENT"),
//                                     ),
//                                   );
// //                                checkmobile();
//                                 },
//                               ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 25,top: 16,right: 16,bottom: 16),
                      child: Text("My Hospital",style: new TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Lato")),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 16,left: 16,right: 16,top: 25),
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 60,
                                child:  Card(
                                  color: Color(0xff1264D1),
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  child: GestureDetector(
                                    onTap: (){
                                      PushNotificationService().sendAndRetrieveMessage();
                                    },
                                    child: Center(
//                              child: Image.asset('assets/images/grid.png')
                                        child: Text('Add Hospitals',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)
                                      // child: Center(
                                      //   child: IconButton(
                                      //     icon:Icon(Icons.add,color: Colors.white,
                                      //     ),
                                      //     onPressed: () {
                                      //       PushNotificationService().sendAndRetrieveMessage();
                                      //     },
                                      //   ),

                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 60,
                                child:  Card(
                                  color: Color(0xff1264D1),
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  child: Center(
//                              child: Image.asset('assets/images/grid.png')
                                      child: Text('See All',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 25,top: 16,right: 16,bottom: 16),
                      child: Text("My Labs",style: new TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Lato")),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 16,left: 16,right: 16,top: 25),
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 60,
                                child:  Card(
                                  color: Color(0xff1264D1),
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  child: Center(
//                              child: Image.asset('assets/images/grid.png')
                                      child: Text('Add Labs',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)
                                    // child: Center(
                                    //   child: IconButton(
                                    //     icon:Icon(Icons.add,color: Colors.white,
                                    //     ),
                                    //     onPressed: () {
                                    //
                                    //     },
                                    //   ),

                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 60,
                                child:  Card(
                                  color: new Color(0xff1264D1),
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  child: Center(
//                              child: Image.asset('assets/images/grid.png')
                                      child: Text('See All',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)
                                    // child: Center(
                                    //   child: IconButton(
                                    //     icon:Icon(Icons.add,color: Colors.white,
                                    //     ),
                                    //     onPressed: () {
                                    //
                                    //     },
                                    //   ),

                                  ),
                                  // child: Center(
                                  //     child: Image.asset('assets/images/grid.png')
                                  // ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                            ],
                          ),
//
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> createAlertDialog(BuildContext context){
    return showDialog(context: context,
        builder: (context){
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("Add Contact"),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
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
              decoration: InputDecoration(
                icon: Icon(Icons.phone_android),
                labelText: 'Mobile Number',
              ),
              controller: phone,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: (){
              addPatient(name.text,"+91"+phone.text);
              // int index;
              // Contact contact = _contacts?.elementAt(index);
              // for(int i=0;i<_contacts.length;i++){
              //   // ignore: unrelated_type_equality_checks
              //   if("+91${phone.text}" == contact.phones.elementAt(i).value){
              //     AuthService().toast("The Number already Exists");
              //   }else{
              //     addPatient(name.text,"+91"+phone.text);
              //   }
              // }
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
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
  addPatient(String name , String phone)async {
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
  checkmobile(String pname,String pmobile){
    var db = fb.reference().child("User").child(widget.mobile);
    db.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic > values = snapshot.value;
      values.forEach((key,values) {
        print(values);
//        if(values['phone'] == pmobile) {
//          print("Already Number Exist");
//          AuthService().toast("The Number already Exists");
//        }
//        else{
          ApiService().addPatientToDoctor(pmobile,widget.mobile,pname);
          ApiService().addDoctorToPatient(pmobile,widget.mobile,dname);
//        }
//        }else{
//          //Sent an Invite to  this number to install the app.
//
//        }
      });
    });
  }



}
