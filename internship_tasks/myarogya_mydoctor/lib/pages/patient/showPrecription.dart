import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myarogya_mydoctor/model/DoctorUser.dart';
import 'package:myarogya_mydoctor/model/Precription.dart';
import 'package:myarogya_mydoctor/services/authService.dart';

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
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                  child:  isLoading
                      ? Center(
                      child: CircularProgressIndicator() ): Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              refreshValue['hospitalName']!=null?refreshValue['hospitalName']:"Yet to be updated",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24,fontFamily: 'Lato'),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 50,
                              width: 150,
                              child: Text(refreshValue['mobile']!=null?refreshValue['mobile']:"Yet to be updated",
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Text(
                          'Door no. 5, Unique Home, Tirupathi& Virar[Weif], Palghar - 401 303',style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                              children:[
                                Text(refreshValue['Name']!=null?refreshValue['Name']:"Yet to be updated",style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),),
                                Text(refreshValue['registerId']!=null?refreshValue['registerId']:"Yet to be updated",style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),),
                                Text(refreshValue['specialist']!=null?refreshValue['specialist']:"Yet to be updated",style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),),
                                Text(refreshValue['emailId']!=null?refreshValue['emailId']:"Yet to be updated",style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),),
                              ]
                          ),
                          Column(
                              children:[
                                Text('Consulting Hours',style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),),
                                Text('Morning:9:30am to 1:30pm',style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),),
                                Text('Evening:6:00pm to 10:00pm',style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),),
                                Text('Sunday:9:30am to 12:00pm',style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),),
                              ]
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
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
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Date: '+widget.prescripe.date,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),
                    ),
                  ),
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
                            'BP: '+widget.prescripe.bp,
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
                Container(
                  child: dataBody(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: dataBodyTest(),
                ),

                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('Prescribed on '+widget.prescripe.nextVisit,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lato'),
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
//      getPrecriptionDetails();

//      print (doctorProfileInfo.Name);

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
          DataColumn(
              label: Text("Diagnosis",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
          ),
          DataColumn(
              label: Text("Medicine/Tests",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
          ),
          DataColumn(
              label: Text("Dosage",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
          ),
          DataColumn(
              label: Text("Duration",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
          ),
          DataColumn(
              label: Text("Days",
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
                  DataCell(
                    Text(widget.prescripe.diagnosis, style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12,fontFamily: 'Lato')),
                  ),
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
                      Text(e.days,style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12,fontFamily: 'Lato'))
                  )
                ]
            ),
        ).toList(),
        columnSpacing: 20.0,
      ),
    );
  }

  DataTable dataBodyTest() {
    return DataTable(
      columns: [
        DataColumn(
            label: Text("Lab Tests:",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'Lato'))
        ),

      ],

      rows: widget.prescripe.labTest.map((e) =>
          DataRow(
              cells: [
                DataCell(
                  Text(e.test, style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12,fontFamily: 'Lato')),
                ),

              ]
          ),
      ).toList(),
      columnSpacing: 0.0,
      dividerThickness: 0.0,
    );
  }
}
