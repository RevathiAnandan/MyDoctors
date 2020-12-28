import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myarogya_mydoctor/model/Appointmnet.dart';
import 'package:myarogya_mydoctor/model/patient.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_PrescriptionList.dart';
import 'package:myarogya_mydoctor/pages/Doctor/update_profile_screen.dart';
import 'package:myarogya_mydoctor/pages/patient/patientprofile.dart';
import 'package:myarogya_mydoctor/pages/patient/patientsettings.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../dashboard_screen.dart';
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
  List filterdata = [];
  List localappoint = [];
  List<String> appointkey = [];
  List status = [];
  var buttonStatus;
  bool _isButtondisable;
  FirebaseDatabase fb = FirebaseDatabase.instance;
  var isLoading = false;
  bool appointstatus = false;
  int _widgetIndex=0;
  bool duplicate = false;
  String dname;
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isButtondisable = false;
    getAppointments();
    var db = fb.reference().child("User").child(widget.mobile);
    db.once().then((DataSnapshot snapshot){
      print (snapshot.value['Name']);
      setState(() {
        dname =  snapshot.value['Name'];
      });
    });
//    timer =
//        Timer.periodic(Duration(seconds: 5), (Timer t) => getAppointments());

  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: Container(),
                backgroundColor: Colors.white,
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("  Appointments",style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 25.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  background: Column(
                    children: <Widget>[
                      Stack(
                        children: [
                          Image.network(
                            "https://www.healthcareitnews.com/sites/hitn/files/pexels-pixabay-236380.jpg",
                            fit: BoxFit.cover,
                            // color: Colors.blue,
                            colorBlendMode: BlendMode.hue,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 11.0,100.0, 16.0),
                            child: Container(
                              height: 36.0,
                              width: double.infinity,
                              child: CupertinoTextField(
                                onChanged: (text){
                                  setState(() {
                                    appoint = filterdata
                                        .where((u) => (u.doctorName
                                        .toLowerCase()
                                        .contains(text.toLowerCase()) ||
                                        u.doctorMobile
                                            .toLowerCase().contains(text.toLowerCase())))
                                        .toList();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                placeholder: 'Search',
                                placeholderStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 14.0,
                                  fontFamily: 'Brutal',
                                ),
                                prefix: Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color(0xffF0F1F5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(icon: Icon(Icons.add,color: Colors.redAccent,size: 35,),
                    onPressed: (){
                      _openPopupP(context);
                    },),
                  // IconButton(icon: Icon(Icons.account_circle,color: Colors.redAccent),
                  //   onPressed: (){
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(builder: (context) =>  DashBoardScreen(
                  //             widget.mobile,
                  //             "MY DOCTOR",widget.id))
                  //     );
                  //   },),
                  PopupMenuButton<String>(
                    icon: new Icon(
                      Icons.settings,
                      // Icons.more_vert_rounded,
                      color: Colors.redAccent,
                      size: 35,
                    ),
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context){
                      return ConstantsD.choices.map((String choice){
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.only(top: 16),
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.max,
                          //     children: <Widget>[
                          //       Column(
                          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //         children: <Widget>[
                          //           Container(
                          //             width: 130,
                          //             height: 40,
                          //             child: Card(
                          //               color: new Color(0xffFFFFFF),
                          //               elevation: 6,
                          //               shape: RoundedRectangleBorder(
                          //                   borderRadius:
                          //                   BorderRadius.circular(20)),
                          //               child: Center(
                          //                   child: GestureDetector(
                          //                       onTap: () => Navigator.push(
                          //                         context,
                          //                         MaterialPageRoute(
                          //                             builder: (context) =>
                          //                                 MyPendings(widget.id,widget.mobile,"MY DOCTOR")
                          //                         ),
                          //                       ),
                          //                       child: Text("My Pendings",
                          //                           style: new TextStyle(
                          //                               color: Colors.redAccent,
                          //                               fontSize: 14,
                          //                               fontWeight: FontWeight.bold,
                          //                               fontFamily: "Lato")))),
                          //             ),
                          //           ),
                          //           Text("",
                          //               style: new TextStyle(
                          //                   color: Colors.black,
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.bold,
                          //                   fontFamily: "Lato")),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            padding: EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      width: 160,
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
                                                              "MY DOCTOR",widget.id)),
                                                ),
                                                child: Text("My Doctors",
                                                    style: new TextStyle(
                                                        color: Colors.redAccent,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: "Lato")))),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text("",
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
                                      width: 160,
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
                                                child: Text("My Reports",
                                                    style: new TextStyle(
                                                        color: Colors.redAccent,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: "Lato")))),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text("",
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
    )
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
              print(refreshToken);
              setState(() {
                if (refreshToken.patientMobile == widget.mobile) {
                  appoint.add(refreshToken);
                  filterdata.add(refreshToken);
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
  _openPopupP(context) {
    Alert(
        context: context,
        title: "Add my doctor",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                prefixText: "Dr.",
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
    if(choice == ConstantsD.Profile){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PatientProfile(widget.id,widget.mobile),
        ),
      );
    }else if(choice == ConstantsD.Settings){
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
