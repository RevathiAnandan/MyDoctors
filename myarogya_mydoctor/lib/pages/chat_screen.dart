import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Appointmnet.dart';
import 'package:myarogya_mydoctor/model/MyPatient.dart';
import 'package:myarogya_mydoctor/model/chat_model.dart';
import 'package:myarogya_mydoctor/model/myDoctorModel.dart';
import 'package:myarogya_mydoctor/model/patient.dart';
import 'package:myarogya_mydoctor/pages/Doctor/createPrecription.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_PrescriptionList.dart';
import 'package:myarogya_mydoctor/pages/patient/PrescriptionList.dart';
import 'package:myarogya_mydoctor/pages/patient/showPrecription.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'dart:async';
import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';

class MyScreen extends StatefulWidget {
  String mobile;
  String category;
  String id;
  MyScreen(this.id, this.mobile, this.category);
  @override
  MyScreenState createState() {
    return new MyScreenState();
  }
}

class MyScreenState extends State<MyScreen> {
  List dummyData = [];
  List appoint = [];
  List localappoint = [];
  List<String> appointkey = [];
  List status = [];
  var buttonStatus;
  bool _isButtondisable;
  FirebaseDatabase fb = FirebaseDatabase.instance;
  var isLoading = false;
  bool appointstatus = false;
  Timer timer;
  int _widgetIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isButtondisable = false;
//    timer =
//        Timer.periodic(Duration(seconds: 5), (Timer t) => getAppointments());
    if (widget.category == "MY PATIENT") {
      getMyPatient();
    } else {
      getMyDoctor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : (dummyData.isEmpty
            ? Center(child: Text("No Data Found!!"))
            : new ListView.builder(
                itemCount: dummyData.length,
                itemBuilder: (context, i) => new Column(
                  children: <Widget>[
                    new Divider(
                      height: 10.0,
                    ),
                    new ListTile(
                      trailing: (widget.category == "MY PATIENT")?Text(""):FlatButton(
                        child: Text(
                          "Book Now",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Lato", fontSize: 14),
                        ),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.redAccent)),
                        padding: EdgeInsets.all(10),
                        color: Colors.redAccent,
                        onPressed: (){
                          ApiService().appointment(widget.mobile, dummyData[i].phone,
                              dummyData[i].name, "Waiting!",i, "", "", i.toString());
                          AuthService().toast("Requesting for Confirmation");
                          ApiService().trigger=true;
                          //todo:Enhancement should be done
                        },
                      ),
//                       leading: new CircleAvatar(
//                         foregroundColor: Theme.of(context).primaryColor,
//                         backgroundColor: Colors.grey,
// //                  backgroundImage: Image.asset('assets/images/grid.png'),
//                       ),
                      title: new Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.redAccent,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              new Text(
                                "Dr. "+dummyData[i].name != null ? "Dr. "+dummyData[i].name : "",
                                style: new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Container(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: new Text(
                                  dummyData[i].phone != null ? dummyData[i].phone : "",
                                  style:
                                  new TextStyle(color: Colors.grey, fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                      onTap: () {
                        if (widget.category == "MY PATIENT") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorPrescriptionList(
                                    widget.mobile,
                                    dummyData[i].phone,
                                    dummyData[i].name,
                                    widget.id)),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PescriptionList(
                                    dummyData[i].phone, widget.mobile)),
                          );
                        }
                      },
                    )
                  ],
                ),
              ));
  }

  Future<Patient> getMyPatient() async {
    // isLoading = true;
    try {
      var db = await fb
          .reference()
          .child("User")
          .child(widget.mobile)
          .child("myPatient");
      var db1 = db.orderByChild("MyPatient");
      db1.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Patient.fromJson(values);
          print(refreshToken);
          setState(() {
            dummyData.add(refreshToken);
            print(dummyData);
            // isLoading = false;
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Patient> getMyDoctor() async {
    // isLoading = true;
    try {
      var db = await fb
          .reference()
          .child("User")
          .child(widget.mobile)
          .child("myDoctor");
      var db1 = db.orderByChild("name");
      db1.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Patient.fromJson(values);
          print(refreshToken);
          setState(() {
            dummyData.add(refreshToken);
            print(dummyData.length);
          });
        });
      });
      getAppointments();
    } catch (e) {
      print(e);
    }
  }

  Future<Appointmnet> getAppointments() async {
    try {
      var db = await fb.reference().child("Appointment");
      var db1 = db.orderByChild("patientName");
      if (db1 != null) {
        db1.once().then((DataSnapshot snapshot) {
          print(snapshot.value);
          if (snapshot.value == null) {
            // isLoading = false;
            setState(() {
              buttonStatus = "Book Now";
            });
          } else {
            Map<dynamic, dynamic> values = snapshot.value;
            values.forEach((key, values) {
              var refreshToken = Appointmnet.fromJson(values);
              print(refreshToken);

              setState(() {
                if (refreshToken.patientMobile == widget.mobile) {
                  appoint.add(refreshToken);
                  print(appoint[0].status);
                  appointkey.add(key);
                  print(appointkey.toString());
                  // isLoading = false;
                }
              });
            });
          }
        });
      } else {
        // isLoading = false;
        setState(() {
          buttonStatus = "Book Now";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  FlatButton buttonstatus(String status, int i) {
    return FlatButton(
        onPressed: () {
          if (status == "Book Now") {
            ApiService().appointment(widget.mobile, dummyData[i].phone,
                dummyData[i].name, "Waiting!", 0, "", "", i.toString());
            AuthService().toast("Requesting for Confirmation");
            setState(() {
              buttonStatus = "Waiting!";
            });
          }
          if (status == "Waiting!") {
            //todo: Button disable
          } else if (status == "View") {
            _openPopup(context, i);
          }
        },
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.redAccent)),
        padding: EdgeInsets.all(10),
        color: Colors.redAccent,
        child: (status == "Book Now")
            ? Text(
                "Book Now",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Lato", fontSize: 14),
              )
            : Text(
                status,
                style: TextStyle(
                    color: Colors.white, fontFamily: "Lato", fontSize: 14),
              ));
  }

  _openPopup(context, index) {
    var booking_time = appoint[index].BookingTime.split(" ")[1];

    Alert(
      context: context,
      title: "Booking Information",
      buttons: [],
      content: Center(
        child: Text(
          "Booking Time:${booking_time.split(".")[0]}  Token:${appoint[index].Token}",
          textAlign: TextAlign.center,
        ),
      ),
    ).show();
  }
  // buttonfunction(String status,int i){
  //   if (status == "Book Now") {
  //     // if(i != 0){
  //     //   for (int l = 0; l <= i; l++) {
  //     //     ApiService().appointment("widget.mobile", "dummyData[i].phone",
  //     //         "dummyData[i].name", "", 0, "", "", "");
  //     //   }
  //     // }else{
  //     //   _widgetIndex=0;
  //     //   print("returing index 0");
  //     //   return buttons(_widgetIndex, i);
  //     // }
  //     // ApiService().appointment(widget.mobile, dummyData[i].phone,
  //     //     dummyData[i].name, "Waiting!", 0, "", "", i.toString());
  //     // AuthService().toast("Requesting for Confirmation");
  //     _widgetIndex=0;
  //     print("returing index 0");
  //     return buttons(_widgetIndex, i);
  //   }
  //   if (status == "Waiting!") {
  //     //todo: Button disable
  //     // if(i != 0){
  //     //   // if(i!=appoint.length) {
  //     //   //   for (int l = 0; l <= i; l++) {
  //     //   //     ApiService().appointment(
  //     //   //         "widget.mobile",
  //     //   //         "dummyData[i].phone",
  //     //   //         "dummyData[i].name",
  //     //   //         "",
  //     //   //         0,
  //     //   //         "",
  //     //   //         "",
  //     //   //         "");
  //     //   //   }
  //     //   // }
  //     //     print("returing index 1");
  //     //     //_widgetIndex=1;
  //     //     return buttons(_widgetIndex, i);
  //     //   }else{
  //         //_widgetIndex=1;
  //         print("returing index 1");
  //         return buttons(_widgetIndex, i);
  //       // }
  //
  //   } else if (status == "View") {
  //     _openPopup(context, i);
  //     _widgetIndex=2;
  //     print("returing index 1");
  //     return buttons(_widgetIndex, i);
  //   }
  // }
  // IndexedStack  buttons(int index,int i){
  //   return IndexedStack(
  //     index: index,
  //     children: [
  //       FlatButton(
  //         child: Text(
  //           "Book Now",
  //           style: TextStyle(
  //               color: Colors.white, fontFamily: "Lato", fontSize: 14),
  //         ),
  //         textColor: Colors.white,
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(25.0),
  //             side: BorderSide(color: Colors.redAccent)),
  //         padding: EdgeInsets.all(10),
  //         color: Colors.redAccent,
  //         onPressed: (){
  //           ApiService().appointment(widget.mobile, dummyData[i].phone,
  //               dummyData[i].name, "Waiting!",i, "", "", i.toString());
  //           AuthService().toast("Requesting for Confirmation");
  //           setState(() {
  //             buttonStatus = "Waiting!";
  //             _widgetIndex=1;
  //           });
  //         },
  //       ),
  //       FlatButton(
  //         child: Text(
  //           "Waiting",
  //           style: TextStyle(
  //               color: Colors.white, fontFamily: "Lato", fontSize: 14),
  //         ),
  //         textColor: Colors.white,
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(25.0),
  //             side: BorderSide(color: Colors.redAccent)),
  //         padding: EdgeInsets.all(10),
  //         color: Colors.redAccent,
  //         onPressed: (){
  //          AuthService().toast("Your Appointment is on waiting");
  //         },
  //       )
  //       ,
  //       FlatButton(
  //         child: Text(
  //           "View",
  //           style: TextStyle(
  //               color: Colors.white, fontFamily: "Lato", fontSize: 14),
  //         ),
  //         textColor: Colors.white,
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(25.0),
  //             side: BorderSide(color: Colors.redAccent)),
  //         padding: EdgeInsets.all(10),
  //         color: Colors.redAccent,
  //         onPressed: (){
  //           _openPopup(context, i);
  //         },
  //       )
  //     ],
  //
  //   );
  // }


}
