import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/MyPatient.dart';
import 'package:myarogya_mydoctor/model/chat_model.dart';
import 'package:myarogya_mydoctor/model/myDoctorModel.dart';
import 'package:myarogya_mydoctor/model/patient.dart';
import 'package:myarogya_mydoctor/pages/Doctor/createPrecription.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_PrescriptionList.dart';
import 'package:myarogya_mydoctor/pages/patient/PrescriptionList.dart';
import 'package:myarogya_mydoctor/pages/patient/showPrecription.dart';

class MyScreen extends StatefulWidget {
  String mobile;
  String category;
  MyScreen(this.mobile,this.category);
  @override
  MyScreenState createState() {
    return new MyScreenState();
  }
}

class MyScreenState extends State<MyScreen> {
  List dummyData = [];
  FirebaseDatabase fb = FirebaseDatabase.instance;
  var isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.category == "MY PATIENT"){
      getMyPatient();
    }else{
      getMyDoctor();
    }

  }
  @override
  Widget build(BuildContext context) {
    return  isLoading
        ? Center(
        child: CircularProgressIndicator() ):
    (dummyData.isEmpty? Center(child: Text("No Data Found!!")):new ListView.builder(
      itemCount:dummyData.length,
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
                  dummyData[i].name != null ? dummyData[i].name : "" ,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
//                    new Text(
//                      dummyData[i]['patientMobile'],
//                      style: new TextStyle(color: Colors.grey, fontSize: 14.0),
//                    ),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                dummyData[i].phone != null ?dummyData[i].phone:"",
                style: new TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
            onTap: (){
              if(widget.category == "MY PATIENT"){
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => CreatePrescription(dummyData[i].phone,widget.mobile,dummyData[i].name)),
//                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorPrescriptionList(widget.mobile,dummyData[i].phone,dummyData[i].name)),
                );
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PescriptionList(dummyData[i].phone,widget.mobile)),
                );
              }
            },
          )
        ],
      ),
    )
    );
  }


  Future <Patient> getMyPatient() async{

    isLoading = true;
    try {
      var db = await fb.reference().child("User").child(widget.mobile).child("myPatient");
      db.once().then  ((DataSnapshot snapshot){
        print(snapshot.value);
        Map<dynamic, dynamic > values = snapshot.value;
        values.forEach((key,values) {
          var refreshToken = Patient.fromJson(values);
          print(refreshToken);
          setState(() {
            dummyData.add(refreshToken);
            print(dummyData);
            isLoading = false;
          });

        });


//        setState(() {
//          dummyData = snapshot.value;
//          isLoading = false;
//        });
//        print(dummyData[0]);
      }
      );

    } catch (e) {
      print(e);
    }
  }

 Future <Patient> getMyDoctor()async{
    isLoading = true;
    try {
      var db = await fb.reference().child("User").child(widget.mobile).child("myDoctor");
      db.once().then  ((DataSnapshot snapshot){
        print(snapshot.value);
        Map<dynamic, dynamic > values = snapshot.value;
        values.forEach((key,values) {
          var refreshToken = Patient.fromJson(values);
          print(refreshToken);
          setState(() {
            dummyData.add(refreshToken);
            print(dummyData);
            isLoading = false;
          });

        });


//        setState(() {
//          dummyData = snapshot.value;
//          isLoading = false;
//        });
//        print(dummyData[0]);
      }
      );

    } catch (e) {
      print(e);
    }
  }

}
