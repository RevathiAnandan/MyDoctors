import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myarogya_mydoctor/model/DoctorUser.dart';
import 'package:myarogya_mydoctor/model/Precription.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:date_format/date_format.dart';

class ShowPrecription extends StatefulWidget {
  Prescription prescripe;
  String pmobile;
  String dmobile;

  ShowPrecription(this.prescripe,this.dmobile,this.pmobile);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<ShowPrecription> {
  DoctorUser doctorProfileInfo;
  Prescription prescription1;
  var refreshValue;
  var isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              //padding: EdgeInsets.only(left: 20, top: 20, right: 20),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*25/100,
                     padding: EdgeInsets.only(left: 15, top: 10, right: 15),
                    child:  isLoading
                        ? Center(
                        child: CircularProgressIndicator() ): Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //width: 200,
                              child: Text(
                                refreshValue['hospitalName']!=null?refreshValue['hospitalName']:"Yet to be updated",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24,fontFamily: 'Lato'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          child: Text(refreshValue['Hospital Address']!=null?refreshValue['Hospital Address']:"Yet to be updated",style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),),
                        ),
                        Divider(
                          height: 10,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                                children:[
                                  Text(refreshValue['registerId']!=null?"Doctor ID:"+refreshValue['registerId']:"Yet to be updated",style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),),
                                  Text(refreshValue['Name']!=null?"Name: Dr."+refreshValue['Name']:"Yet to be updated",style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),),
                                  Text(refreshValue['degree']!=null?refreshValue['degree']:"Yet to be updated",style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),),
                                  Text(refreshValue['specialist']!=null?"Specialist:"+refreshValue['specialist']:"Yet to be updated",style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),),
                                  Text(refreshValue['emailId']!=null?refreshValue['emailId']:"Yet to be updated",style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),),
                                ]
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                                children:[

                                  Text('Consulting Hours',style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),),
                                  Text("Morning: "+timesplit1(refreshValue['Morning Start Time']) +" to "+timesplit1(refreshValue['Morning End Time']) ,style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),),
                                  Text("Evening: "+timesplit1(refreshValue['Evening Start Time']) +" to "+timesplit1(refreshValue['Evening End Time']) ,style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),),
                                  Text("Sunday: "+timesplit1(refreshValue['Sunday Start Time']) +" to "+timesplit1(refreshValue['Sunday End Time']) ,style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(refreshValue['mobile']!=null?"Contact:"+refreshValue['mobile']:"Yet to be updated",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),),
                                ]
                            )
                          ],
                        ),
                        Divider(
                          height: 10,
                          thickness: 2,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Patient Name: '+widget.prescripe.patientName+', '+ widget.prescripe.patientMobile,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Date: '+datesplit(widget.prescripe.date),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Time: '+timesplit(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'BP: '+widget.prescripe.bp +'/'+widget.prescripe.bpHigh,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),
                            ),
                            Text(
                              'Pulse: '+widget.prescripe.pulse,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),
                            ),
                            Text(
                              'Weight: '+widget.prescripe.weight,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),
                            ),
                          ],
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
            Align(
              alignment: Alignment.centerLeft,
                  child:Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                    'Diagnosis:   '+widget.prescripe.diagnosis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),
                  ),
                  ),
            ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    child: dataBody(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
//                  Container(
//                    child: dataBodyTest(),
//                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Lab Test:   '+widget.prescripe.labTest,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text('  Next Visit on '+datesplit(widget.prescripe.nextVisit),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )

      ),
    );
  }


  Future<DoctorUser> getProfileDetails(){
    isLoading = true;
    FirebaseDatabase fb = FirebaseDatabase.instance;
    try {
      var db = fb.reference().child("User").child(widget.dmobile);
      db.once().then((DataSnapshot snapshot){
        print (snapshot.value);

        setState(() {
//        doctorProfileInfo = DoctorUser.fromJson(snapshot.value);
//        print (doctorProfileInfo.Name);
          refreshValue =  snapshot.value;
          isLoading = false;
        });

      });

    } catch (e) {
      print(e);
    }
  }


  Future<Prescription> getPrecriptionDetails(){
    FirebaseDatabase fb = FirebaseDatabase.instance;
    try {
      var db = fb.reference().child("Prescription").child(widget.pmobile);
      db.once().then((DataSnapshot snapshot){
        print (snapshot.value);
        Map<dynamic, dynamic > values = snapshot.value;
        values.forEach((key,values) {
//          var refreshToken = Patient.fromJson(values);
          setState(() {
            prescription1 = Prescription.fromJson(values);
            isLoading = false;
          });
        });

        print (prescription1);

      });

    } catch (e) {
      print(e);
    }
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
//          DataColumn(
//              label: Text("Diagnosis",
//                  style: TextStyle(
//                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
//          ),
          DataColumn(
              label: Text("Medicine",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
          ),
          DataColumn(
              label: Text("Dosage",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
          ),
          DataColumn(
              label: Text("To be taken",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
          ),
          DataColumn(
              label: Text("Duration",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
          ),
          // DataColumn(
          //     label: Text("Hello",
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
          // )
        ],

        rows: widget.prescripe.details.map((e) =>
            DataRow(
                cells: [
//                  DataCell(
//                    Text(widget.prescripe.diagnosis, style: TextStyle(
//                        fontWeight: FontWeight.bold, fontSize: 12,fontFamily: 'Lato')),
//                  ),
                  DataCell(
                      Text(e.medicine,style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12,fontFamily: 'Lato'))
                  ),
                  DataCell(
                      Text(e.dosage, style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12,fontFamily: 'Lato'))
                  ),
                  DataCell(
                      Text(e.duration, style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12,fontFamily: 'Lato'))
                  ),
                  DataCell(
                      Text("${e.days } Days",style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12,fontFamily: 'Lato'))
                  )
                ]
            ),
        ).toList(),
        columnSpacing: 28.0,
      ),
    );
  }

//  DataTable dataBodyTest() {
//    return DataTable(
//      columns: [
//        DataColumn(
//            label: Text("Lab Tests:",
//                style: TextStyle(
//                    fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
//        ),
//
//      ],
//
//      rows: widget.prescripe.labTest.map((e) =>
//          DataRow(
//              cells: [
//                DataCell(
//                  Text(e.test, style: TextStyle(
//                      fontWeight: FontWeight.bold, fontSize: 12,fontFamily: 'Lato')),
//                ),
//
//              ]
//          ),
//      ).toList(),
//      columnSpacing: 0.0,
//      dividerThickness: 0.0,
//    );
//  }

 String datesplit(String date1){
    var date = date1.split("/");
    return date[0];
  }
  String timesplit(){
    var time = widget.prescripe.date.split("/");
    return time[1];
  }
  timesplit1(String time){
    var time1 = time.split("/")[1];
    return time1;
  }
}
