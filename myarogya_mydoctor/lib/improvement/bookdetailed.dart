import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';

class Bookdetailed extends StatefulWidget {
  String hospitalname;

  Bookdetailed(this.hospitalname);
  @override
  _BookdetailedState createState() => _BookdetailedState();
}

class _BookdetailedState extends State<Bookdetailed> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHospitals();
  }

  bool _check = false;
  bool _check1 = false;
  FirebaseDatabase fb = FirebaseDatabase.instance;
  List<Hospital> hospitalvalues = [];
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Column(
              children: [
                Text("Choose room type"),
                Text(
                  widget.hospitalname,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: hospitalvalues == null
            ? Center(child: Text("Yet to be updated"))
            : isLoading
            ? LinearProgressIndicator(
          backgroundColor: Colors.redAccent,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
        )
            : Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 80 / 100,
              padding: EdgeInsets.all(5),
              child: ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Divider(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    height: 50,
                    child: ListTile(
                      title: Container(
                        width: 400,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "OPD Booking",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent),
                            ),
                            MaterialButton(
                              height: 30,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(25.0),
                                  side: BorderSide(
                                      color: Colors.redAccent)),
                              onPressed: () {},
                              color: Colors.redAccent,
                              child: Text(
                                "Book OPD",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // controlAffinity: ListTileControlAffinity.leading,
                      // tileColor: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 10,
                  ),
                  Text("Rooms",style: TextStyle(
                      fontSize: 22,
                      color: Colors.redAccent),),
                  Divider(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    height: 50,
                    child: CheckboxListTile(
                      title: Container(
                        width: 400,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 210,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    hospitalvalues[0].freebeds[0].roomType +
                                        " beds",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.redAccent),
                                  ),
                                  Text(
                                    hospitalvalues[0].freebeds[0].noOfBeds,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Rs. " +
                                  hospitalvalues[0]
                                      .freebeds[0]
                                      .charges,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                      // controlAffinity: ListTileControlAffinity.leading,
                      // tileColor: Colors.white,
                      value: _check,
                      onChanged: (v) {
                        setState(() {
                          _check = !_check;
                        });
                      },
                    ),
                  ),
                  Divider(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    height: 50,
                    child: CheckboxListTile(
                      title: Container(
                        width: 400,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 210,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    hospitalvalues[0].conbeds[0].roomType,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.redAccent),
                                  ),
                                  Text(
                                    hospitalvalues[0].conbeds[0].noOfBeds,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Rs. " +
                                  hospitalvalues[0]
                                      .conbeds[0]
                                      .charges,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                      // controlAffinity: ListTileControlAffinity.leading,
                      // tileColor: Colors.white,
                      value: _check1,
                      onChanged: (v) {
                        setState(() {
                          _check1 = !_check1;
                        });
                      },
                    ),
                  ),
                  Divider(
                    height: 10,
                  ),
                  new ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 1000),
                    child: new ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: hospitalvalues[0].beds.length,
                      itemBuilder: (context, i) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          height: 50,
                          child: CheckboxListTile(
                            title: Container(
                              width: 400,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:210,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          hospitalvalues[0]
                                              .beds[i]
                                              .roomType ,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.redAccent),
                                        ),
                                        Text(
                                          hospitalvalues[0]
                                              .beds[i]
                                              .noOfBeds,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.redAccent),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Rs. " +
                                        hospitalvalues[0]
                                            .beds[i]
                                            .charges,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                            // controlAffinity: ListTileControlAffinity.leading,
                            // tileColor: Colors.white,
                            value: check[i],
                            onChanged: (bool v) {
                              setState(() {
                                Itemchange(v, i);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    height: 10,
                  ),
                  Text("Pathology",style: TextStyle(
                      fontSize: 22,
                      color: Colors.redAccent),),
                  Divider(
                    height: 10,
                  ),
                  new ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 1000),
                    child: new ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: hospitalvalues[0].diagnosis.length,
                      itemBuilder: (context, i) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          height: 50,
                          child: CheckboxListTile(
                            title: Container(
                              width: 400,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    hospitalvalues[0]
                                        .diagnosis[i]
                                        .test +
                                        "                          ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.redAccent),
                                  ),
                                  Text(
                                    "Rs. " +
                                        hospitalvalues[0]
                                            .diagnosis[i]
                                            .charge,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                            // controlAffinity: ListTileControlAffinity.leading,
                            // tileColor: Colors.white,
                            value: check1[i],
                            onChanged: (bool v) {
                              setState(() {
                                Itemchange1(v, i);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(
                    height: 10,
                  ),
                  Text("Health Package",style: TextStyle(
                      fontSize: 22,
                      color: Colors.redAccent),),
                  Divider(
                    height: 10,
                  ),
                  new ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 1000),
                    child: new ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: hospitalvalues[0].diagnosis.length,
                      itemBuilder: (context, i) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          height: 50,
                          child: CheckboxListTile(
                            title: Container(
                              width: 400,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    hospitalvalues[0]
                                        .health[i]
                                        .packagename +
                                        "                          ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.redAccent),
                                  ),
                                  Text(
                                    "Rs. " +
                                        hospitalvalues[0]
                                            .health[i]
                                            .amount,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                            // controlAffinity: ListTileControlAffinity.leading,
                            // tileColor: Colors.white,
                            value: check2[i],
                            onChanged: (bool v) {
                              setState(() {
                                Itemchange2(v, i);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  // Container(
                  //   padding: EdgeInsets.all(15),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //       borderRadius: BorderRadius.circular(15),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey,
                  //         blurRadius: 5.0,
                  //       ),
                  //     ]
                  //   ),
                  //   // height: 450,
                  //   width: 450,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Container(
                  //                 child: Text(
                  //                     hospitalvalues[0].freebeds[0].roomType+" beds",
                  //                   style: TextStyle(
                  //                     fontSize: 25,
                  //                     color: Colors.redAccent
                  //                   ),
                  //                 ),
                  //               ),
                  //               // SizedBox(
                  //               //                           //   height: 10,
                  //               //                           // ),
                  //               //                           // Card(
                  //               //                           //   color: Colors.redAccent,
                  //               //                           //   child: Row(
                  //               //                           //     children: [
                  //               //                           //       Icon(Icons.done,color: Colors.white,),
                  //               //                           //       SizedBox(width: 5,),
                  //               //                           //       Text("Free Cancelation  ",style: TextStyle(
                  //               //                           //           color: Colors.white
                  //               //                           //       ),),
                  //               //                           //     ],
                  //               //                           //   ),
                  //               //                           // )
                  //             ],
                  //           ),
                  //           // Container(
                  //           //   child: Image(
                  //           //     image: AssetImage("assets/images/logo.png"),
                  //           //     height: 100,
                  //           //     width: 100,
                  //           //   ),
                  //           // )
                  //         ],
                  //       ),
                  //       Container(
                  //         //height: 50,
                  //         child: Text("Total count: "+hospitalvalues[0].freebeds[0].noOfBeds,style: TextStyle(
                  //             fontSize: 14,
                  //             color: Colors.redAccent
                  //         ),),
                  //       ),
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.supervisor_account_sharp,color: Colors.redAccent,size: 20,
                  //           ),
                  //           SizedBox(width: 5,),
                  //           Container(
                  //             // height: 50,
                  //             child: Text("2 Single beds",style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: Colors.redAccent
                  //             ),),
                  //           ),
                  //         ],
                  //       ),
                  //      Row(
                  //         children: [
                  //           Icon(
                  //             Icons.king_bed,color: Colors.redAccent,size: 20,
                  //           ),
                  //           SizedBox(width: 5,),
                  //           Container(
                  //             // height: 50,
                  //             child: Text("2 adults",style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: Colors.redAccent
                  //             ),),
                  //           ),
                  //         ],
                  //       ),
                  //      Row(
                  //         children: [
                  //           Icon(
                  //             Icons.sync_alt_rounded,color: Colors.redAccent,size: 20,
                  //           ),
                  //           SizedBox(width: 5,),
                  //           Container(
                  //             // height: 50,
                  //             child: Text("Room size: 17sqfeet",style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: Colors.redAccent
                  //             ),),
                  //           ),
                  //         ],
                  //       ),
                  //       //getspeciality(hospitalvalues[0].facilities),
                  //       Row(
                  //         children: [
                  //           Container(
                  //             // height: 50,
                  //             child: Text("Price Range Rs. "+hospitalvalues[0].freebeds[0].charges,style: TextStyle(
                  //                 fontSize: 17,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.redAccent
                  //             ),),
                  //           ),
                  //           Icon(
                  //             Icons.info_outline_rounded,color: Colors.redAccent,size: 20,
                  //           ),
                  //         ],
                  //       ),
                  //       Container(
                  //         // height: 50,
                  //         child: Text("Additional charges may apply",style: TextStyle(
                  //             fontSize: 14,
                  //             color: Colors.redAccent
                  //         ),),
                  //       ),
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.cloud_done_sharp,color: Colors.redAccent,size: 20,
                  //           ),
                  //           SizedBox(width: 5,),
                  //           Container(
                  //             // height: 50,
                  //             child: Text("10% base rate discount",style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: Colors.redAccent
                  //             ),),
                  //           ),
                  //         ],
                  //       ),
                  //       MaterialButton(
                  //         color: Colors.redAccent,
                  //         minWidth: 400,
                  //         height: 40,
                  //         onPressed: (){
                  //             //todo:free beds booking
                  //         },
                  //         child: Text("Book",style: TextStyle(
                  //           fontSize: 20,),),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Divider(height: 10,),
                  // Container(
                  //   padding: EdgeInsets.all(15),
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(15),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey,
                  //           blurRadius: 5.0,
                  //         ),
                  //       ]
                  //   ),
                  //   //height: 330,
                  //   width: 450,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Container(
                  //                 child: Text(
                  //                   hospitalvalues[0].conbeds[0].roomType,
                  //                   style: TextStyle(
                  //                       fontSize: 25,
                  //                       color: Colors.redAccent
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Card(
                  //                 color: Colors.redAccent,
                  //                 child: Row(
                  //                   children: [
                  //                     Icon(Icons.done,color: Colors.white,),
                  //                     SizedBox(width: 5,),
                  //                     Text("Free Cancelation  ",style: TextStyle(
                  //                         color: Colors.white
                  //                     ),),
                  //                   ],
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //           Container(
                  //             child: Image(
                  //               image: AssetImage("assets/images/logo.png"),
                  //               height: 100,
                  //               width: 100,
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //       Container(
                  //         //height: 50,
                  //         child: Text("Total count: "+hospitalvalues[0].conbeds[0].noOfBeds,style: TextStyle(
                  //             fontSize: 14,
                  //             color: Colors.redAccent
                  //         ),),
                  //       ),
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.supervisor_account_sharp,color: Colors.redAccent,size: 20,
                  //           ),
                  //           SizedBox(width: 5,),
                  //           Container(
                  //             // height: 50,
                  //             child: Text("2 Single beds",style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: Colors.redAccent
                  //             ),),
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.king_bed,color: Colors.redAccent,size: 20,
                  //           ),
                  //           SizedBox(width: 5,),
                  //           Container(
                  //             // height: 50,
                  //             child: Text("price for 2 adults",style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: Colors.redAccent
                  //             ),),
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.sync_alt_rounded,color: Colors.redAccent,size: 20,
                  //           ),
                  //           SizedBox(width: 5,),
                  //           Container(
                  //             // height: 50,
                  //             child: Text("Room size: 17sqfeet",style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: Colors.redAccent
                  //             ),),
                  //           ),
                  //         ],
                  //       ),
                  //       getspeciality(hospitalvalues[0].facilities),
                  //       Row(
                  //         children: [
                  //           Container(
                  //             // height: 50,
                  //             child: Text("Price Range Rs. "+hospitalvalues[0].conbeds[0].charges,style: TextStyle(
                  //                 fontSize: 17,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.redAccent
                  //             ),),
                  //           ),
                  //           Icon(
                  //             Icons.info_outline_rounded,color: Colors.redAccent,size: 20,
                  //           ),
                  //         ],
                  //       ),
                  //       Container(
                  //         // height: 50,
                  //         child: Text("Additional charges may apply",style: TextStyle(
                  //             fontSize: 14,
                  //             color: Colors.redAccent
                  //         ),),
                  //       ),
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.cloud_done_sharp,color: Colors.redAccent,size: 20,
                  //           ),
                  //           SizedBox(width: 5,),
                  //           Container(
                  //             // height: 50,
                  //             child: Text("10% base rate discount",style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: Colors.redAccent
                  //             ),),
                  //           ),
                  //         ],
                  //       ),
                  //       MaterialButton(
                  //         color: Colors.redAccent,
                  //         minWidth: 400,
                  //         height: 40,
                  //         onPressed: (){
                  //           //todo:free beds booking
                  //         },
                  //         child: Text("Book",style: TextStyle(
                  //           fontSize: 20,),),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Divider(height: 5,),
                  // Text("  Other Beds",style: TextStyle(
                  //   fontSize: 20,color: Colors.redAccent),),
                  // Divider(height: 5,),
                  // new ConstrainedBox(
                  //   constraints: BoxConstraints(maxHeight: 1000),
                  //   child: new ListView.builder(
                  //     physics: ScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemCount: hospitalvalues[0].beds.length,
                  //     itemBuilder: (context, i) {
                  //       return Container(
                  //         padding: EdgeInsets.all(15),
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(15),
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey,
                  //                 blurRadius: 5.0,
                  //               ),
                  //             ]),
                  //         //height: 330,
                  //         width: 450,
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Container(
                  //                       child: Text(
                  //                         hospitalvalues[0]
                  //                                 .beds[i]
                  //                                 .roomType +
                  //                             " Beds",
                  //                         style: TextStyle(
                  //                             fontSize: 25,
                  //                             color: Colors.redAccent),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: 10,
                  //                     ),
                  //                     Card(
                  //                       color: Colors.redAccent,
                  //                       child: Row(
                  //                         children: [
                  //                           Icon(
                  //                             Icons.done,
                  //                             color: Colors.white,
                  //                           ),
                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),
                  //                           Text(
                  //                             "Free Cancelation  ",
                  //                             style: TextStyle(
                  //                                 color: Colors.white),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 Container(
                  //                   child: Image(
                  //                     image: AssetImage(
                  //                         "assets/images/logo.png"),
                  //                     height: 100,
                  //                     width: 100,
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //             Container(
                  //               //height: 50,
                  //               child: Text(
                  //                 "Total count: " +
                  //                     hospitalvalues[0].beds[i].noOfBeds,
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     color: Colors.redAccent),
                  //               ),
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Icon(
                  //                   Icons.supervisor_account_sharp,
                  //                   color: Colors.redAccent,
                  //                   size: 20,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Container(
                  //                   // height: 50,
                  //                   child: Text(
                  //                     "2 Single beds",
                  //                     style: TextStyle(
                  //                         fontSize: 14,
                  //                         color: Colors.redAccent),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Icon(
                  //                   Icons.king_bed,
                  //                   color: Colors.redAccent,
                  //                   size: 20,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Container(
                  //                   // height: 50,
                  //                   child: Text(
                  //                     "price for 2 adults",
                  //                     style: TextStyle(
                  //                         fontSize: 14,
                  //                         color: Colors.redAccent),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Icon(
                  //                   Icons.sync_alt_rounded,
                  //                   color: Colors.redAccent,
                  //                   size: 20,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Container(
                  //                   // height: 50,
                  //                   child: Text(
                  //                     "Room size: 17sqfeet",
                  //                     style: TextStyle(
                  //                         fontSize: 14,
                  //                         color: Colors.redAccent),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             getspeciality(hospitalvalues[0].facilities),
                  //             Row(
                  //               children: [
                  //                 Container(
                  //                   // height: 50,
                  //                   child: Text(
                  //                     "Price Range Rs. " +
                  //                         hospitalvalues[0]
                  //                             .beds[i]
                  //                             .charges,
                  //                     style: TextStyle(
                  //                         fontSize: 17,
                  //                         fontWeight: FontWeight.bold,
                  //                         color: Colors.redAccent),
                  //                   ),
                  //                 ),
                  //                 Icon(
                  //                   Icons.info_outline_rounded,
                  //                   color: Colors.redAccent,
                  //                   size: 20,
                  //                 ),
                  //               ],
                  //             ),
                  //             Container(
                  //               // height: 50,
                  //               child: Text(
                  //                 "Additional charges may apply",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     color: Colors.redAccent),
                  //               ),
                  //             ),
                  //             Row(
                  //               children: [
                  //                 Icon(
                  //                   Icons.cloud_done_sharp,
                  //                   color: Colors.redAccent,
                  //                   size: 20,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Container(
                  //                   // height: 50,
                  //                   child: Text(
                  //                     "10% base rate discount",
                  //                     style: TextStyle(
                  //                         fontSize: 14,
                  //                         color: Colors.redAccent),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             MaterialButton(
                  //               color: Colors.redAccent,
                  //               minWidth: 400,
                  //               height: 40,
                  //               onPressed: () {
                  //                 //todo:free beds booking
                  //               },
                  //               child: Text(
                  //                 "Book",
                  //                 style: TextStyle(
                  //                   fontSize: 20,
                  //                 ),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
            Divider(
              height: 5,
            ),
            MaterialButton(
              height: 45,
              minWidth: 380,
              color: Colors.redAccent,
              child: Text(
                'Book',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {},
            )
          ],
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
              if (widget.hospitalname == refreshToken.hospitalName) {
                hospitalvalues.add(refreshToken);
              }
            });
            print("Hops::::${hospitalvalues.toString()}");
            setState(() {
              isLoading = false;
              for (int i = 0; i < hospitalvalues[0].beds.length; i++) {
                check.add(false);
                print("for" + check[i].toString());
              }
              for (int i = 0; i < hospitalvalues[0].diagnosis.length; i++) {
                check1.add(false);
                print("for" + check1[i].toString());
              }
              for (int i = 0; i < hospitalvalues[0].health.length; i++) {
                check2.add(false);
                print("for" + check2[i].toString());
              }
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

  Widget getspeciality(List speciality) {
    List<Widget> list = new List<Widget>();
    for (var name in speciality) {
      list.add(new Text(
        name + " ",
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 14.0,
          fontFamily: 'Lato',
          //fontWeight: FontWeight.bold,
        ),
      ));
    }
    return new Wrap(spacing: 5.0, runSpacing: 3.0, children: list);
  }

  List<bool> check = new List<bool>();
  List<bool> check1 = new List<bool>();
  List<bool> check2 = new List<bool>();

  Itemchange(bool val, int index) {
    setState(() {
      check[index] = val;
    });
  }

  Itemchange1(bool val, int index) {
    setState(() {
      check1[index] = val;
    });
  }

  Itemchange2(bool val, int index) {
    setState(() {
      check2[index] = val;
    });
  }
}
