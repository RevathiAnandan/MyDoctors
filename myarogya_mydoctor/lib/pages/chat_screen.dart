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
  MyScreen(this.mobile, this.category);
  @override
  MyScreenState createState() {
    return new MyScreenState();
  }
}

class MyScreenState extends State<MyScreen> {
  List dummyData = [];
  List appoint = [];
  bool _isButtondisable;
  FirebaseDatabase fb = FirebaseDatabase.instance;
  var isLoading = false;
  bool appointstatus = false;
  Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isButtondisable = false;
    timer =
        Timer.periodic(Duration(seconds: 15), (Timer t) => getAppointments());
    if (widget.category == "MY PATIENT") {
      getMyPatient();
    } else {
      getMyDoctor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center( child:CircularProgressIndicator())
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
                      leading: new CircleAvatar(
                        foregroundColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.grey,
//                  backgroundImage: Image.asset('assets/images/grid.png'),
                      ),
                      title: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            dummyData[i].name != null ? dummyData[i].name : "",
                            style: new TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      subtitle: new Container(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: new Text(
                          dummyData[i].phone != null ? dummyData[i].phone : "",
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                      ),
                      trailing: (widget.category == "MY PATIENT")?Text(" "):buttonstatus(appoint[i].status,i),
                         // : buttonstatus(appoint[i].status,i),
                      // trailing: FlatButton(
                      //   child: Text(
                      //     "Book Now",
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontFamily: "Lato",
                      //         fontSize: 14),
                      //   ),
                      //   textColor: Colors.white,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(25.0),
                      //       side: BorderSide(color: Colors.redAccent)),
                      //   padding: EdgeInsets.all(10),
                      //     onPressed: () async {
                      //       ApiService().appointment(widget.mobile,
                      //           dummyData[i].phone, dummyData[i].name, "Waiting",0,"","");
                      //       AuthService().toast("Requesting for Confirmation");
                      //     },
                      //   color: Colors.redAccent,
                      // ),
                      onTap: () {
                        if (widget.category == "MY PATIENT") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorPrescriptionList(
                                    widget.mobile,
                                    dummyData[i].phone,
                                    dummyData[i].name)),
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
    isLoading = true;
    try {
      var db = await fb
          .reference()
          .child("User")
          .child(widget.mobile)
          .child("myPatient");
      db.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Patient.fromJson(values);
          print(refreshToken);
          setState(() {
            dummyData.add(refreshToken);
            print(dummyData);
            isLoading = false;
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Patient> getMyDoctor() async {
    isLoading = true;
    try {
      var db = await fb
          .reference()
          .child("User")
          .child(widget.mobile)
          .child("myDoctor");
      db.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Patient.fromJson(values);
          print(refreshToken);
          setState(() {
            dummyData.add(refreshToken);
            print(dummyData);
            isLoading = false;
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Appointmnet> getAppointments() async {
     //appointstatus=false;
    //appoint[0].status="Book Now";
    try {
      var db = await fb.reference().child("Appointment");
      db.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Appointmnet.fromJson(values);
          print(refreshToken);
          setState(() {
            if (refreshToken.patientMobile == widget.mobile) {
              appoint.add(refreshToken);
              print(appoint[0].status);

            }
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  FlatButton buttonstatus(String status,int i){
    return FlatButton(
        onPressed: (){
          if(status == "Book Now"){
              ApiService().appointment(widget.mobile,
                  dummyData[i].phone, dummyData[i].name, "Waiting!",0,"","");
              AuthService().toast("Requesting for Confirmation");

          }if(status == "Waiting!"){
            //todo: Button disable
          }
         else if(status == "View"){
            _openPopup(context,i);
          }
        },
          textColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.redAccent)),
        padding: EdgeInsets.all(10),
        color: Colors.redAccent,
        child: (status == "Book Now")?
        Text("Book Now",style: TextStyle(
            color: Colors.white,
            fontFamily: "Lato",
            fontSize: 14),
        ):
        Text(
          status,
          style: TextStyle(
          color: Colors.white,
          fontFamily: "Lato",
          fontSize: 14),
    )
    );

  }
  _openPopup(context,index) {
    var booking_time = appoint[index].BookingTime.split(" ");
    Alert(
        context: context,
        title: "Booking Information",
        content: Center(
          child: Text("""Your Appointment Booked Successfully!! Please be Ready on ${booking_time[1]}""",textAlign: TextAlign.center,),
        ),
        ).show();
  }
}
