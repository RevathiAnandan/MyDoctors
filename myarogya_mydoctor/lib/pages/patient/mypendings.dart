import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Appointmnet.dart';
import 'package:myarogya_mydoctor/model/patient.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_PrescriptionList.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'PrescriptionList.dart';

class MyPendings extends StatefulWidget {

  String mobile;
  String category;
  String id;
  MyPendings(this.id, this.mobile, this.category);
  @override
  _MyPendingsState createState() => _MyPendingsState();
}

class _MyPendingsState extends State<MyPendings> {
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
  int _widgetIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isButtondisable = false;
    getAppointments();
//    timer =
//        Timer.periodic(Duration(seconds: 5), (Timer t) => getAppointments());

  }
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("My Pendings",style: TextStyle(color: Colors.redAccent),),
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back,color: Colors.redAccent),
      //     onPressed: ()async{
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: new ListView.builder(
        itemCount: appoint.length,
        itemBuilder: (context, i) => new Column(
          children: <Widget>[
            new Divider(
              height: 10.0,
            ),
            new ListTile(
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      new Text(
                        appoint[i].doctorName != null ? appoint[i].doctorName : "",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      new Container(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: new Text(
                          appoint[i].doctorMobile != null ? appoint[i].doctorMobile : "",
                          style:
                          new TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                  appoint.isEmpty ?Text("No Appointments Booked!!"):buttonstatus(appoint[i].status,i)
                  // (widget.category == "MY PATIENT")?Text(" "):((appoint.isEmpty) ? buttonfunction("Book Now",i) : ((appoint.asMap().containsKey(i))?buttonfunction(appoint[int.parse(appoint[i].Index)].status,i):buttonfunction(buttonStatus,i))),
                ],
              ),
              //trailing: (widget.category == "MY PATIENT")?Text(" "):((appoint.isEmpty) ? buttonstatus("Book Now",i) : ((appoint.asMap().containsKey(i))?buttonstatus(appoint[appoint[i].Index].status,i):(appoint[i].Index==i.toString()?buttonstatus(appoint[int.parse(appoint[i].Index)].status,i):buttonstatus("Book Now",i)))),
              //trailing: (widget.category == "MY PATIENT")?Text(" "):((appoint.isEmpty) ? buttonstatus("Book Now",i) : ((appoint.asMap().containsKey(i))?buttonstatus(appoint[i].status,i):buttonstatus("Book Now",i))),
              // trailing: (widget.category == "MY PATIENT")?Text(" "):((appoint.isEmpty) ? buttonstatus("Book Now",i) : ((appoint.asMap().containsKey(i))?buttonstatus("Book Now",i):buttonstatus(status[i],i))),
              //trailing: (widget.category == "MY PATIENT")?Text(" "):(appoint.isEmpty) ?(appoint.asMap().containsKey(int.parse(appoint[i].Index))?Text("11"): buttonstatus("Book Now",i)):(appoint.asMap().containsKey(i)?buttonstatus(appoint[int.parse(appoint[i].Index)].status,i): buttonstatus("Book Now",i)),
              //trailing: (widget.category == "MY PATIENT")?Text(" "):buttons(_widgetIndex,i),
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
      ),
    );
  }

  Future<Appointmnet> getAppointments() async {
    try {
      var db = await fb.reference().child("Appointment");
      if (db != null) {
        db.once().then((DataSnapshot snapshot) {
          print(snapshot.value);
          if (snapshot.value == null) {
            // isLoading = false;
          } else {
            Map<dynamic, dynamic> values = snapshot.value;
            values.forEach((key, values) {
              var refreshToken = Appointmnet.fromJson(values);
              print("Harun");
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
        child: Text(
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
}
