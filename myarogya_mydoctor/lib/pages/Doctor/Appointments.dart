import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myarogya_mydoctor/model/Appointmnet.dart';
import 'package:myarogya_mydoctor/model/DoctorUser.dart';
import 'package:myarogya_mydoctor/model/patient.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctorsettings.dart';
import 'package:myarogya_mydoctor/pages/Doctor/update_profile_screen.dart';
import 'package:myarogya_mydoctor/pages/dashboard_screen.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/services/datasearch.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class Appointments extends StatefulWidget {
  String mobile;
  String id;
  Appointments(this.mobile,this.id);
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<Appointmnet> dummyData = [];
  List<Appointmnet> dummyData1 = [];
  List<Appointmnet> filterdata = [];
  List refresh = [];
  List keys1 = [];
  DateTime start1;
  var range = 20;
  var interval1;
  String dname;
  bool duplicate = false;
  Timer timer;
  int h;
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseDatabase fb = FirebaseDatabase.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPermission();
//    timer =
//        Timer.periodic(Duration(seconds: 5), (Timer t) => getAppointments());
    getprofileDetails();
    var db = fb.reference().child("User").child(widget.mobile);
    var db1 = fb.reference().child("User").child(widget.mobile).child("myPatient");
    db.once().then((DataSnapshot snapshot) {
      print(snapshot.value['category']);
      print(snapshot.value['Name']);
      setState(() {
        dname = snapshot.value['Name'];
      });
    });
    db1.once().then((DataSnapshot snapshot) {
      print(snapshot.value);
      Map<dynamic, dynamic > values = snapshot.value;
      values.forEach((key, values) {
        print(values);
        var refreshToken = Patient.fromJson(values);
        refresh.add(refreshToken);
      });
      print(refresh.length);
      for (var value in snapshot.value.values){
        //print(value);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 250,
              floating: false,
              pinned: true,
              leading: Container(),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "  Appointments",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 25.0,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                          padding: const EdgeInsets.fromLTRB(16.0, 11.0,100.0, 0.0),
                          child: Container(
                            height: 36.0,
                            width: double.infinity,
                            child: CupertinoTextField(
                              onChanged: (text){
                                setState(() {
                                  dummyData = filterdata
                                      .where((u) => (u.doctorName
                                      .toLowerCase()
                                      .contains(text.toLowerCase()) ||
                                      u.patientMobile
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

                // background: Image.network(
                //   "https://www.connect5000.com/wp-content/uploads/2016/07/blog-pic-117-1.jpeg",
                //   fit: BoxFit.cover,
                // ),
              ),
              actions: [
            //     IconButton(
            //       icon: Icon(Icons.search, color: Colors.redAccent,size: 30,),
            // onPressed: () {
            //         showSearch(context: context, delegate: DataSearch());
            //       },
            //     ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.redAccent,size: 35,),
                  onPressed: () {
                    _openPopup(context);
                  },
                ),
//                IconButton(
//                  icon: Icon(Icons.people, color: Colors.white),
//                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => ProfileScreen(widget.id,widget.mobile)),
//                    );
//                  },
//                ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.settings,color: Colors.redAccent,),
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
                  children: [
                    Flexible(
                      flex:1,
                      child: Container(
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
                                            // onTap: () => Navigator.pop(context),
                                            child: Text("My Waiting",
                                                style: new TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Lato")))),
                                  ),
                                ),
                                Text((dummyData.length == 0?"0":(dummyData.length).toString()),
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
                    ),
                    Flexible(
                      flex:1,
                      child: Container(
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
                                                              "MY PATIENT",widget.id)),
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
                                Text(refresh.length.toString(),
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
                    ),
                    Flexible(
                      flex:1,
                      child: Container(
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
                                            child: Text("Today Count",
                                                style: new TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Lato")))),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(dummyData == null ?"0":dummyData.length.toString(),
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
                    ),
                  ],
                ),
              ])),
            ),
          ];
        },
        body: Card(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount:
            dummyData.length < range ? dummyData.length : null,
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
              title: Text(dummyData[i].doctorName),
              subtitle: Text(dummyData[i].patientMobile),
              trailing: (dummyData[i].status != "Waiting!")
                  ? FlatButton(
                child: Text(timesplit(start1),
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
                color: Colors.redAccent,
                onPressed: () {
                  AuthService().toast("Next Appointment:"+timesplit(start1));
                },
              )
                  : FlatButton(
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
                          setState(() {
                            start1 = start1.add(
                                new Duration(minutes: interval1));
                            h=2;
                          });
                        }
                        ApiService().appointment(
                            dummyData[i].patientMobile,
                            widget.mobile,
                            dummyData[i].doctorName,
                            "View",
                            i + 1,
                            start1.toString(),
                            keys1[i],h.toString());
                        ApiService().trigger=false;
                      },
                      color: Colors.redAccent,
                    ),

            ),
            new Divider(
              height: 10.0,
            ),
          ],
            ),
          ),
        ),
     // ),
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
            if (refreshToken.doctorMobile == widget.mobile) {
              dummyData.add(refreshToken);
              filterdata.add(refreshToken);
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
      getAppointments();
    } catch (e) {
      print(e);
    }
  }

  _openPopup(context)  {
    Alert(
        context: context,
        title: "Add My Patient",
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
            onPressed: () {
              checkDuplication("+91"+phone.text,name.text);
//              addPatient(name.text, "+91" + phone.text);
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

  addPatient(String name, String phone) async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission == PermissionStatus.granted) {
      Contact newContact = new Contact();
      newContact.givenName = name;
      newContact.phones = [Item(label: "mobile", value: phone)];
      await ContactsService.addContact(newContact);
      checkmobile(name, phone);
      Navigator.of(context).pop();
    }
  }

  checkmobile(String pname, String pmobile) {
    var db = fb.reference().child("User").child(widget.mobile);
    db.once().then((DataSnapshot snapshot) {
      ApiService().addPatientToDoctor(pmobile, widget.mobile, pname);
      ApiService().addDoctorToPatient(pmobile, widget.mobile, dname);
      AuthService().toast("Added Successfully!!");
      duplicate = false;
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        print(values);
      });
    });
  }
  checkDuplication(String phone,String name){
    var db = fb.reference().child("User").child(widget.mobile).child("myPatient");
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
      addPatient(name , phone);
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
              ProfileScreen(widget.id,widget.mobile),
        ),
      );
    }else if(choice == ConstantsD.Settings){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DoctorSettings(widget.id,widget.mobile),
        ),
      );
    }
  }
  timesplit(DateTime time){
    var time1 = formatDate( time , [dd, ' ', MM, ' ', yyyy,'/', HH , ':', nn]);
    var time2 = time1.split("/")[1];
    return time2;
  }


}
