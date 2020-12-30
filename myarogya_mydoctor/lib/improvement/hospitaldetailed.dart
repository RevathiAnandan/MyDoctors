import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';
import 'package:myarogya_mydoctor/services/datasearch.dart';
import 'package:myarogya_mydoctor/utils/const.dart';

import 'addhospitals.dart';

class HospitalDetails extends StatefulWidget {
  int index;
  
  Hospital hospitalvalues;
  HospitalDetails(this.index, this.hospitalvalues);

  @override
  _HospitalDetailsState createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails> {
  @override
  bool isLoading=true;
  final controller = PageController(initialPage: 1,);
  FirebaseDatabase fb = FirebaseDatabase.instance;
  void initState() {
    // TODO: implement initState
    super.initState();
    // getHospitals();
    isLoading=false;
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
                //                   widget.hospitalvalues.image[0],
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
                        children: List.generate(widget.hospitalvalues.image.length, (index) {
                          return Image(
                            image: NetworkImage(
                              widget.hospitalvalues.image[index],
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
                        widget.hospitalvalues.hospitalName,
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
                      Row(
                        children: [
                          Text(
                            "Administration Name: ",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.hospitalvalues.adminName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   "Admin Registration Number: " +widget.hospitalvalues.hospitalRegNo,
                      //   style: TextStyle(
                      //     color: Colors.redAccent,
                      //     fontSize: 16.0,
                      //     fontFamily: 'Lato',
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Hospital Address: " ,
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.hospitalvalues.hospitalAddress,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "TPA Details: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      getTPAlist(widget.hospitalvalues.tpalist),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Facilities: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      getfacility(widget.hospitalvalues.facilities),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Speciality: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      getspeciality(widget.hospitalvalues.specialities),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Bed Details: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 400,
                        child: DataTable(
                          columnSpacing: 0,
                          columns: [
                            DataColumn(label: Text("Type",style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)),
                            DataColumn(label: Text(" Number",style: TextStyle(

                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),)),
                            DataColumn(label: Text("Charges/day",style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),)),
                          ],
                          rows: widget.hospitalvalues.freebeds.map((e) =>
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
                          rows: widget.hospitalvalues.conbeds.map((e) =>
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
                          rows: widget.hospitalvalues.covidbeds.map((e) =>
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
                      getdatatable(widget.hospitalvalues.beds),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Pathology Charges:",
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
                            rows: widget.hospitalvalues.diagnosis.map((e) =>
                                DataRow(
                                    cells: [
                                      DataCell(Container(width:130,child: Text(e.test))),
                                      DataCell(Container(width:50,child: Text(e.charge))),
                                    ]
                                ),
                            ).toList()
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
                            rows: widget.hospitalvalues.health.map((e) =>
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
                        "Surgery & Other Packages:",
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
                              DataColumn(label: Text("Surgery Name")),
                              DataColumn(label: Text("Amount")),

                            ],
                            rows: widget.hospitalvalues.surgery.map((e) =>
                                DataRow(
                                    cells: [
                                      DataCell(Container(width:130,child: Text(e.surgeryname))),
                                      DataCell(Container(width:50,child: Text(e.suramount))),
                                    ]
                                ),
                            ).toList()
                        ),
                      ),


                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   "Important Numbers",
                      //   style: TextStyle(
                      //     color: Colors.redAccent,
                      //     fontSize: 20.0,
                      //     fontFamily: 'Lato',
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   "Administration Ph: "+widget.hospitalvalues.adminPh,
                      //   style: TextStyle(
                      //     color: Colors.redAccent,
                      //     fontSize: 16.0,
                      //     fontFamily: 'Lato',
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   "Ambulance: "+widget.hospitalvalues.ambulanceNo,
                      //   style: TextStyle(
                      //     color: Colors.redAccent,
                      //     fontSize: 16.0,
                      //     fontFamily: 'Lato',
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   "Booking Ph: "+widget.hospitalvalues.bookingPhNo,
                      //   style: TextStyle(
                      //     color: Colors.redAccent,
                      //     fontSize: 16.0,
                      //     fontFamily: 'Lato',
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   "Emergency Number: "+widget.hospitalvalues.emergencyNo,
                      //   style: TextStyle(
                      //     color: Colors.redAccent,
                      //     fontSize: 16.0,
                      //     fontFamily: 'Lato',
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   "OPD Booking: "+widget.hospitalvalues.opdBookingNo,
                      //   style: TextStyle(
                      //     color: Colors.redAccent,
                      //     fontSize: 16.0,
                      //     fontFamily: 'Lato',
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),


                      SizedBox(
                        height: 15,
                      ),



                      Text(
                        "Doctor Details:",
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
                              DataColumn(label: Text("Doctor Name")),
                              DataColumn(label: Text("Phone Number")),
                              DataColumn(label: Text("Specialist")),

                            ],
                            rows: widget.hospitalvalues.doctorslist.map((e) =>
                                DataRow(
                                    cells: [
                                      DataCell(Container(width:150,child: Text(e.name))),
                                      DataCell(Container(width:100,child: Text(e.phno))),
                                      DataCell(Container(width:100,child: Text(e.Specialist))),
                                    ]
                                ),
                            ).toList()
                        ),
                      ),
                      Text(
                        "Nurse Details:",
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
                              DataColumn(label: Text("Nurse Name")),
                              DataColumn(label: Text("Phone Number")),

                            ],
                            rows: widget.hospitalvalues.nurseslist.map((e) =>
                                DataRow(
                                    cells: [
                                      DataCell(Container(width:150,child: Text(e.name))),
                                      DataCell(Container(width:100,child: Text(e.phno))),
                                    ]
                                ),
                            ).toList()
                        ),
                      ),
                      Text(
                        "Staff Details:",
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
                              DataColumn(label: Text("Staff Name")),
                              DataColumn(label: Text("Phone Number")),

                            ],
                            rows: widget.hospitalvalues.staffslist.map((e) =>
                                DataRow(
                                    cells: [
                                      DataCell(Container(width:150,child: Text(e.name))),
                                      DataCell(Container(width:100,child: Text(e.phno))),
                                    ]
                                ),
                            ).toList()
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Accreditation: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   widget.hospitalvalues.accred,
                      //   style: TextStyle(
                      //     color: Colors.redAccent,
                      //     fontSize: 16.0,
                      //     fontFamily: 'Lato',
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      getaccred(widget.hospitalvalues.accred),
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

  // Future<Hospital> getHospitals() async {
  //   var db = await fb.reference().child("Hospitals");
  //   print(db);
  //   try {
  //     if (db != null) {
  //       db.once().then((DataSnapshot snapshot) {
  //         Map<dynamic, dynamic> values = snapshot.value;
  //         values.forEach((key, value) {
  //           var refreshToken = Hospital.fromJson(value);
  //           setState(() {
  //             if(widget.hospitalname==refreshToken.hospitalName) {
  //               hospitalvalues.add(refreshToken);
  //             }
  //           });
  //           print("Hops::::${hospitalvalues.toString()}");
  //           setState(() {
  //             isLoading=false;
  //           });
  //         });
  //       });
  //     } else {
  //       print('Something is Null');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Widget getfacility(List facility){
    List<Widget> list = new List<Widget>();
    for(var name in facility){
      list.add(new Text(
          name+" ",
        style: TextStyle(
          color: Colors.black,
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
          color: Colors.black,
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
              color: Colors.black,
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
    // for(int i=0;i<beds.length;i++){
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
            rows: widget.hospitalvalues.beds.map((e) =>
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
    // }
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
              color: Colors.black,
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
