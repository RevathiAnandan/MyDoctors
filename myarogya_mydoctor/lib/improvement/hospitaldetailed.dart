import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';
import 'package:myarogya_mydoctor/services/datasearch.dart';
import 'package:myarogya_mydoctor/utils/const.dart';

import 'addhospitals.dart';

class HospitalDetails extends StatefulWidget {
  int index;
  String hospitalname;

  HospitalDetails(this.index, this.hospitalname);

  @override
  _HospitalDetailsState createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails> {
  @override
  List<Hospital> hospitalvalues = [];
  bool isLoading=true;
  final controller = PageController(initialPage: 1,);
  FirebaseDatabase fb = FirebaseDatabase.instance;
  void initState() {
    // TODO: implement initState
    super.initState();
    getHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading?Align(
          alignment: Alignment.center,
          child: Container(
            width: 100,
              child: LinearProgressIndicator(backgroundColor: Colors.redAccent,valueColor:new AlwaysStoppedAnimation<Color>(Colors.green),)),
        ):SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 230,
                //   child: PageView(
                //     controller: controller,
                //     children: [
                //     Image(
                //                 image: NetworkImage(
                //                   hospitalvalues[0].image[0],
                //                 ),
                //                 height: 150,
                //                 width: 200,
                //                 alignment: Alignment.centerLeft,
                //               )
                //     ],
                //   ),
                // )
                Row(
                  children: [
                    Container(
                      height: 230,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.count(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(0),
                        crossAxisCount: 1,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        shrinkWrap: true,
                        children: List.generate(hospitalvalues[0].image.length, (index) {
                          return Image(
                            image: NetworkImage(
                              hospitalvalues[0].image[index],
                            ),
                            height: 150,
                            width: 200,
                            alignment: Alignment.centerLeft,
                          );
                        },),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospitalvalues[0].hospitalName,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 28.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Administration Name: " +hospitalvalues[0].adminName,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Admin Registration Number: " +hospitalvalues[0].hospitalRegNo,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Hospital Address: " +hospitalvalues[0].hospitalAddress,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Facilities: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      getfacility(hospitalvalues[0].facilities),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Speciality: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      getspeciality(hospitalvalues[0].specialities),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Bed Details: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 400,
                        child: DataTable(
                          columnSpacing: 0,
                          columns: [
                            DataColumn(label: Text("Type")),
                            DataColumn(label: Text(" Number")),
                            DataColumn(label: Text("Charges/day")),
                          ],
                          rows: hospitalvalues[0].freebeds.map((e) =>
                              DataRow(
                                cells: [
                                  DataCell(Container(width:130,child: Text(e.roomType))),
                                  DataCell(Container(width:50,child: Text(e.noOfBeds))),
                                  DataCell(Text(e.charges)),
                                ]
                              ),
                          ).toList()
                        ),
                      ),
                      Container(
                        width: 400,
                        child: DataTable(
                            columnSpacing: 0,
                          headingRowHeight: 0,
                          columns: [
                            DataColumn(label: Text("")),
                            DataColumn(label: Text("")),
                            DataColumn(label: Text("")),
                          ],
                          rows: hospitalvalues[0].conbeds.map((e) =>
                              DataRow(
                                cells: [
                                  DataCell(Container(width:90,child: Text(e.roomType))),
                                  DataCell(Text(e.noOfBeds)),
                                  DataCell(Text(e.charges)),
                                ]
                              ),
                          ).toList()
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      getdatatable(hospitalvalues[0].beds),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "TPA Details: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      getTPAlist(hospitalvalues[0].tpalist),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Accrediation: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   hospitalvalues[0].accred,
                      //   style: TextStyle(
                      //     color: Colors.redAccent,
                      //     fontSize: 16.0,
                      //     fontFamily: 'Lato',
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),

                      getaccred(hospitalvalues[0].accred),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Important Numbers",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Administration Ph: "+hospitalvalues[0].adminPh,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Ambulance: "+hospitalvalues[0].ambulanceNo,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Booking Ph: "+hospitalvalues[0].bookingPhNo,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Emergency Number: "+hospitalvalues[0].emergencyNo,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "OPD Booking: "+hospitalvalues[0].opdBookingNo,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Health Packages:",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 400,
                        child: DataTable(
                            columnSpacing: 0,
                            columns: [
                              DataColumn(label: Text("Package Name")),
                              DataColumn(label: Text("Amount")),

                            ],
                            rows: hospitalvalues[0].health.map((e) =>
                                DataRow(
                                    cells: [
                                      DataCell(Container(width:130,child: Text(e.packagename))),
                                      DataCell(Container(width:50,child: Text(e.amount))),
                                    ]
                                ),
                            ).toList()
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Diagnosis Details:",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 400,
                        child: DataTable(
                            columnSpacing: 0,
                            columns: [
                              DataColumn(label: Text("Package Name")),
                              DataColumn(label: Text("Amount")),

                            ],
                            rows: hospitalvalues[0].diagnosis.map((e) =>
                                DataRow(
                                    cells: [
                                      DataCell(Container(width:130,child: Text(e.test))),
                                      DataCell(Container(width:50,child: Text(e.charge))),
                                    ]
                                ),
                            ).toList()
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Hospital> getHospitals() async {
    var db = await fb.reference().child("Hospitals");
    print(db);
    try {
      if (db != null) {
        db.once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key, value) {
            var refreshToken = Hospital.fromJson(value);
            setState(() {
              if(widget.hospitalname==refreshToken.hospitalName) {
                hospitalvalues.add(refreshToken);
              }
            });
            print("Hops::::${hospitalvalues.toString()}");
            setState(() {
              isLoading=false;
            });
          });
        });
      } else {
        print('Something is Null');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget getfacility(List facility){
    List<Widget> list = new List<Widget>();
    for(var name in facility){
      list.add(new Text(
          name+" ",
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 16.0,
          fontFamily: 'Lato',
          //fontWeight: FontWeight.bold,
        ),
      )
      );
    }
    return new  Wrap(
        spacing: 5.0,
        runSpacing: 3.0,
        children: list);

  }
  Widget getspeciality(List speciality){
    List<Widget> list = new List<Widget>();
    for(var name in speciality){
      list.add(new Text(
          name+" ",
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 16.0,
          fontFamily: 'Lato',
          //fontWeight: FontWeight.bold,
        ),
      )
      );
    }
    return new  Wrap(
        spacing: 5.0,
        runSpacing: 3.0,
        children: list);

  }
  Widget getaccred(List accred){
    List<Widget> list = new List<Widget>();
    for(int i=0;i<accred.length;i++){
      list.add(
          new Text(
            accred[i].accredName,
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 16.0,
              fontFamily: 'Lato',
              //fontWeight: FontWeight.bold,
            ),
          )
      );
    }
    return new  Wrap(
        spacing: 5.0,
        runSpacing: 3.0,
        children: list);

  }

  getdatatable(List<OtherBeds> beds) {
    List<Widget> list = new List<Widget>();
    for(int i=0;i<beds.length;i++){
      list.add(new Container(
        width: 400,
        child: DataTable(
            columnSpacing: 0,
            headingRowHeight: 0,
            columns: [
              DataColumn(label: Text("")),
              DataColumn(label: Text("")),
              DataColumn(label: Text("")),
            ],
            rows: hospitalvalues[0].beds.map((e) =>
                DataRow(
                    cells: [
                      DataCell(Container(width:90,child: Text(e.roomType))),
                      DataCell(Text(e.noOfBeds)),
                      DataCell(Text(e.charges)),
                    ]
                ),
            ).toList()
        ),
      ));
    }
    return Column(
      children: list,
    );
  }

  getTPAlist(List tpalist) {
    List<Widget> list = new List<Widget>();
    for(int i=0;i<tpalist.length;i++){
      list.add(
          new Text(
            tpalist[i].insurName,
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 16.0,
              fontFamily: 'Lato',
              //fontWeight: FontWeight.bold,
            ),
          )
      );
    }
    return new  Wrap(
        spacing: 5.0,
        runSpacing: 3.0,
        children: list);
  }




}
