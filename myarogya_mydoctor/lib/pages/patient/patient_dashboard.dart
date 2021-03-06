
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/patient/patientprofile.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../dashboard_screen.dart';

class PatientDashboard extends StatefulWidget {
  String id;
  String mobile;
  PatientDashboard(this.id,this.mobile);

  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  int _index = 0;
  String _image;
  String dname;
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  FirebaseDatabase fb = FirebaseDatabase.instance;
  final _formKey = GlobalKey<FormState>();
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
        print (_image);
      });
    });
    _getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      drawer: NavDrawer(),
      body: new Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left:20.0,right: 20.0,top: 10.0,bottom: 0.0),
                    height: MediaQuery.of(context).size.height * 15/100,
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
//                          Image.asset('assets/images/sidenav.png'),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PatientProfile(widget.id,widget.mobile)),
                                    );
                                  },
                                  child:new CircleAvatar(
                                    backgroundImage: (_image!= null)? new NetworkImage(_image):AssetImage('assets/images/user_profile.png'),
                                  )
                              ),
                              new Column(
                                children: [
                                  Text(dname!= null?dname:"null",style: new TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontFamily: "Lato")),
                                  Text(widget.mobile,style: new TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontFamily: "Lato")),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon:Icon(Icons.arrow_left,color: Colors.white,
                                        ),
                                        onPressed: (){
                                          AuthService().signOut(context);
                                        },
                                      ),
                                      Text("Logout",style: new TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontFamily: "Lato")),

                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text("My Doctor",style: new TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontFamily: "Lato")),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        child:  Card(
                          color: new Color(0xffACCCF8),
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: IconButton(
                              icon:Icon(Icons.add,color: Colors.white,
                              ),
                              onPressed: () {
                                _openPopup(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text("Add Doctors")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        child:  Card(
                          color: new Color(0xffACCCF8),
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Center(
//                            child: Image.asset('assets/images/grid.png')
                            child: IconButton(
                              icon:Image.asset('assets/images/grid.png'),
                              onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>DashBoardScreen(widget.mobile,"MY DOCTOR"),
//                                   ),
//                                 );
// //                                checkmobile();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text("See All")
                    ],
                  ),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  children: <Widget>[
//                    Container(
//                      width: 60,
//                      height: 60,
//                      child:  Card(
//                        color: new Color(0xffACCCF8),
//                        elevation: 6,
//                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                        child: Center(
//                          child: IconButton(
//                            icon:Icon(Icons.add,color: Colors.white,
//                            ),
//                            onPressed: ()   {
//                              Navigator.push(
//                              context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
//                            },
//                          ),
//                        ),
//                        ),
//
//                    ),
//                    SizedBox(height: 5.0),
//                    Text("View Contacts")
//                  ],
//                ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text("My Hospital",style: new TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontFamily: "Lato")),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        child:  Card(
                          color: new Color(0xffACCCF8),
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: IconButton(
                              icon:Icon(Icons.add,color: Colors.white,
                              ),
                              onPressed: () {
                                _openPopup(context);
                              },
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text("Add Doctors")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        child:  Card(
                          color: new Color(0xffACCCF8),
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Image.asset('assets/images/grid.png')
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text("See All")
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text("My Labs",style: new TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontFamily: "Lato")),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        child:  Card(
                          color: new Color(0xffACCCF8),
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: IconButton(
                              icon:Icon(Icons.add,color: Colors.white,
                              ),
                              onPressed: () {

                              },
                            ),

                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text("Add Doctors")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 60,
                        child:  Card(
                          color: new Color(0xffACCCF8),
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Center(
//                              child: Image.asset('assets/images/grid.png')
                            child: IconButton(
                              icon:Image.asset('assets/images/grid.png'),
                              onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>DashBoardScreen(widget.mobile,"MY DOCTOR"),
//                                   ),
//                                 );
// //                                checkmobile();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text("See All")
                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
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
              addDoctor(name.text,"+91"+phone.text);
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

  checkmobile(String pname,String phone){
    var db = fb.reference().child("User");
    db.once().then((DataSnapshot snapshot){
//      print("snapshot${snapshot.value}");

      Map<dynamic, dynamic > values = snapshot.value;
      values.forEach((key,values) {
//        print(values);
//        if(key == pname) {
        var refreshToken = values;
        print(refreshToken);
        if(values['phone'] == phone) {
          print("Already Number Exist");
        AuthService().toast("The Number already Exists");
        }else{
          ApiService().addPatientToDoctor(widget.mobile,phone,dname);
          ApiService().addDoctorToPatient(widget.mobile,phone,pname);
        }
//        }else{
//          //Sent an Invite to  this number to install the app.
//
//        }
      });
    });
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



}


