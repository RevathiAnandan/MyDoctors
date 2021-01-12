import 'dart:io';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myarogya_mydoctor/model/DoctorUser.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_dashboard.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_new_dashboard.dart';
//import 'package:myarogya_mydoctor/pages/chat_screen.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
//import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:qr_flutter/qr_flutter.dart';
//import 'package:myarogya_mydoctor/utils/sharedPrefUtil.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:date_format/date_format.dart';

//import '../PersonalDetails.dart';
//import '../ProfessionalDetails.dart';
//import '../contact_screen.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  String userId;
  String mobile;
  ProfileScreen(this.userId, this.mobile);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _doctorId = new TextEditingController();
  TextEditingController _hospitalName = new TextEditingController();
  TextEditingController _specialist = new TextEditingController();
  TextEditingController _degree = new TextEditingController();
  TextEditingController _dName = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  //TextEditingController _phone = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  TextEditingController _interval = new TextEditingController();
  TextEditingController _hours = new TextEditingController();
  TextEditingController mstarttymController = new TextEditingController();
  TextEditingController e_starttymController = new TextEditingController();
  TextEditingController s_starttymController = new TextEditingController();
  TextEditingController starttymController = new TextEditingController();
  TextEditingController endtymController = new TextEditingController();
  TextEditingController m_endtymController = new TextEditingController();
  TextEditingController e_endtymController = new TextEditingController();
  TextEditingController s_endtymController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  var qrData;
  File _image;
  String imagelink;
  bool editable;
  DateTime starttym;
  String m_starttym;
  String e_starttym;
  String s_starttym;
  DateTime endtym;
  String m_endtym;
  String e_endtym;
  String s_endtym;
  String date5;
  DoctorUser refreshToken;
  @override
  void initState() {
    super.initState();
    getProfileDetails();
    setState(() {
//      _phone.text = widget.mobile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.redAccent,
            ),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
          title: Text('Profile',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  updatingProfile(
                    _image,
                    _doctorId.text,
                    _hospitalName.text,
                    _specialist.text,
                    _degree.text,
                    _dName.text,
                    _email.text,
                    qrData,
                    _address.text,
                    starttym.toString(),
                    endtym.toString(),
                    _interval.text,
                    m_starttym,
                    m_endtym,
                    e_starttym,
                    e_endtym,
                    s_starttym,
                    s_endtym,
                  );
                  setState(() {
                    qrData = widget.mobile;
                  });
                })
          ],
        ),
        body: new Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: new Stack(
                            fit: StackFit.loose,
                            children: <Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    child: new Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          image: (_image != null)
                                              ? FileImage(File(_image.path))
                                              :(imagelink != null?NetworkImage(imagelink): new ExactAssetImage(
                                                  'assets/images/user_profile.png')),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap: () => getImage(),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  //TODO: YET TO BE UPDATED TO THE FIREBASE (QRDATA)
                                  (qrData != null)
                                      ? Container(
                                          width: 100.0,
                                          height: 100.0,
                                          child: QrImage(
                                            data: widget
                                                .mobile, //place where the QR Image will be shown
                                          ),
                                        )
                                      : Text('')
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  height: MediaQuery.of(context).size.height *
                                      78 /
                                      100,
                                  child: ListView(
                                    children: <Widget>[
                                      // Text("Professional Details",
                                      //     style: new TextStyle(
                                      //         fontSize: 25,
                                      //         fontWeight: FontWeight.bold,
                                      //         fontFamily: "Lato",
                                      //         color: Colors.redAccent)),
                                      Text("Name",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          prefixText: 'Dr.',
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 15.0, 20.0, 5.0),
                                          // prefixIcon: new Icon(Icons.person,
                                          //     color:  Colors.redAccent),
                                          // enabledBorder: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.all(
                                          //         Radius.circular(8)),
                                          //     borderSide: BorderSide(
                                          //         color: Colors.redAccent)),
                                          // focusedBorder: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.all(
                                          //         Radius.circular(8)),
                                          //     borderSide: BorderSide(
                                          //         color: Colors.redAccent)),
                                          // filled: true,
                                          // fillColor: Colors.grey[100],
                                        ),
                                        controller: _dName,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Mobile Number",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                              prefixIcon: new Icon(
                                                  Icons.phone_android,
                                                  color: Colors.redAccent),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 15.0, 20.0, 5.0),
                                              // enabledBorder: OutlineInputBorder(
                                              //     borderRadius: BorderRadius.all(
                                              //         Radius.circular(8)),
                                              //     borderSide: BorderSide(
                                              //         color: Colors.redAccent)),
                                              // focusedBorder: OutlineInputBorder(
                                              //     borderRadius: BorderRadius.all(
                                              //         Radius.circular(8)),
                                              //     borderSide: BorderSide(
                                              //         color: Colors.redAccent)),
                                              // filled: true,
                                              // fillColor: Colors.grey[100],
                                              hintText: ""),
                                          autofocus: false,
                                          initialValue: widget.mobile),
                                      SizedBox(
                                        height: 10,
                                      ),

                                      Text("Doctor Register Id",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 5.0),
                                            prefixIcon: new Icon(Icons.person,
                                                color: Colors.redAccent),
                                            // enabledBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // focusedBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // filled: true,
                                            // fillColor: Colors.grey[100],
                                            hintText: ""),
                                        controller: _doctorId,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Clinic Name",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            prefixIcon: new Icon(Icons.business,
                                                color: Colors.redAccent),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 5.0),
                                            // enabledBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // focusedBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // filled: true,
                                            // fillColor: Colors.grey[100],
                                            hintText: ""),
                                        controller: _hospitalName,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Clinic Address",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 5.0),
                                            prefixIcon: new Icon(Icons.home,
                                                color: Colors.redAccent),
                                            // enabledBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // focusedBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // filled: true,
                                            // fillColor: Colors.grey[100],
                                            hintText: ""),
                                        validator: (_address) =>
                                            _address == null
                                                ? "Invalid Address"
                                                : null,
                                        controller: _address,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Specialist",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 5.0),
                                            prefixIcon: new Icon(
                                                Icons.business_center,
                                                color: Colors.redAccent),
                                            // enabledBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // focusedBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // filled: true,
                                            // fillColor: Colors.grey[100],
                                            hintText: ""),
                                        controller: _specialist,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Degree",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 5.0),
                                            prefixIcon: new Icon(
                                                Icons.library_books,
                                                color: Colors.redAccent),
                                            // enabledBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // focusedBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // filled: true,
                                            // fillColor: Colors.grey[100],
                                            hintText: ""),
                                        controller: _degree,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Date of Registration",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Theme(
                                        data: ThemeData(
                                            primaryColor: Colors.redAccent),
                                        child: DateTimeField(
                                          format: DateFormat("dd-MM-yyyy"),
                                          controller: dateController,
                                          decoration: InputDecoration(
                                              fillColor: Colors.redAccent,
                                              labelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                              // border: OutlineInputBorder(),
                                              icon: Icon(Icons.cake),
                                              labelText: 'DOB',
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never),
                                          onShowPicker: (context, dt) {
                                            return showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1990),
                                              lastDate: DateTime(2050),
                                            );
                                          },
                                          onChanged: (dt) {
                                            setState(() {
                                              date5 = formatDate(
                                                  dt, [dd, ' ', MM, ' ', yyyy]);
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Available Time   (Time Format is 24 hrs)",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              //editable: false,
                                              controller: starttymController,
                                              decoration: InputDecoration(
                                                  // border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                  labelText: 'Start Time',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never),
                                              onShowPicker:
                                                  (context, dt) async {
                                                final time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          dt ?? DateTime.now()),
                                                  builder: (context, child) =>
                                                      MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      true),
                                                          child: child),
                                                );
                                                return DateTimeField.convert(
                                                    time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => starttym = dt);
                                                print(
                                                    'Selected date: $starttym');
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              controller: endtymController,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  // border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                  labelText: 'End Time',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never),
                                              onShowPicker:
                                                  (context, dt) async {
                                                final time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          dt ?? DateTime.now()),
                                                  builder: (context, child) =>
                                                      MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      true),
                                                          child: child),
                                                );
                                                return DateTimeField.convert(
                                                    time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => endtym = dt);
                                                print('Selected date: $endtym');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Appointment Interval (In minutes,Between Two Patients)",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),

                                      TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 15.0, 20.0, 5.0),
                                          prefixIcon: new Icon(Icons.timer,
                                              color: Colors.redAccent),
                                          // enabledBorder: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.all(
                                          //         Radius.circular(8)),
                                          //     borderSide: BorderSide(
                                          //         color: Colors.redAccent)),
                                          // focusedBorder: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.all(
                                          //         Radius.circular(8)),
                                          //     borderSide: BorderSide(
                                          //         color: Colors.redAccent)),
                                          // filled: true,
                                          // fillColor: Colors.grey[100],
                                        ),
                                        controller: _interval,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),

                                      // Text("Personal Details",
                                      //     style: new TextStyle(
                                      //         fontSize: 25,
                                      //         fontWeight: FontWeight.bold,
                                      //         fontFamily: "Lato",
                                      //         color: Colors.redAccent)),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),

                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      Text("Email",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 5.0),
                                            prefixIcon: new Icon(Icons.email,
                                                color: Colors.redAccent),
                                            // enabledBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // focusedBorder: OutlineInputBorder(
                                            //     borderRadius: BorderRadius.all(
                                            //         Radius.circular(8)),
                                            //     borderSide: BorderSide(
                                            //         color: Colors.redAccent)),
                                            // filled: true,
                                            // fillColor: Colors.grey[100],
                                            hintText: ""),
                                        controller: _email,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                          "Clinic Timing  (Time Format is 24 hrs)",
                                          style: new TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Lato",
                                              color: Colors.redAccent)),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text("Morning",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              controller: mstarttymController,
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  // border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                  labelText: 'Start Time',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never),
                                              onShowPicker:
                                                  (context, dt) async {
                                                final time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          dt ?? DateTime.now()),
                                                  builder: (context, child) =>
                                                      MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      true),
                                                          child: child),
                                                );
                                                return DateTimeField.convert(
                                                    time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => m_starttym =
                                                    formatDate(
                                                            dt, [HH, ':', nn])
                                                        .toString());
                                                print(
                                                    'Selected date: $m_starttym');
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              controller: m_endtymController,
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  // border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                  labelText: 'End Time',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never),
                                              onShowPicker:
                                                  (context, dt) async {
                                                final time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          dt ?? DateTime.now()),
                                                  builder: (context, child) =>
                                                      MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      true),
                                                          child: child),
                                                );
                                                return DateTimeField.convert(
                                                    time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => m_endtym =
                                                    formatDate(
                                                            dt, [HH, ':', nn])
                                                        .toString());
                                                print(
                                                    'Selected date: $m_endtym');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Evening",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              controller: e_starttymController,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  // border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                  labelText: 'Start Time',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never),
                                              onShowPicker:
                                                  (context, dt) async {
                                                final time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          dt ?? DateTime.now()),
                                                  builder: (context, child) =>
                                                      MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      true),
                                                          child: child),
                                                );
                                                return DateTimeField.convert(
                                                    time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => e_starttym =
                                                    formatDate(
                                                            dt, [HH, ':', nn])
                                                        .toString());
                                                print(
                                                    'Selected date: $starttym');
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              controller: e_endtymController,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  // border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                  labelText: 'End Time',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never),
                                              onShowPicker:
                                                  (context, dt) async {
                                                final time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          dt ?? DateTime.now()),
                                                  builder: (context, child) =>
                                                      MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      true),
                                                          child: child),
                                                );
                                                return DateTimeField.convert(
                                                    time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => e_endtym =
                                                    formatDate(
                                                            dt, [HH, ':', nn])
                                                        .toString());
                                                print(
                                                    'Selected date: $e_endtym');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Sunday",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              controller: s_starttymController,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  // border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                  labelText: 'Start Time',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never),
                                              onShowPicker:
                                                  (context, dt) async {
                                                final time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          dt ?? DateTime.now()),
                                                  builder: (context, child) =>
                                                      MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      true),
                                                          child: child),
                                                );
                                                return DateTimeField.convert(
                                                    time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => s_starttym =
                                                    formatDate(
                                                            dt, [HH, ':', nn])
                                                        .toString());
                                                print(
                                                    'Selected date: $s_starttym');
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              controller: s_endtymController,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  // border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                  labelText: 'End Time',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never),
                                              onShowPicker:
                                                  (context, dt) async {
                                                final time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          dt ?? DateTime.now()),
                                                  builder: (context, child) =>
                                                      MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      true),
                                                          child: child),
                                                );
                                                return DateTimeField.convert(
                                                    time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => s_endtym =
                                                    formatDate(
                                                            dt, [HH, ':', nn])
                                                        .toString());
                                                print(
                                                    'Selected date: $s_endtym');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 35,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> updatingProfile(
      File image,
      String doctorId,
      String hospitalName,
      String specialist,
      String degree,
      String dName,
      String email,
      String Qrdata,
      String address,
      String starttym,
      String endtym,
      String interval,
      String mstarttym,
      String mendtym,
      String estarttym,
      String eendtymm,
      String sstarttym,
      String sendtym) async {
    if (image != null) {
      String fileName = "image" + widget.userId;
      StorageReference reference =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = reference.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      if (taskSnapshot.error == null) {
        if (widget.userId != null && widget.mobile != null) {
          final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          ApiService().updateProfile(
              widget.userId,
              widget.mobile,
              ConstantUtils().Doctor,
              downloadUrl,
              doctorId,
              hospitalName,
              specialist,
              degree,
              dName,
              email,
              Qrdata,
              address,
              starttym,
              endtym,
              interval,
              mstarttym,
              mendtym,
              estarttym,
              eendtymm,
              sstarttym,
              sendtym,
              date5);
        } else {
          if (widget.userId != null && widget.mobile != null) {
            ApiService().updateProfile(
                widget.userId,
                widget.mobile,
                ConstantUtils().Doctor,
                "null",
                doctorId,
                hospitalName,
                specialist,
                degree,
                dName,
                email,
                Qrdata,
                address,
                starttym,
                endtym,
                interval,
                mstarttym,
                mendtym,
                estarttym,
                eendtymm,
                sstarttym,
                sendtym,
                date5);
          }
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DoctorNewDashboard(widget.userId, widget.mobile,"Doctor"),
          ),
        );
      }
    } else {
      if (widget.userId != null && widget.mobile != null) {
        ApiService().updateProfile(
            widget.userId,
            widget.mobile,
            ConstantUtils().Doctor,
            "null",
            doctorId,
            hospitalName,
            specialist,
            degree,
            dName,
            email,
            Qrdata,
            address,
            starttym,
            endtym,
            interval,
            mstarttym,
            mendtym,
            estarttym,
            eendtymm,
            sstarttym,
            sendtym,
            date5);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DoctorNewDashboard(widget.userId, widget.mobile,"Doctor"),
        ),
      );
    }
  }

  FirebaseDatabase fb = FirebaseDatabase.instance;
  Future<DoctorUser> getProfileDetails() async {
    try {
      var db = await fb.reference().child("User").child(widget.mobile);
      if (db != null) {
        db.once().then((DataSnapshot snapshot) {
          print(snapshot.value);
          if (snapshot.value == null) {
          } else {
            Map<dynamic, dynamic> values = snapshot.value;


            refreshToken = DoctorUser.fromJson(values);

            _doctorId.text = values['registerId'];
            _hospitalName.text = refreshToken.hospitalName;
            _specialist.text = refreshToken.specialist;
            _degree.text = refreshToken.degree;
            _dName.text = refreshToken.Name;
            _email.text = refreshToken.emailId;
            _address.text = refreshToken.Hospital_Address;
            starttymController.text =
                refreshToken.StartTime.split(" ")[1].split(".")[0];
            endtymController.text =
                refreshToken.EndTime.split(" ")[1].split(".")[0];
            mstarttymController.text = refreshToken.mstarttym;
            m_starttym = refreshToken.mstarttym;
            m_endtymController.text = refreshToken.mendtym;
            m_endtym = refreshToken.mendtym;
            e_endtymController.text = refreshToken.eendtymm;
            e_endtym = refreshToken.eendtymm;
            e_starttymController.text = refreshToken.estarttym;
            e_starttym = refreshToken.estarttym;
            s_starttymController.text = refreshToken.sstarttym;
            s_starttym = refreshToken.sstarttym;
            s_endtymController.text = refreshToken.sendtym;
            s_endtym = refreshToken.sendtym;
            _interval.text = refreshToken.Intervals;
            dateController.text = refreshToken.date5;
            date5 = refreshToken.date5;
            setState(() {
              imagelink = refreshToken.image;
            });
          }
        });
      } else {}
    } catch (e) {
      print(e);
    }
  }
}
