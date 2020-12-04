import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Bookdetailed extends StatefulWidget {
  Hospital hospitalvalues;
  String key1;
  String mobile;

  Bookdetailed(this.hospitalvalues,this.key1,this.mobile);
  @override
  _BookdetailedState createState() => _BookdetailedState();
}

class _BookdetailedState extends State<Bookdetailed> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getroomtype();
    getpathologytype();
    gethealthtype();
    getsurgerytype();
  }
  List<String> roomnames = [];
  List<String> roomnames1 = [];
  List<String> pathology = [];
  List<String> health = [];
  List<String> surgery = [];
  int bal;
  String values;
  String valuesP;
  String valuesH;
  String valuesS;
  String topic;
  List list3 = [];
  List list4 = [];
  String bookingcount;
  int key2;
  String selectedR;
  Radio rb1;
  String _chosenValue2;
  TextEditingController _nameController;
  getroomtype(){
      roomnames.add("100% free");
      roomnames.add("Concessional Beds");
      roomnames.add("Covid Beds");
    for(var name in widget.hospitalvalues.beds){
      roomnames1.add(name.roomType);
    }
    print("1");
  }
  getpathologytype(){
    for(var name in widget.hospitalvalues.diagnosis){
      pathology.add(name.test);
    }
    print("2");
  }
  gethealthtype(){
    for(var name in widget.hospitalvalues.health){
      health.add(name.packagename);
    }
    print("3");
  }
  getsurgerytype(){
    for(var name in widget.hospitalvalues.surgery){
      surgery.add(name.surgeryname);
    }
    print("4");
    setState(() {
      isLoading = false;
    });
  }
  // bool _check = false;
  // bool _check1 = false;
  // bool _check2 = false;
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
                  widget.hospitalvalues.hospitalName,
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
                : Padding(
          padding: EdgeInsets.fromLTRB(5,0,5,0),
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
                          border: Border.all(color: Colors.redAccent, style: BorderStyle.solid),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        height: 50,
                        child: ListTile(
                          title: Container(
                            //width: 400,
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
                          //tileColor: Colors.white,
                        ),
                      ),
                      Divider(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.redAccent, style: BorderStyle.solid),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Text("Rooms",style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.redAccent),),
                                  MaterialButton(
                                    height: 30,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(25.0),
                                        side: BorderSide(
                                            color: Colors.redAccent)),
                                    onPressed: () {
                                      _openPopup(context,"Rooms",values);
                                    },
                                    color: Colors.redAccent,
                                    child: Text(
                                      "Book Rooms",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                  ),
                              ],
                            ),
                            RadioButtonGroup(
                              orientation: GroupedButtonsOrientation.VERTICAL,
                              onChange: (String label, int index) => print("label: $label index: $index"),
                              margin: const EdgeInsets.only(left: 12.0),
                              onSelected: (selectedR) => setState((){
                                values = selectedR;
                              }),
                              labels: roomnames,
                              itemBuilder: (rb1, Text txt, int i){
                                print(i);
                                return Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    rb1,
                                    txt,
                                    (i==0)?Text(" Rs. "):Container(),
                                    (i==0)?Text(widget.hospitalvalues.freebeds[0].charges):Container(),
                                    (i==0)?Text("/Day Charges: "):Container(),
                                    (i==0)?Text(widget.hospitalvalues.freebeds[0].noOfBeds):Container(),
                                    (i==1)?Text(" Rs. "):Container(),
                                    (i==1)?Text(widget.hospitalvalues.conbeds[0].charges):Container(),
                                    (i==1)?Text("/Day Charges: "):Container(),
                                    (i==1)?Text(widget.hospitalvalues.conbeds[0].noOfBeds):Container(),
                                    (i==2)?Text(" Rs. "):Container(),
                                    (i==2)?Text(widget.hospitalvalues.covidbeds[0].noOfBeds):Container(),
                                    (i==2)?Text("/Day Charges: "):Container(),
                                    (i==2)?Text(widget.hospitalvalues.covidbeds[0].charges):Container(),
                                  ],
                                );
                              },
                            ),
                            RadioButtonGroup(
                          orientation: GroupedButtonsOrientation.VERTICAL,
                          onChange: (String label, int index) => print("label: $label index: $index"),
                          margin: const EdgeInsets.only(left: 12.0),
                          onSelected: (selectedR) => setState((){
                            values = selectedR;
                          }),
                          labels: roomnames1,
                          itemBuilder: (rb1, Text txt, int i){
                            return Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                rb1,
                                txt,
                                Text("Rs."),
                                Text(widget.hospitalvalues.beds[i].noOfBeds),
                                Text("/Day Charges:"),
                                Text(widget.hospitalvalues.beds[i].charges),
                              ],
                            );
                          },
                        ),
                        //     RadioButtonGroup(
                        //   orientation: GroupedButtonsOrientation.VERTICAL,
                        //    onChange: (String label, int index) => print("label: $label index: $index"),
                        //   margin: const EdgeInsets.only(left: 12.0),
                        //   onSelected: (String selected) => setState((){
                        //     values = selected;
                        //   }),
                        //   labels: roomnames,
                        //   itemBuilder: (Radio rb, Text txt, int i){
                        //     print(i);
                        //     return Row(
                        //       children: <Widget>[
                        //         rb,
                        //         txt,
                        //         (i==0)?Text(widget.hospitalvalues.freebeds[0].noOfBeds):Container(),
                        //         (i==0)?Text(widget.hospitalvalues.freebeds[0].charges):Container(),
                        //         (i==1)?Text(widget.hospitalvalues.conbeds[0].noOfBeds):Container(),
                        //         (i==1)?Text(widget.hospitalvalues.conbeds[0].charges):Container(),
                        //         (i==2)?Text(widget.hospitalvalues.covidbeds[0].noOfBeds):Container(),
                        //         (i==2)?Text(widget.hospitalvalues.covidbeds[0].charges):Container(),
                        //       ],
                        //     );
                        //   },
                        // ),
                        //     RadioButtonGroup(
                        //       labels: roomnames,
                        //       onChange: (String label, int index) => print("label: $label index: $index"),
                        //       onSelected: (String label) {
                        //         setState(() {
                        //           values = label;
                        //         });
                        //     },
                        //     ),
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("Rooms",style: TextStyle(
                        //             fontSize: 22,
                        //             color: Colors.redAccent),),
                        //         MaterialButton(
                        //           height: 30,
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius:
                        //               BorderRadius.circular(25.0),
                        //               side: BorderSide(
                        //                   color: Colors.redAccent)),
                        //           onPressed: () {},
                        //           color: Colors.redAccent,
                        //           child: Text(
                        //             "Book Rooms",
                        //             style: TextStyle(
                        //                 fontSize: 14,
                        //                 color: Colors.white),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     Divider(
                        //       height: 10,
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.freebeds[0].roomType +
                        //                           " beds",
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.freebeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .freebeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check,
                        //         onChanged: (v) {
                        //           setState(() {
                        //             _check = !_check;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     // Divider(
                        //     //   height: 10,
                        //     // ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.conbeds[0].roomType,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.conbeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .conbeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check1,
                        //         onChanged: (v) {
                        //           if (v) {
                        //             selectedContacts.contains({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             })
                        //                 ? selectedContacts.remove({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             })
                        //                 : selectedContacts.add({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             });
                        //             // addlist(widget.hospitalvalues
                        //             //     .conbeds[0]);
                        //             print(selectedContacts.toString());
                        //           } else {
                        //             // removelist();
                        //             print(selectedContacts.toString());
                        //             // selectedContacts.clear();
                        //           }
                        //           print("Vaues::"+v.toString());
                        //           setState(() {
                        //             _check1 = !_check1;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.covidbeds[0].roomType,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.covidbeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .covidbeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check2,
                        //         onChanged: (v) {
                        //           if (v) {
                        //             addlist(widget.hospitalvalues
                        //                 .covidbeds[0]);
                        //             print(selectedContacts.toString());
                        //           } else {
                        //             // removelist();
                        //             print(selectedContacts.toString());
                        //           }
                        //           print("Vaues::"+v.toString());
                        //           setState(() {
                        //             _check2 = !_check2;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     // Divider(
                        //     //   height: 10,
                        //     // ),
                        //     new ConstrainedBox(
                        //       constraints: BoxConstraints(maxHeight: 1000),
                        //       child: new ListView.builder(
                        //         physics: ScrollPhysics(),
                        //         shrinkWrap: true,
                        //         itemCount: widget.hospitalvalues.beds.length,
                        //         itemBuilder: (context, i) {
                        //           return Container(
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(15),
                        //               color: Colors.white,
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: Colors.grey,
                        //                   blurRadius: 5.0,
                        //                 ),
                        //               ],
                        //             ),
                        //             height: 50,
                        //             child: CheckboxListTile(
                        //               title: Container(
                        //                 width: 400,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Container(
                        //                       width:210,
                        //                       child: Row(
                        //                         mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                         children: [
                        //                           Text(
                        //                             widget.hospitalvalues
                        //                                 .beds[i]
                        //                                 .roomType ,
                        //                             style: TextStyle(
                        //                                 fontSize: 16,
                        //                                 color: Colors.redAccent),
                        //                           ),
                        //                           Text(
                        //                             widget.hospitalvalues
                        //                                 .beds[i]
                        //                                 .noOfBeds,
                        //                             style: TextStyle(
                        //                                 fontSize: 16,
                        //                                 color: Colors.redAccent),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     Text(
                        //                       "Rs. " +
                        //                           widget.hospitalvalues
                        //                               .beds[i]
                        //                               .charges,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               // controlAffinity: ListTileControlAffinity.leading,
                        //               //tileColor: Colors.white,
                        //               value: check[i],
                        //               onChanged: (bool v) {
                        //                 setState(() {
                        //                   Itemchange(v, i);
                        //                 });
                        //               },
                        //             ),
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                      Divider(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.redAccent, style: BorderStyle.solid),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Pathology",style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.redAccent),),
                                MaterialButton(
                                  height: 30,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                      side: BorderSide(
                                          color: Colors.redAccent)),
                                  onPressed: () {
                                    _openPopup(context,"Pathology",valuesP);
                                  },
                                  color: Colors.redAccent,
                                  child: Text(
                                    "Book Pathology",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            RadioButtonGroup(
                              orientation: GroupedButtonsOrientation.VERTICAL,
                              onChange: (String label, int index) => print("label: $label index: $index"),
                              margin: const EdgeInsets.only(left: 12.0),
                              onSelected: (String selected) => setState((){
                                valuesP = selected;
                              }),
                              labels: pathology,
                              itemBuilder: (Radio rb, Text txt, int i){
                                return Row(
                                  children: <Widget>[
                                    rb,
                                    txt,
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Charges: "),
                                    Text(widget.hospitalvalues.diagnosis[i].charge),
                                  ],
                                );
                              },
                            ),
                            // RadioButtonGroup(
                            //   labels: pathology,
                            //   onChange: (String label, int index) => print("label: $label index: $index"),
                            //   onSelected: (String label) {
                            //     setState(() {
                            //       valuesP = label;
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("Rooms",style: TextStyle(
                        //             fontSize: 22,
                        //             color: Colors.redAccent),),
                        //         MaterialButton(
                        //           height: 30,
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius:
                        //               BorderRadius.circular(25.0),
                        //               side: BorderSide(
                        //                   color: Colors.redAccent)),
                        //           onPressed: () {},
                        //           color: Colors.redAccent,
                        //           child: Text(
                        //             "Book Rooms",
                        //             style: TextStyle(
                        //                 fontSize: 14,
                        //                 color: Colors.white),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     Divider(
                        //       height: 10,
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.freebeds[0].roomType +
                        //                           " beds",
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.freebeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .freebeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check,
                        //         onChanged: (v) {
                        //           setState(() {
                        //             _check = !_check;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     // Divider(
                        //     //   height: 10,
                        //     // ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.conbeds[0].roomType,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.conbeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .conbeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check1,
                        //         onChanged: (v) {
                        //           if (v) {
                        //             selectedContacts.contains({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             })
                        //                 ? selectedContacts.remove({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             })
                        //                 : selectedContacts.add({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             });
                        //             // addlist(widget.hospitalvalues
                        //             //     .conbeds[0]);
                        //             print(selectedContacts.toString());
                        //           } else {
                        //             // removelist();
                        //             print(selectedContacts.toString());
                        //             // selectedContacts.clear();
                        //           }
                        //           print("Vaues::"+v.toString());
                        //           setState(() {
                        //             _check1 = !_check1;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.covidbeds[0].roomType,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.covidbeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .covidbeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check2,
                        //         onChanged: (v) {
                        //           if (v) {
                        //             addlist(widget.hospitalvalues
                        //                 .covidbeds[0]);
                        //             print(selectedContacts.toString());
                        //           } else {
                        //             // removelist();
                        //             print(selectedContacts.toString());
                        //           }
                        //           print("Vaues::"+v.toString());
                        //           setState(() {
                        //             _check2 = !_check2;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     // Divider(
                        //     //   height: 10,
                        //     // ),
                        //     new ConstrainedBox(
                        //       constraints: BoxConstraints(maxHeight: 1000),
                        //       child: new ListView.builder(
                        //         physics: ScrollPhysics(),
                        //         shrinkWrap: true,
                        //         itemCount: widget.hospitalvalues.beds.length,
                        //         itemBuilder: (context, i) {
                        //           return Container(
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(15),
                        //               color: Colors.white,
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: Colors.grey,
                        //                   blurRadius: 5.0,
                        //                 ),
                        //               ],
                        //             ),
                        //             height: 50,
                        //             child: CheckboxListTile(
                        //               title: Container(
                        //                 width: 400,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Container(
                        //                       width:210,
                        //                       child: Row(
                        //                         mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                         children: [
                        //                           Text(
                        //                             widget.hospitalvalues
                        //                                 .beds[i]
                        //                                 .roomType ,
                        //                             style: TextStyle(
                        //                                 fontSize: 16,
                        //                                 color: Colors.redAccent),
                        //                           ),
                        //                           Text(
                        //                             widget.hospitalvalues
                        //                                 .beds[i]
                        //                                 .noOfBeds,
                        //                             style: TextStyle(
                        //                                 fontSize: 16,
                        //                                 color: Colors.redAccent),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     Text(
                        //                       "Rs. " +
                        //                           widget.hospitalvalues
                        //                               .beds[i]
                        //                               .charges,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               // controlAffinity: ListTileControlAffinity.leading,
                        //               //tileColor: Colors.white,
                        //               value: check[i],
                        //               onChanged: (bool v) {
                        //                 setState(() {
                        //                   Itemchange(v, i);
                        //                 });
                        //               },
                        //             ),
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                      Divider(
                        height: 10,
                      ),
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15),
                      //     border: Border.all(color: Colors.redAccent, style: BorderStyle.solid),
                      //     color: Colors.white,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.redAccent,
                      //         blurRadius: 5.0,
                      //       ),
                      //     ],
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("Health Package",style: TextStyle(
                      //               fontSize: 22,
                      //               color: Colors.redAccent),),
                      //           MaterialButton(
                      //             height: 30,
                      //             shape: RoundedRectangleBorder(
                      //                 borderRadius:
                      //                 BorderRadius.circular(25.0),
                      //                 side: BorderSide(
                      //                     color: Colors.redAccent)),
                      //             onPressed: () {},
                      //             color: Colors.redAccent,
                      //             child: Text(
                      //               "Book Packages",
                      //               style: TextStyle(
                      //                   fontSize: 14,
                      //                   color: Colors.white),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       Divider(
                      //         height: 10,
                      //       ),
                      //       new ConstrainedBox(
                      //         constraints: BoxConstraints(maxHeight: 1000),
                      //         child: new ListView.builder(
                      //           physics: ScrollPhysics(),
                      //           shrinkWrap: true,
                      //           itemCount: widget.hospitalvalues.health.length,
                      //           itemBuilder: (context, i) {
                      //             return Container(
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(15),
                      //                 color: Colors.white,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey,
                      //                     blurRadius: 5.0,
                      //                   ),
                      //                 ],
                      //               ),
                      //               height: 50,
                      //               child: CheckboxListTile(
                      //                 title: Container(
                      //                   width: 400,
                      //                   child: Row(
                      //                     mainAxisAlignment:
                      //                     MainAxisAlignment.spaceBetween,
                      //                     children: [
                      //                       Text(
                      //                         widget.hospitalvalues
                      //                             .health[i]
                      //                             .packagename +
                      //                             "                          ",
                      //                         style: TextStyle(
                      //                             fontSize: 16,
                      //                             color: Colors.redAccent),
                      //                       ),
                      //                       Text(
                      //                         "Rs. " +
                      //                             widget.hospitalvalues
                      //                                 .health[i]
                      //                                 .amount,
                      //                         style: TextStyle(
                      //                             fontSize: 16,
                      //                             color: Colors.redAccent),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 // controlAffinity: ListTileControlAffinity.leading,
                      //                 //tileColor: Colors.white,
                      //                 value: check2[i],
                      //                 onChanged: (bool v) {
                      //                   setState(() {
                      //                     Itemchange2(v, i);
                      //                   });
                      //                 },
                      //               ),
                      //             );
                      //           },
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.redAccent, style: BorderStyle.solid),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Health Packages",style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.redAccent),),
                                MaterialButton(
                                  height: 30,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                      side: BorderSide(
                                          color: Colors.redAccent)),
                                  onPressed: () {
                                    _openPopup(context,"Health",valuesH);
                                  },
                                  color: Colors.redAccent,
                                  child: Text(
                                    "Book Health Packages",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            RadioButtonGroup(
                              orientation: GroupedButtonsOrientation.VERTICAL,
                              onChange: (String label, int index) => print("label: $label index: $index"),
                              margin: const EdgeInsets.only(left: 12.0),
                              onSelected: (String selected) => setState((){
                                valuesH = selected;
                              }),
                              labels: health,
                              itemBuilder: (Radio rb, Text txt, int i){
                                return Row(
                                  children: <Widget>[
                                    rb,
                                    txt,
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Charges: "),
                                    Text(widget.hospitalvalues.health[i].amount),
                                  ],
                                );
                              },
                            ),
                            // RadioButtonGroup(
                            //   labels: health,
                            //   onChange: (String label, int index) => print("label: $label index: $index"),
                            //   onSelected: (String label) {
                            //     setState(() {
                            //       valuesH = label;
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("Rooms",style: TextStyle(
                        //             fontSize: 22,
                        //             color: Colors.redAccent),),
                        //         MaterialButton(
                        //           height: 30,
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius:
                        //               BorderRadius.circular(25.0),
                        //               side: BorderSide(
                        //                   color: Colors.redAccent)),
                        //           onPressed: () {},
                        //           color: Colors.redAccent,
                        //           child: Text(
                        //             "Book Rooms",
                        //             style: TextStyle(
                        //                 fontSize: 14,
                        //                 color: Colors.white),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     Divider(
                        //       height: 10,
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.freebeds[0].roomType +
                        //                           " beds",
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.freebeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .freebeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check,
                        //         onChanged: (v) {
                        //           setState(() {
                        //             _check = !_check;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     // Divider(
                        //     //   height: 10,
                        //     // ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.conbeds[0].roomType,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.conbeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .conbeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check1,
                        //         onChanged: (v) {
                        //           if (v) {
                        //             selectedContacts.contains({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             })
                        //                 ? selectedContacts.remove({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             })
                        //                 : selectedContacts.add({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             });
                        //             // addlist(widget.hospitalvalues
                        //             //     .conbeds[0]);
                        //             print(selectedContacts.toString());
                        //           } else {
                        //             // removelist();
                        //             print(selectedContacts.toString());
                        //             // selectedContacts.clear();
                        //           }
                        //           print("Vaues::"+v.toString());
                        //           setState(() {
                        //             _check1 = !_check1;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.covidbeds[0].roomType,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.covidbeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .covidbeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check2,
                        //         onChanged: (v) {
                        //           if (v) {
                        //             addlist(widget.hospitalvalues
                        //                 .covidbeds[0]);
                        //             print(selectedContacts.toString());
                        //           } else {
                        //             // removelist();
                        //             print(selectedContacts.toString());
                        //           }
                        //           print("Vaues::"+v.toString());
                        //           setState(() {
                        //             _check2 = !_check2;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     // Divider(
                        //     //   height: 10,
                        //     // ),
                        //     new ConstrainedBox(
                        //       constraints: BoxConstraints(maxHeight: 1000),
                        //       child: new ListView.builder(
                        //         physics: ScrollPhysics(),
                        //         shrinkWrap: true,
                        //         itemCount: widget.hospitalvalues.beds.length,
                        //         itemBuilder: (context, i) {
                        //           return Container(
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(15),
                        //               color: Colors.white,
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: Colors.grey,
                        //                   blurRadius: 5.0,
                        //                 ),
                        //               ],
                        //             ),
                        //             height: 50,
                        //             child: CheckboxListTile(
                        //               title: Container(
                        //                 width: 400,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Container(
                        //                       width:210,
                        //                       child: Row(
                        //                         mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                         children: [
                        //                           Text(
                        //                             widget.hospitalvalues
                        //                                 .beds[i]
                        //                                 .roomType ,
                        //                             style: TextStyle(
                        //                                 fontSize: 16,
                        //                                 color: Colors.redAccent),
                        //                           ),
                        //                           Text(
                        //                             widget.hospitalvalues
                        //                                 .beds[i]
                        //                                 .noOfBeds,
                        //                             style: TextStyle(
                        //                                 fontSize: 16,
                        //                                 color: Colors.redAccent),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     Text(
                        //                       "Rs. " +
                        //                           widget.hospitalvalues
                        //                               .beds[i]
                        //                               .charges,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               // controlAffinity: ListTileControlAffinity.leading,
                        //               //tileColor: Colors.white,
                        //               value: check[i],
                        //               onChanged: (bool v) {
                        //                 setState(() {
                        //                   Itemchange(v, i);
                        //                 });
                        //               },
                        //             ),
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                      Divider(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.redAccent, style: BorderStyle.solid),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Surgery Packages",style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.redAccent),),
                                MaterialButton(
                                  height: 30,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(25.0),
                                      side: BorderSide(
                                          color: Colors.redAccent)),
                                  onPressed: () {
                                    _openPopup(context,"Surgery",valuesS);
                                  },
                                  color: Colors.redAccent,
                                  child: Text(
                                    "Book Surgery",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            RadioButtonGroup(
                              orientation: GroupedButtonsOrientation.VERTICAL,
                              onChange: (String label, int index) => print("label: $label index: $index"),
                              margin: const EdgeInsets.only(left: 12.0),
                              onSelected: (String selected) => setState((){
                                valuesS = selected;
                              }),
                              labels: surgery,
                              itemBuilder: (Radio rb, Text txt, int i){
                                return Row(
                                  children: <Widget>[
                                    rb,
                                    txt,
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Charges: "),
                                    Text(widget.hospitalvalues.surgery[i].suramount),
                                  ],
                                );
                              },
                            ),
                            // RadioButtonGroup(
                            //   labels: surgery,
                            //   onChange: (String label, int index) => print("label: $label index: $index"),
                            //   onSelected: (String label){
                            //     setState(() {
                            //       valuesS = label;
                            //     });
                            //   },
                            // ),
                          ],
                        ),

                        // Column(
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text("Rooms",style: TextStyle(
                        //             fontSize: 22,
                        //             color: Colors.redAccent),),
                        //         MaterialButton(
                        //           height: 30,
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius:
                        //               BorderRadius.circular(25.0),
                        //               side: BorderSide(
                        //                   color: Colors.redAccent)),
                        //           onPressed: () {},
                        //           color: Colors.redAccent,
                        //           child: Text(
                        //             "Book Rooms",
                        //             style: TextStyle(
                        //                 fontSize: 14,
                        //                 color: Colors.white),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     Divider(
                        //       height: 10,
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.freebeds[0].roomType +
                        //                           " beds",
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.freebeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .freebeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check,
                        //         onChanged: (v) {
                        //           setState(() {
                        //             _check = !_check;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     // Divider(
                        //     //   height: 10,
                        //     // ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.conbeds[0].roomType,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.conbeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .conbeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check1,
                        //         onChanged: (v) {
                        //           if (v) {
                        //             selectedContacts.contains({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             })
                        //                 ? selectedContacts.remove({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             })
                        //                 : selectedContacts.add({
                        //               "Type" : widget.hospitalvalues
                        //                   .conbeds[0].roomType,
                        //               "Count" : widget.hospitalvalues
                        //                   .conbeds[0].noOfBeds,
                        //               "Charges" : widget.hospitalvalues
                        //                   .conbeds[0].charges,
                        //             });
                        //             // addlist(widget.hospitalvalues
                        //             //     .conbeds[0]);
                        //             print(selectedContacts.toString());
                        //           } else {
                        //             // removelist();
                        //             print(selectedContacts.toString());
                        //             // selectedContacts.clear();
                        //           }
                        //           print("Vaues::"+v.toString());
                        //           setState(() {
                        //             _check1 = !_check1;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Colors.white,
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey,
                        //             blurRadius: 5.0,
                        //           ),
                        //         ],
                        //       ),
                        //       height: 50,
                        //       child: CheckboxListTile(
                        //         title: Container(
                        //           width: 400,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 210,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       widget.hospitalvalues.covidbeds[0].roomType,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                     Text(
                        //                       widget.hospitalvalues.covidbeds[0].noOfBeds,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Rs. " +
                        //                     widget.hospitalvalues
                        //                         .covidbeds[0]
                        //                         .charges,
                        //                 style: TextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.redAccent),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         // controlAffinity: ListTileControlAffinity.leading,
                        //         //tileColor: Colors.white,
                        //         value: _check2,
                        //         onChanged: (v) {
                        //           if (v) {
                        //             addlist(widget.hospitalvalues
                        //                 .covidbeds[0]);
                        //             print(selectedContacts.toString());
                        //           } else {
                        //             // removelist();
                        //             print(selectedContacts.toString());
                        //           }
                        //           print("Vaues::"+v.toString());
                        //           setState(() {
                        //             _check2 = !_check2;
                        //           });
                        //         },
                        //       ),
                        //     ),
                        //     // Divider(
                        //     //   height: 10,
                        //     // ),
                        //     new ConstrainedBox(
                        //       constraints: BoxConstraints(maxHeight: 1000),
                        //       child: new ListView.builder(
                        //         physics: ScrollPhysics(),
                        //         shrinkWrap: true,
                        //         itemCount: widget.hospitalvalues.beds.length,
                        //         itemBuilder: (context, i) {
                        //           return Container(
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(15),
                        //               color: Colors.white,
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: Colors.grey,
                        //                   blurRadius: 5.0,
                        //                 ),
                        //               ],
                        //             ),
                        //             height: 50,
                        //             child: CheckboxListTile(
                        //               title: Container(
                        //                 width: 400,
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Container(
                        //                       width:210,
                        //                       child: Row(
                        //                         mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                         children: [
                        //                           Text(
                        //                             widget.hospitalvalues
                        //                                 .beds[i]
                        //                                 .roomType ,
                        //                             style: TextStyle(
                        //                                 fontSize: 16,
                        //                                 color: Colors.redAccent),
                        //                           ),
                        //                           Text(
                        //                             widget.hospitalvalues
                        //                                 .beds[i]
                        //                                 .noOfBeds,
                        //                             style: TextStyle(
                        //                                 fontSize: 16,
                        //                                 color: Colors.redAccent),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     Text(
                        //                       "Rs. " +
                        //                           widget.hospitalvalues
                        //                               .beds[i]
                        //                               .charges,
                        //                       style: TextStyle(
                        //                           fontSize: 16,
                        //                           color: Colors.redAccent),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               // controlAffinity: ListTileControlAffinity.leading,
                        //               //tileColor: Colors.white,
                        //               value: check[i],
                        //               onChanged: (bool v) {
                        //                 setState(() {
                        //                   Itemchange(v, i);
                        //                 });
                        //               },
                        //             ),
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                    ],
                  ),
                ),
      ),
    );
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
  _openPopup(context,String title,String label)  {
    print("Open pop up");
    List list=[];
    if (title == "Rooms") {
      if(widget.hospitalvalues.freebeds[0].roomType==label){
        setState(() {
          topic = "Free Bed Details";
            key2 = 0;
        });
            list.add({
              "roomType":label,
              "noOfBeds":widget.hospitalvalues.freebeds[0].noOfBeds,
              'charges':widget.hospitalvalues.freebeds[0].charges,
            });
          }
          else if(widget.hospitalvalues.conbeds[0].roomType==label){
        setState(() {
          topic = "Concessional Bed Details";
          key2 = 0;
        });
            list.add({
              "roomType":label,
              "noOfBeds":widget.hospitalvalues.conbeds[0].noOfBeds,
              'charges':widget.hospitalvalues.conbeds[0].charges,
            });
          }
          else if(widget.hospitalvalues.covidbeds[0].roomType==label){
        setState(() {
          topic = "Covid Bed Details";
          key2 = 0;
        });
            list.add({
              "roomType":label,
              "noOfBeds":widget.hospitalvalues.covidbeds[0].noOfBeds,
              'charges':widget.hospitalvalues.covidbeds[0].charges,
            });
          }
          else{
               widget.hospitalvalues.beds.asMap().forEach((key, value) {
                 print("Key:::"+key.toString());setState(() {
                   topic = "Special Bed Details";
          });
          if(value.roomType==label){
            setState(() {
              key2 = key;
            });

            list.add({
              "roomType":label,
              "noOfBeds":value.noOfBeds,
              'charges':value.charges,
            });
          }
        });
          //   for(var name  in widget.hospitalvalues.beds){
          //     setState(() {
          //       topic = "Special Bed Details";
          //     });
          //     if(name.roomType==label){
          //       list.add({
          //         "roomType":label,
          //         "noOfBeds":name.noOfBeds,
          //         'charges':name.charges,
          //       });
          //     }
          //   }
          }
    }
    else if(title == "Pathology"){
      setState(() {
        topic = "Diagnosis Details";
      });
      for(var name in widget.hospitalvalues.diagnosis){
        if(name.test==label){
          list.add({
            "Type":label,
            "charges":name.charge,
            "packName":title
          });
          setState(() {});
        }
      }
    }
    else if(title == "Health"){
      setState(() {
        topic = "Health Package";
      });
      for(var name in widget.hospitalvalues.health){
        if(name.packagename==label){
          list.add({
            "Type":label,
            "charges":name.amount,
            "packName":title
          });
        }
      }
    }else if(title == "Surgery") {
      setState(() {
        topic = "Surgery Packages";
      });
      for (var name in widget.hospitalvalues.surgery) {
        if (name.surgeryname == label) {
          list.add({
            "Type": label,
            "charges": name.suramount,
            "packName":title
          });
        }
      }
    }
    print("end calculation");
    (list.isEmpty||list==null)?AuthService().toast("Please select any bed type"): Alert(
        context: context,
        title: title,
        content: (title=="Rooms")?Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(width:250,child: Text("Room Type: "+list[0]['roomType'])),
            Container(width:250,child: Text("Charges: "+list[0]['charges'])),
            Container(width:250,child: Text("Beds Available: "+list[0]['noOfBeds'])),
            // Container(
            //   child: TextFormField(
            //     controller: _nameController,
            //     onChanged: (v) => bookingcount = v,
            //     decoration: InputDecoration(
            //       hintText: 'Booking bed count'
            //     ),
            //     validator: (v){
            //       if(v.trim().isEmpty) return 'Please enter something';
            //       return null;
            //     },
            //   ),
            // ),
          ],
        ):Column(
          children: <Widget>[
            Container(width:250,child: Text("Type: "+list[0]['Type'])),
            Container(width:250,child: Text("Charges: "+list[0]['charges'])),
          //   Container(
          //     child: TextFormField(
          //     controller: _nameController,
          //     onChanged: (v) => bookingcount = v,
          //     decoration: InputDecoration(
          //         hintText: 'Booking bed count'
          //     ),
          //     validator: (v){
          //     if(v.trim().isEmpty) return 'Please enter something';
          //       return null;
          //     },
          // ),
          //   ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (list[0]['noOfBeds'] != null) {
                 bal = int.parse(list[0]['noOfBeds'])-1;
                 list3.add({
                   "roomType":label,
                   "noOfBeds":bal.toString(),
                   'charges':list[0]['charges'],
                 });
                 list4.add({
                   "roomType":label,
                   "noOfBeds": "1",
                   'charges':list[0]['charges'],
                 });
                 print("added");
                 try {
                   ApiService().bookhospital(widget.hospitalvalues.bookingPhNo, widget.mobile, ConstantUtils().CONFIRM, list4, "","","");
                   print("Added!!");
                   fb.reference().child("Hospitals/${widget.key1}/$topic/$key2/${"noOfBeds"}").set(bal.toString());
                   list3.clear();
                   print("Added!!");
                   Navigator.pop(context);
                   Navigator.pop(context);
                   AuthService().toast("Added Successfully!!");
                   // fb.reference().child("Hospitals").child(widget.key1).update({topic:list3});
                 } catch (e) {
                   print(e);
                 }
              }else{
                print("added");
                try {
                  ApiService().bookhospital(widget.hospitalvalues.bookingPhNo, widget.mobile, ConstantUtils().CONFIRM, list, "","","");
                  print("Added!!");
                  Navigator.pop(context);
                  Navigator.pop(context);
                  AuthService().toast("Added Successfully!!");
                  // fb.reference().child("Hospitals").child(widget.key1).update({topic:list3});
                } catch (e) {
                  print(e);
                }
              }

            },
            child: Text(
              "Confirm",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }
  var list = Iterable<int>.generate(10).toList();
}
