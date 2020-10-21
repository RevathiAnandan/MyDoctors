import 'package:firebase_database/firebase_database.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Appointmnet.dart';
import 'package:myarogya_mydoctor/pages/Doctor/sample.dart';
import 'package:myarogya_mydoctor/pages/dashboard_screen.dart';
import 'package:myarogya_mydoctor/services/datasearch.dart';

import '../chat_screen.dart';

class Appointments extends StatefulWidget {
  String mobile;
  Appointments(this.mobile);
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List dummyData = [];
  FirebaseDatabase fb = FirebaseDatabase.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppointments();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "  Appointments",
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
              sliver: new SliverList(delegate: SliverChildListDelegate(
                [
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
                                        borderRadius: BorderRadius.circular(20)),
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
                                        borderRadius: BorderRadius.circular(20)),
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
                            children: <Widget>[

                            ]),
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
                                        borderRadius: BorderRadius.circular(20)),
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
                ]
              )),
            ),
          ];
        },
        body: Container(
          child: Column(
            children: [

              Column(
                children: [
                  Expanded(
                    flex: 0,
                    child:Card(
                        child:  ListView.builder(
                          shrinkWrap: true,
                          itemCount:dummyData.length < 20 ? dummyData.length:null,
                          itemBuilder: (context, i) => new Column(
                            children: <Widget>[
                              new Divider(
                                height: 10.0,
                              ),
                              ListTile(
                                leading: Text((i+1).toString(),
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Lato",
                                        color: Colors.redAccent,
                                        fontSize: 25)),
                                title: Text(dummyData[i].patientName),
                                subtitle: Text(dummyData[i].patientMobile),
                                trailing: FlatButton(
                                  child: Text("Confirm",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14)),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: BorderSide(color: Colors.redAccent)
                                  ),
                                  padding: EdgeInsets.all(10),
                                  onPressed: () async{

                                  },
                                  color: Colors.redAccent,
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Appointmnet> getAppointments() async {
    try {
      var db = await fb.reference().child("Appointment");
      db.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Appointmnet.fromJson(values);
          print(refreshToken);
          setState(() {
            if (refreshToken.doctorMobile == widget.mobile) {
              dummyData.add(refreshToken);
              print(dummyData);
            }
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
