// import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Appointmnet.dart';
import 'package:myarogya_mydoctor/model/DoctorUser.dart';
import 'package:myarogya_mydoctor/pages/Doctor/sample.dart';
import 'package:myarogya_mydoctor/pages/dashboard_screen.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/datasearch.dart';
import 'package:intl/intl.dart';

import '../chat_screen.dart';

class Appointments extends StatefulWidget {
  String mobile;
  Appointments(this.mobile);
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List dummyData = [];
  List keys1 = [];
  DateTime start1;
  var interval1;
  FirebaseDatabase fb = FirebaseDatabase.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprofileDetails();
    getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Scaffold(
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
                    child: Text(
                      "            Appointments",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  background: Image.network(
                    "https://www.connect5000.com/wp-content/uploads/2016/07/blog-pic-117-1.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search_rounded, color: Colors.white),
                    onPressed: () {
                      showSearch(context: context, delegate: DataSearch());
                    },
                  )
                ],
              ),
              new SliverPadding(
                padding: new EdgeInsets.all(1.0),
                sliver: new SliverList(
                    delegate: SliverChildListDelegate([
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  width: 130,
                                  height: 40,
                                  child: Card(
                                    color: new Color(0xffFFFFFF),
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                        child: GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Text("My Waiting",
                                                style: new TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Lato")))),
                                  ),
                                ),
                                Text("40",
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Lato")),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  width: 130,
                                  height: 40,
                                  child: Card(
                                    color: new Color(0xffFFFFFF),
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                        child: GestureDetector(
                                            onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DashBoardScreen(
                                                              widget.mobile,
                                                              "MY PATIENT")),
                                                ),
                                            child: Text("My Patient",
                                                style: new TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Lato")))),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text("40",
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Lato")),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[]),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  width: 130,
                                  height: 40,
                                  child: Card(
                                    color: new Color(0xffFFFFFF),
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                        child: GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Text("Next Visit",
                                                style: new TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Lato")))),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text("40",
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Lato")),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ])),
              ),
            ];
          },
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Card(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                dummyData.length < 20 ? dummyData.length : null,
                            itemBuilder: (context, i) => new Column(
                              children: <Widget>[
                                new Divider(
                                  height: 10.0,
                                ),
                                ListTile(
                                  leading: Text((i + 1).toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Lato",
                                          color: Colors.redAccent,
                                          fontSize: 25)),
                                  title: Text(dummyData[i].patientName),
                                  subtitle: Text(dummyData[i].patientMobile),
                                  // trailing: (dummyData[i].status != "Waiting!")
                                  //     ? Container(
                                  //       child: Card(
                                  //           child: Text(
                                  //               " "
                                  //           ),
                                  // ),
                                  //     )
                                  //     :
                                  trailing: FlatButton(
                                          child: Text("Confirm",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Lato",
                                                  fontSize: 14)),
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              side: BorderSide(
                                                  color: Colors.redAccent)),
                                          padding: EdgeInsets.all(10),
                                          onPressed: () async {
                                            if (i == 0) {
                                            } else {
                                              start1 = start1.add(new Duration(
                                                  minutes: interval1));
                                            }
                                            ApiService().appointment(
                                                dummyData[i].patientMobile,
                                                widget.mobile,
                                                dummyData[i].patientName,
                                                "View",
                                                i + 1,
                                                start1.toString(),
                                                keys1[i]);
                                          },
                                          color: Colors.redAccent,
                                        ),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Appointmnet> getAppointments() async {
    try {
      final now = new DateTime.now();
      String formatter = DateFormat('yMd').format(now);
      var db = await fb.reference().child("Appointment");
      db.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        print(values.keys);
        values.forEach((key, values) {
          var refreshToken = Appointmnet.fromJson(values);
          print(refreshToken);
          setState(() {
            if (refreshToken.doctorMobile == widget.mobile &&
                refreshToken.date == formatter) {
              dummyData.add(refreshToken);
              keys1.add(key);
              print(dummyData[0].status);
            }
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<DoctorUser> getprofileDetails() async {
    try {
      var db = await fb.reference().child("User").child(widget.mobile);
      db.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        var start = snapshot.value['Start Time'];
        var interval = snapshot.value['Consulting Interval'];
        start1 = DateTime.parse(start);
        interval1 = int.parse(interval);
      });
    } catch (e) {
      print(e);
    }
  }

  var fiftyDaysFromNow;
}
