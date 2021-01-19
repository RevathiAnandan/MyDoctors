import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/improvement/new.dart';
import 'package:myarogya_mydoctor/model/Booking.dart';
import 'package:intl/intl.dart';

class MyIncomePage extends StatefulWidget {

  final String title;
  final String mobile;

  MyIncomePage(this.title,this.mobile);

  @override
  _MyIncomePageState createState() => _MyIncomePageState();
}

class _MyIncomePageState extends State<MyIncomePage> {
  List<Booking> dummyData = [];
  List refresh = [];
  List keys1 = [];
  List<Booking> rooms = [];
  List<Booking> packages = [];
  List<Booking> pathology = [];
  List<Booking> surgery = [];
  FirebaseDatabase fb = FirebaseDatabase.instance;
  bool isLoading = true;
  double month =double.parse(DateTime.now().month.toString());
  Timer timer;
  int intmonth = DateTime.now().month-1;
  int charges = 0;
  List<String> months = ["January","February","March","April","May", "June","July","August","September","October","November","December"];
  List<String> shortmonths = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooking();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.redAccent,
            onPressed: ()=>Navigator.pop(context),
          ),
          title: Text(widget.title,style: TextStyle(color: Colors.redAccent),),
          backgroundColor: Colors.white,
        ),
        body: isLoading?LinearProgressIndicator(
          backgroundColor: Colors.redAccent,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
        ):Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              SizedBox(
                height: 15 ,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Month to display data"),
                  Container(height:40,width:80,child: Card(color: Colors.redAccent,child: Center(child: Text(months[intmonth],style: TextStyle(color: Colors.white),)),))
                ],
              ),
              Slider(
                activeColor: Colors.redAccent,
                value: month,
                onChanged: (newMonth){
                  cleardata();
                  setState(() {
                    month = newMonth;
                  });
                  intmonth = month.toInt()-1;
                  seperatetype(months[intmonth]);
                  print(intmonth-1);
                },
                max: 12,
                min: 1,
                label: shortmonths[intmonth],
                divisions: 11,
              ),
              SizedBox(
                height: 15 ,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Total income"),
                    Text("Rs."+(((dummyData.length*100)*40)/100).toString().split(".")[0]),
                  ],
                ),
              ),
              SizedBox(
                height: 15 ,
              ),
              Divider(
                height: 5,
                thickness: 1.5,
              ),
              // Text("Room Bookings"),
              // databody(rooms),
              Container(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    columnSpacing: 0,
                    columns: [
                      DataColumn(label: Text("Type")),
                      DataColumn(label: Text("Count")),
                      DataColumn(label: Text("Gain")),
                    ],
                    rows: rooms.isNotEmpty?[getdatarow(rooms,"Beds")]:[DataRow(
                cells: [
                  DataCell(Container(width:100,child:Text("Beds"))),
                  DataCell(Container(child:Text("     0"))),
                  DataCell(Container(child:Text(" 0"))),
                ]
              )]
                ),
              ),
              // Text("Packages Bookings"),
              Container(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    columnSpacing: 0,
                    headingRowHeight: 0,
                    columns: [
                      DataColumn(label: Text("")),
                      DataColumn(label: Text("")),
                      DataColumn(label: Text("")),
                    ],
                    rows: packages.isNotEmpty?[getdatarow(packages,"Packages")]:[DataRow(
                    cells: [
                    DataCell(Container(width:75,child:Text("Packages"))),
              DataCell(Container(child:Text("       0"))),
              DataCell(Container(child:Text("0"))),
            ]
          )]
                ),
              ),
              // Text("Pathology Bookings"),
              Container(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    columnSpacing: 0,
                    headingRowHeight: 0,
                    columns: [
                      DataColumn(label: Text("")),
                      DataColumn(label: Text("")),
                      DataColumn(label: Text("")),
                    ],
                    rows: pathology.isNotEmpty?[getdatarow(pathology,"Pathology")]:[DataRow(
                    cells: [
                      DataCell(Container(width:100,child:Text("Pathology"))),
                      DataCell(Container(child:Text("0"))),
                      DataCell(Container(child:Text("0"))),
            ]
          )]
                ),
              ),
              // Text("Surgery Bookings"),
              Container(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    columnSpacing: 0,
                    headingRowHeight: 0,
                    columns: [
                      DataColumn(label: Text("")),
                      DataColumn(label: Text("")),
                      DataColumn(label: Text("")),
                    ],
                    rows: surgery.isNotEmpty?[getdatarow(surgery,"Surgery")]:[DataRow(
                    cells: [
                      DataCell(Container(width:100,child:Text("Surgery"))),
                      DataCell(Container(child:Text("0"))),
                      DataCell(Container(child:Text("0"))),
            ]
          )]
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Monthly income"),
                    Text("Rs."+(((charges*100)*40)/100).toString().split(".")[0]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Booking> getBooking() async {
    try {
      var db = await fb.reference().child("HospitalBookings");
      db.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Booking.fromJson(values);
          print(refreshToken);
          setState(() {
            if (refreshToken.bookingNumber == widget.mobile) {
              dummyData.add(refreshToken);
              keys1.add(key);
            }
          });
        });
        print(dummyData);
        seperatetype(DateFormat.MMMM().format(DateTime.now()));
      });
    } catch (e) {
      print(e);
    }
  }
  seperatetype(String monthvalue){
    print("Enter FOr loop");
    print(DateFormat.MMMM().format(DateTime.now()));
    for(int i=0;i<dummyData.length;i++){
      if (dummyData[i].BookingDate!="") {
        print(dummyData[i].BookingDate.split(" ")[2]);
      } else {

      }
      if (dummyData[i].BookingDate!="") {
        if(dummyData[i].bookdetails[0].type=="Rooms" && dummyData[i].BookingDate.split(" ")[1]==monthvalue && dummyData[i].BookingDate.split(" ")[2]=="2021"){
                rooms.add(dummyData[i]);
                print(dummyData[i].bookdetails[0].noOfBeds);
                charges = charges + int.parse(dummyData[i].bookdetails[0].noOfBeds);
              }else if(dummyData[i].bookdetails[0].type=="Pathology"&& dummyData[i].BookingDate.split(" ")[1]==monthvalue&& dummyData[i].BookingDate.split(" ")[2]=="2021"){
                pathology.add(dummyData[i]);
                print(dummyData[i].bookdetails[0].type);
                charges = charges + 1;
                print(dummyData[i].bookdetails[0].type);
              }else if(dummyData[i].bookdetails[0].type=="Packages"&& dummyData[i].BookingDate.split(" ")[1]==monthvalue&& dummyData[i].BookingDate.split(" ")[2]=="2021"){
                packages.add(dummyData[i]);
                charges = charges +1;
                print(dummyData[i].bookdetails[0].type);
              }else if(dummyData[i].bookdetails[0].type=="Surgery"&& dummyData[i].BookingDate.split(" ")[1]==monthvalue&& dummyData[i].BookingDate.split(" ")[2]==DateTime.now().year.toString()){
                surgery.add(dummyData[i]);
                charges = charges + 1;
                print(dummyData[i].bookdetails[0].type);
              }
      } else {

      }
    }
    print("Out of ForLoop");
    setState(() {
      isLoading = false;
    });
  }
  getdatarow(List type,String catogory){
     var totalcount = 0;
     var totalincome = 0;
     for(int i=0;i<type.length;i++){
       if(type[i].bookdetails[0].type=="Rooms"){
       totalcount = totalcount + int.parse(type[i].bookdetails[0].noOfBeds);
       }else{
         totalcount = type.length;
         break;
       }
     }
     totalincome = totalcount * 100;
     return DataRow(
       cells: [
         DataCell(Container(width:80,child: Text(catogory))),
         DataCell(Container(width:50,child: Text(totalcount.toString()))),
         DataCell(Text(totalincome.toString())),
       ]
     );
  }
  cleardata(){
    rooms.clear();
    pathology.clear();
    surgery.clear();
    packages.clear();
    charges=0;
  }
}
