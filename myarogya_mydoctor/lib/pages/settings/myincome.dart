import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/improvement/new.dart';
import 'package:myarogya_mydoctor/model/Booking.dart';
import 'package:table_calendar/table_calendar.dart';
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
  Timer timer;
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
              Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  color: Colors.redAccent,
                  child: Text("Monthly wise"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CalenderView(title: "Monthy Income",mobile: widget.mobile)));
                  },
                ),
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
                    Text("Rs."+(dummyData.length*100).toString()),
                  ],
                ),
              ),
              SizedBox(
                height: 15 ,
              ),
              Text("Room Bookings"),
              // databody(rooms),
              Container(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    columnSpacing: 0,
                    columns: [
                      DataColumn(label: Text("Date")),
                      DataColumn(label: Text("Beds Booked")),
                      DataColumn(label: Text("My Income")),
                    ],
                    rows: [getdatarow(rooms)]
                ),
              ),
              Text("Packages Bookings"),
              Container(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    columnSpacing: 0,
                    columns: [
                      DataColumn(label: Text("Date")),
                      DataColumn(label: Text("Booked Count")),
                      DataColumn(label: Text("My Income")),
                    ],
                    rows: [getdatarow(packages)]
                ),
              ),
              Text("Pathology Bookings"),
              Container(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    columnSpacing: 0,
                    columns: [
                      DataColumn(label: Text("Date")),
                      DataColumn(label: Text("Booked Count")),
                      DataColumn(label: Text("My Income")),
                    ],
                    rows: [getdatarow(pathology)]
                ),
              ),
              Text("Surgery Bookings"),
              Container(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                    columnSpacing: 0,
                    columns: [
                      DataColumn(label: Text("Date")),
                      DataColumn(label: Text("Booked Count")),
                      DataColumn(label: Text("My Income")),
                    ],
                    rows: [getdatarow(surgery)]
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
        seperatetype();
      });
    } catch (e) {
      print(e);
    }
  }
  seperatetype(){
    print("Enter FOr loop");
    print(DateTime.now().month.toString());
    for(int i=0;i<dummyData.length;i++){
      if(dummyData[i].bookdetails[0].type=="Rooms" && dummyData[i].BookingDate.split(" ")[1]==DateFormat.MMMM().format(DateTime.now())){
        rooms.add(dummyData[i]);
        print(dummyData[i].bookdetails[0].type);
      }else if(dummyData[i].bookdetails[0].type=="Pathology"&& dummyData[i].BookingDate.split(" ")[1]==DateFormat.MMMM().format(DateTime.now())){
        pathology.add(dummyData[i]);
        print(dummyData[i].bookdetails[0].type);
      }else if(dummyData[i].bookdetails[0].type=="Packages"&& dummyData[i].BookingDate.split(" ")[1]==DateFormat.MMMM().format(DateTime.now())){
        packages.add(dummyData[i]);
        print(dummyData[i].bookdetails[0].type);
      }else if(dummyData[i].bookdetails[0].type=="Surgery"&& dummyData[i].BookingDate.split(" ")[1]==DateFormat.MMMM().format(DateTime.now())){
        surgery.add(dummyData[i]);
        print(dummyData[i].bookdetails[0].type);
      }
    }
    print("Out of ForLoop");
    setState(() {
      isLoading = false;
    });
  }
  getdatarow(List<Booking> type){
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
         DataCell(Container(width:130,child: Text(type[0].BookingDate.split(" ")[1]))),
         DataCell(Container(width:50,child: Text(totalcount.toString()))),
         DataCell(Text(totalincome.toString())),
       ]
     );
  }
}
