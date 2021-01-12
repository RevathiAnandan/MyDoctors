import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Booking.dart';
import 'package:myarogya_mydoctor/pages/settings/disclaimer.dart';
import 'package:myarogya_mydoctor/pages/settings/myincome.dart';
import 'package:myarogya_mydoctor/pages/settings/privacy.dart';
import 'package:myarogya_mydoctor/pages/settings/termsandconditions.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'CompletedPage.dart';
import 'HospitalTabPage.dart';

class HospitalSettings extends StatefulWidget {
  final String id;
  final String mobile;
  final String category;


  HospitalSettings(this.id, this.mobile,this.category);

  @override
  _HospitalSettingsState createState() => _HospitalSettingsState();
}

class _HospitalSettingsState extends State<HospitalSettings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    getBooking();
  }
  List<Booking> dummyData = [];
  List refresh = [];
  List keys1 = [];
  FirebaseDatabase fb = FirebaseDatabase.instance;
  int myincome = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // Container(
              //   height: 60,
              //   width: MediaQuery.of(context).size.width,
              //   child: InkWell(
              //     onTap: (){
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) =>
              //                 EditProfileDoctor(widget.id,widget.mobile)
              //         ),
              //       );
              //     },
              //     child: Card(
              //       child: Row(
              //         children: [
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Icon(Icons.person,size: 30,color: Colors.redAccent,),
              //           SizedBox(
              //             width: 20,
              //           ),
              //           Text(
              //             "Edit Profile",
              //             style: TextStyle(
              //               color: Colors.redAccent,
              //               fontSize: 20.0,
              //               fontFamily: 'Lato',
              //               fontWeight: FontWeight.bold,
              //             ),)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              // InkWell(
              //   onTap: ()=>Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => MyIncomePage("My Income",widget.mobile)),
              //   ),
              //   child: Container(
              //     height: 60,
              //     width: MediaQuery.of(context).size.width,
              //     child: Card(
              //       child: Row(
              //         children: [
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Icon(Icons.memory,size: 30,color: Colors.redAccent,),
              //           SizedBox(
              //             width: 20,
              //           ),
              //           Text(
              //             "My Income",
              //             style: TextStyle(
              //               color: Colors.redAccent,
              //               fontSize: 20.0,
              //               fontFamily: 'Lato',
              //               fontWeight: FontWeight.bold,
              //             ),),
              //           SizedBox(
              //             width:140,
              //           ),
              //           Text(
              //             "Rs."+((myincome/100).toString().split(".")[0]),
              //             style: TextStyle(
              //               color: Colors.redAccent,
              //               fontSize: 20.0,
              //               fontFamily: 'Lato',
              //               fontWeight: FontWeight.bold,
              //             ),)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CompletedPage(widget.id,widget.mobile,widget.category)
                      ),
                    );
                  },
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.person,size: 30,color: Colors.redAccent,),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "My Hospital",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyIncomePage("My Income",widget.mobile),
                        ),
                      );
                    },
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.memory,size: 30,color: Colors.redAccent,),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "My Income",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.pan_tool,size: 30,color: Colors.redAccent,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "My Investment in this startup",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Privacy()),
                ),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.priority_high,size: 30,color: Colors.redAccent,),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Privacy",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Termsandconditions()),
                ),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.border_color,size: 30,color: Colors.redAccent,),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Terms and Conditions",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
              onTap: ()=>Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Disclaimer()),),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.local_offer,size: 30,color: Colors.redAccent,),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Disclaimer",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
              // Container(
              //   height: 60,
              //   width: MediaQuery.of(context).size.width,
              //   child: InkWell(
              //     onTap: (){
              //       _createDynamicLink(true);
              //     },
              //     child: Card(
              //       child: Row(
              //         children: [
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Icon(Icons.people,size: 30,color: Colors.redAccent,),
              //           SizedBox(
              //             width: 20,
              //           ),
              //           Text(
              //             "Invite a Friend",
              //             style: TextStyle(
              //               color: Colors.redAccent,
              //               fontSize: 20.0,
              //               fontFamily: 'Lato',
              //               fontWeight: FontWeight.bold,
              //             ),)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: (){
                    _openPopup(context);
                    // AuthService().signOut(context);
                  },
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.file_upload,size: 30,color: Colors.redAccent,),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Log Out",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Booking> getBooking() async {
    try {
      var db = await fb.reference().child("HospitalBookings");
      db.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Booking.fromJson(values);
          print(refreshToken);
          setState(() {
            if (refreshToken.bookingNumber == widget.mobile) {
              dummyData.add(refreshToken);
              keys1.add(key);
            }
          });
        });
        print(dummyData);
        setState(() {
          myincome = dummyData.length*4000;
        });
      });
    } catch (e) {
      print(e);
    }
  }
  _openPopup(context) {
    Alert(
      context: context,
      title: "Log out",
      buttons: [
        DialogButton(child: Text("Log out",style: TextStyle(color: Colors.white),), onPressed:(){
          AuthService().signOut(context);
        }),
        DialogButton(child: Text("Cancel",style: TextStyle(color: Colors.white),), onPressed:(){
          Navigator.pop(context);
        }),
      ],
      content: Center(
        child: Text(
          "Are you sure?",
          textAlign: TextAlign.center,
        ),
      ),
    ).show();
  }
}
