import 'dart:io';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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


  var qrData;
  File _image;
  bool editable;
  DateTime starttym;
  DateTime m_starttym;
  DateTime e_starttym;
  DateTime s_starttym;
  DateTime endtym;
  DateTime m_endtym;
  DateTime e_endtym;
  DateTime s_endtym;

  @override
  void initState() {
    super.initState();
    setState(() {
//      _phone.text = widget.mobile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: new Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
//                Container(
//                  height: 130,
//                  width: double.infinity,
//                  decoration: BoxDecoration(
//                    color: Colors.redAccent,
//                    borderRadius: BorderRadius.only(
//                        bottomLeft: Radius.circular(15),
//                        bottomRight: Radius.circular(15)),
//                  ),
//                  child: Column(
//                    children: [
//                      Align(
//                        alignment: Alignment.topLeft,
//                        child: IconButton(
//                          icon: Icon(
//                            Icons.arrow_back_ios,
//                            color: Colors.white,
//                          ),
//                          onPressed: () => Navigator.pop(context),
//                        ),
//                      ),
//                      Text(
//                        'Hello Doctor !',
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 26,
//                            fontWeight: FontWeight.w500,
//                            fontFamily: "Lato"),
//                      ),
//                      SizedBox(height: 10),
//                      Text(
//                        'please fill out the following details to create your profile',
//                        style: TextStyle(
//                            color: new Color(0xffCBD2D9),
//                            fontSize: 14,
//                            fontWeight: FontWeight.w500,
//                            fontFamily: "Lato"),
//                      ),
//                    ],
//                  ),
//                ),
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
                                              : new ExactAssetImage(
                                              'assets/images/user_profile.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap: ()=> getImage(),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  //TODO: YET TO BE UPDATED TO THE FIREBASE (QRDATA)
                                  (qrData!= null)?
                                  Container(
                                    width: 100.0,
                                    height: 100.0,
                                    child: QrImage(
                                      data: widget.mobile, //place where the QR Image will be shown
                                    ),
                                  ): Text('')
                                ],
                              ),
                              // Padding(
                              //     padding: EdgeInsets.only(top: 70.0, left: 0.0),
                              //     child: new Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: <Widget>[
                              //         new CircleAvatar(
                              //           backgroundColor: Colors.redAccent,
                              //           radius: 20.0,
                              //           child: new IconButton(
                              //             icon: Icon(Icons.camera_alt),
                              //             color: Colors.white,
                              //             onPressed: () {
                              //               getImage();
                              //             },
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              // ),
                            ],),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  height: MediaQuery.of(context).size.height *
                                      78/
                                      100,
                                  child: ListView(
                                    children: <Widget>[
                                      Text("Professional Details",
                                          style: new TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Lato",
                                              color: Colors.redAccent)),
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
                                                20.0, 5.0, 20.0, 5.0),
                                            prefixIcon: new Icon(Icons.person,
                                                color:  Colors.redAccent),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            hintText: ""),
                                        controller: _doctorId,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Hospital Name",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            prefixIcon: new Icon(Icons.business,
                                                color:  Colors.redAccent),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 5.0, 20.0, 5.0),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            hintText: ""),
                                        controller: _hospitalName,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Hospital Address",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 5.0, 20.0, 5.0),
                                            prefixIcon: new Icon(Icons.home,
                                                color: Colors.redAccent),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            hintText: ""),
                                        validator: (_address) => _address==null?"Invalid Address":null,
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
                                                20.0, 5.0, 20.0, 5.0),
                                            prefixIcon: new Icon(
                                                Icons.business_center,
                                                color:  Colors.redAccent),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            filled: true,
                                            fillColor: Colors.grey[100],
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
                                                20.0, 5.0, 20.0, 5.0),
                                            prefixIcon: new Icon(
                                                Icons.library_books,
                                                color:  Colors.redAccent),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            hintText: ""),
                                        controller: _degree,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Available Time",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                  ),
                                                  labelText: 'Start Time',
                                                  floatingLabelBehavior: FloatingLabelBehavior.never
                                              ),
                                              onShowPicker: (context, dt) async {
                                                final time = await showTimePicker(
                                                    context: context,
                                                    initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
                                                  builder: (context, child) => MediaQuery(
                                                      data: MediaQuery.of(context)
                                                          .copyWith(alwaysUse24HourFormat: true),
                                                      child: child),
                                                );
                                                    return DateTimeField.convert(time);
                                                // await showCupertinoModalPopup(
                                                //     context: context,
                                                //     builder: (context) {
                                                //       return CupertinoDatePicker(
                                                //         onDateTimeChanged: (dt) {
                                                //           starttym = dt;
                                                //         },
                                                //       );
                                                //     });
                                                // setState(() {});
                                                // return starttym;
                                              },
                                              onChanged: (dt) {
                                                setState(() => starttym = dt);
                                                print('Selected date: $starttym');
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
                                              //editable: false,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                  ),
                                                  labelText: 'End Time',
                                                  floatingLabelBehavior: FloatingLabelBehavior.never
                                              ),
                                              onShowPicker: (context, dt) async {
                                                final time = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
                                                  builder: (context, child) => MediaQuery(
                                                      data: MediaQuery.of(context)
                                                          .copyWith(alwaysUse24HourFormat: true),
                                                      child: child),
                                                );
                                                return DateTimeField.convert(time);
                                                // await showCupertinoModalPopup(
                                                //     context: context,
                                                //     builder: (context) {
                                                //       return CupertinoDatePicker(
                                                //         onDateTimeChanged: (dt) {
                                                //           starttym = dt;
                                                //         },
                                                //       );
                                                //     });
                                                // setState(() {});
                                                // return starttym;
                                              },
                                              onChanged: (dt) {
                                                setState(() => endtym = dt);
                                                print('Selected date: $endtym');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      // DateFormat("HH:mm"),
                                      // TextFormField(
                                      //   decoration: InputDecoration(
                                      //       contentPadding: EdgeInsets.fromLTRB(
                                      //           20.0, 5.0, 20.0, 5.0),
                                      //       prefixIcon: new Icon(
                                      //           Icons.timer,
                                      //           color: new Color(0xffACCCF8)),
                                      //       enabledBorder: OutlineInputBorder(
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(8)),
                                      //           borderSide: BorderSide(
                                      //               color: Colors.redAccent)),
                                      //       focusedBorder: OutlineInputBorder(
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(8)),
                                      //           borderSide: BorderSide(
                                      //               color: Colors.redAccent)),
                                      //       filled: true,
                                      //       fillColor: Colors.grey[100],
                                      //       hintText: ""),
                                      //   controller: _hours,
                                      // ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Consulting Interval",
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Lato")),
                                      SizedBox(
                                        height: 5,
                                      ),

                                      TextFormField(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 5.0, 20.0, 5.0),
                                            prefixIcon: new Icon(
                                                Icons.timer,
                                                color: Colors.redAccent),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            hintText: ""),
                                        controller: _interval,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),

                                      Text("Personal Details",
                                          style: new TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Lato",
                                              color: Colors.redAccent)),
                                      SizedBox(
                                        height: 5,
                                      ),
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
                                              20.0, 5.0, 20.0, 5.0),
                                          prefixIcon: new Icon(Icons.person,
                                              color:  Colors.redAccent),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              borderSide: BorderSide(
                                                  color: Colors.redAccent)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              borderSide: BorderSide(
                                                  color: Colors.redAccent)),
                                          filled: true,
                                          fillColor: Colors.grey[100],
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
                                                  color:  Colors.redAccent),
                                              contentPadding: EdgeInsets.fromLTRB(
                                                  20.0, 15.0, 20.0, 5.0),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(8)),
                                                  borderSide: BorderSide(
                                                      color: Colors.redAccent)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(8)),
                                                  borderSide: BorderSide(
                                                      color: Colors.redAccent)),
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              hintText: ""),
                                          autofocus: false,
                                          initialValue: widget.mobile
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
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
                                                20.0, 5.0, 20.0, 5.0),
                                            prefixIcon: new Icon(Icons.email,
                                                color:  Colors.redAccent),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent)),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            hintText: ""),
                                        controller: _email,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text("Consulting Hours",
                                          style: new TextStyle(
                                              fontSize: 25,
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
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                  ),
                                                  labelText: 'Start Time',
                                                  floatingLabelBehavior: FloatingLabelBehavior.never
                                              ),
                                              onShowPicker: (context, dt) async {
                                                final time = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
                                                  builder: (context, child) => MediaQuery(
                                                      data: MediaQuery.of(context)
                                                          .copyWith(alwaysUse24HourFormat: true),
                                                      child: child),
                                                );
                                                return DateTimeField.convert(time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => m_starttym = dt);
                                                print('Selected date: $m_starttym');
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
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                  ),
                                                  labelText: 'End Time',
                                                  floatingLabelBehavior: FloatingLabelBehavior.never
                                              ),
                                              onShowPicker: (context, dt) async {
                                                final time = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
                                                  builder: (context, child) => MediaQuery(
                                                      data: MediaQuery.of(context)
                                                          .copyWith(alwaysUse24HourFormat: true),
                                                      child: child),
                                                );
                                                return DateTimeField.convert(time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => m_endtym = dt);
                                                print('Selected date: $m_endtym');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      // DateFormat("HH:mm"),
                                      // TextFormField(
                                      //   decoration: InputDecoration(
                                      //       contentPadding: EdgeInsets.fromLTRB(
                                      //           20.0, 5.0, 20.0, 5.0),
                                      //       prefixIcon: new Icon(
                                      //           Icons.timer,
                                      //           color: new Color(0xffACCCF8)),
                                      //       enabledBorder: OutlineInputBorder(
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(8)),
                                      //           borderSide: BorderSide(
                                      //               color: Colors.redAccent)),
                                      //       focusedBorder: OutlineInputBorder(
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(8)),
                                      //           borderSide: BorderSide(
                                      //               color: Colors.redAccent)),
                                      //       filled: true,
                                      //       fillColor: Colors.grey[100],
                                      //       hintText: ""),
                                      //   controller: _hours,
                                      // ),
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
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                  ),
                                                  labelText: 'Start Time',
                                                  floatingLabelBehavior: FloatingLabelBehavior.never
                                              ),
                                              onShowPicker: (context, dt) async {
                                                final time = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
                                                  builder: (context, child) => MediaQuery(
                                                      data: MediaQuery.of(context)
                                                          .copyWith(alwaysUse24HourFormat: true),
                                                      child: child),
                                                );
                                                return DateTimeField.convert(time);

                                              },
                                              onChanged: (dt) {
                                                setState(() => e_starttym = dt);
                                                print('Selected date: $starttym');
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
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                  ),
                                                  labelText: 'End Time',
                                                  floatingLabelBehavior: FloatingLabelBehavior.never
                                              ),
                                              onShowPicker: (context, dt) async {
                                                final time = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
                                                  builder: (context, child) => MediaQuery(
                                                      data: MediaQuery.of(context)
                                                          .copyWith(alwaysUse24HourFormat: true),
                                                      child: child),
                                                );
                                                return DateTimeField.convert(time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => e_endtym = dt);
                                                print('Selected date: $e_endtym');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      // DateFormat("HH:mm"),
                                      // TextFormField(
                                      //   decoration: InputDecoration(
                                      //       contentPadding: EdgeInsets.fromLTRB(
                                      //           20.0, 5.0, 20.0, 5.0),
                                      //       prefixIcon: new Icon(
                                      //           Icons.timer,
                                      //           color: new Color(0xffACCCF8)),
                                      //       enabledBorder: OutlineInputBorder(
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(8)),
                                      //           borderSide: BorderSide(
                                      //               color: Colors.redAccent)),
                                      //       focusedBorder: OutlineInputBorder(
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(8)),
                                      //           borderSide: BorderSide(
                                      //               color: Colors.redAccent)),
                                      //       filled: true,
                                      //       fillColor: Colors.grey[100],
                                      //       hintText: ""),
                                      //   controller: _hours,
                                      // ),
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
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 170,
                                            child: DateTimeField(
                                              readOnly: true,
                                              //inputType: InputType.time,
                                              format: DateFormat("HH:mm"),
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                  ),
                                                  labelText: 'Start Time',
                                                  floatingLabelBehavior: FloatingLabelBehavior.never
                                              ),
                                              onShowPicker: (context, dt) async {
                                                final time = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
                                                  builder: (context, child) => MediaQuery(
                                                      data: MediaQuery.of(context)
                                                          .copyWith(alwaysUse24HourFormat: true),
                                                      child: child),
                                                );
                                                return DateTimeField.convert(time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => s_starttym = dt);
                                                print('Selected date: $s_starttym');
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
                                              //editable: false,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                  ),
                                                  labelText: 'End Time',
                                                  floatingLabelBehavior: FloatingLabelBehavior.never
                                              ),
                                              onShowPicker: (context, dt) async {
                                                final time = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
                                                  builder: (context, child) => MediaQuery(
                                                      data: MediaQuery.of(context)
                                                          .copyWith(alwaysUse24HourFormat: true),
                                                      child: child),
                                                );
                                                return DateTimeField.convert(time);
                                              },
                                              onChanged: (dt) {
                                                setState(() => s_endtym = dt);
                                                print('Selected date: $s_endtym');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      // DateFormat("HH:mm"),
                                      // TextFormField(
                                      //   decoration: InputDecoration(
                                      //       contentPadding: EdgeInsets.fromLTRB(
                                      //           20.0, 5.0, 20.0, 5.0),
                                      //       prefixIcon: new Icon(
                                      //           Icons.timer,
                                      //           color: new Color(0xffACCCF8)),
                                      //       enabledBorder: OutlineInputBorder(
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(8)),
                                      //           borderSide: BorderSide(
                                      //               color: Colors.redAccent)),
                                      //       focusedBorder: OutlineInputBorder(
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(8)),
                                      //           borderSide: BorderSide(
                                      //               color: Colors.redAccent)),
                                      //       filled: true,
                                      //       fillColor: Colors.grey[100],
                                      //       hintText: ""),
                                      //   controller: _hours,
                                      // ),

                                      SizedBox(
                                        height: 25,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: FlatButton(
                                          child: Text("SAVE",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Lato",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(25.0),
                                              side: BorderSide(
                                                  color: Colors.redAccent)),
                                          padding: EdgeInsets.all(16),
                                          onPressed: () async {
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
                                              formatDate(m_starttym, [ HH , ':', nn]).toString(),
                                              formatDate(m_endtym, [ HH , ':', nn]).toString(),
                                              formatDate(e_starttym, [ HH , ':', nn]).toString(),
                                              formatDate(e_endtym, [ HH , ':', nn]).toString(),
                                              formatDate(s_starttym, [ HH , ':', nn]).toString(),
                                              formatDate(s_endtym, [ HH , ':', nn]).toString(),                                            );
                                            setState(() {
                                              qrData=widget.mobile;
                                            });
                                            //Navigator.pop(context);
                                          },
                                          //TODO: Take the mobile number and generate bar code
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
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

  Future<void> updatingProfile(File image, String doctorId, String hospitalName,
      String specialist, String degree, String dName, String email,String Qrdata,String address, String starttym,String endtym,String interval, String mstarttym,String mendtym,String estarttym,String eendtymm,String sstarttym,String sendtym) async {

    if(image != null){
      String fileName = "image" + widget.userId;
      StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
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
            sendtym
          );
        }else {
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
              sendtym
            );
          }
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorNewDashboard(widget.userId, widget.mobile),
          ),
        );
       }
    }else{
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
          sendtym
        );
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorNewDashboard(widget.userId, widget.mobile),
        ),
      );
    }
  }
}
