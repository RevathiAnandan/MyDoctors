import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/improvement/addhospitals.dart';
import 'package:myarogya_mydoctor/improvement/bookdetailed.dart';
import 'package:myarogya_mydoctor/improvement/hospitaldetailed.dart';
import 'package:myarogya_mydoctor/pages/Hospital/MyBooking.dart';
import 'package:myarogya_mydoctor/pages/Hospital/hospitalsettings.dart';
import 'package:myarogya_mydoctor/pages/dashboard_screen.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/services/datasearch.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';
import 'package:image/image.dart' as imgresize;

import 'MyBookingSettings.dart';

class Hospitals extends StatefulWidget {
  String mobile;
  String id;

  Hospitals(this.mobile, this.id);

  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  List<Hospital> hospitalvalues = [];
  List<Hospital> filteredhospital = [];
  FirebaseDatabase fb = FirebaseDatabase.instance;
  bool isLoading = true;
  final _random = new Random();
  List hospitalnames = [];
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: Container(),
                backgroundColor: Colors.white,
                expandedHeight: MediaQuery.of(context).size.height/3.2,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      " My Hospital",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 25.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  background: Column(
                    children: <Widget>[
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/3996.jpg",
                            fit: BoxFit.cover,
                            // color: Colors.blue,
                            colorBlendMode: BlendMode.hue,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 11.0, 100.0, 16.0),
                            child: Container(
                              height: 36.0,
                              width: double.infinity,
                              child: CupertinoTextField(
                                onChanged: (text) {
                                  setState(() {
                                    hospitalvalues = filteredhospital
                                        .where((u) => (u.hospitalName
                                                .toLowerCase()
                                                .contains(text.toLowerCase()) ||
                                            u.hospitalAddress
                                                .toLowerCase()
                                                .contains(text.toLowerCase()) ||
                                            checkspeciality(
                                                u.specialities, text) ||
                                            u.facilities[0]
                                                .toLowerCase()
                                                .contains(text.toLowerCase())))
                                        .toList();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                placeholder: 'Search',
                                placeholderStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 14.0,
                                  fontFamily: 'Brutal',
                                ),
                                prefix: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      9.0, 6.0, 9.0, 6.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Color(0xffF0F1F5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.redAccent,
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddHospital(widget.mobile)),
                      );
                    },
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.search,
                  //     color: Colors.redAccent,
                  //     size: 35,
                  //   ),
                  //   onPressed: () {
                  //     hospitalvalues.forEach((name){
                  //       hospitalnames.add(name.hospitalName);
                  //     });
                  //     showSearch(context: context, delegate: DataSearch());
                  //   },
                  // ),
                  PopupMenuButton<String>(
                    icon: new Icon(
                      Icons.settings,
                      // Icons.more_vert_rounded,
                      color: Colors.redAccent,
                      size: 35,
                    ),
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return ConstantsH.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  )
                ],
              ),
            ];
          },
          body: (hospitalvalues == null)
              ? Center(
                  child: Container(
                  child: Text("Yet to be Updated"),
                ))
              : isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 5,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.redAccent,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: hospitalvalues.length == null
                            ? null
                            : hospitalvalues.length,
                        itemBuilder: (context, i) {
                          // Image resizeimage = imgresize.copyResize(src);
                          // Future.delayed(Duration.zero, () async {
                          //   specialBedscharge(i);
                          // });
                          return new Column(
                            children: <Widget>[
                              // Divider(
                              //   height: 10,
                              // ),
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HospitalDetails(
                                          i, hospitalvalues[i])),
                                ),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              yearsofexperience(hospitalvalues[
                                                              i]
                                                          .dateofIncorporation)
                                                      .toString() +
                                                  " Years in service",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                            Hero(
                                                tag: 'tagImage$i',
                                                child: (hospitalvalues[i]
                                                            .image[0] ==
                                                        null)
                                                    ? Image(
                                                        image: NetworkImage(
                                                          "https://previews.agefotostock.com/previewimage/medibigoff/f755e0d1e3ecce9569f57604ac0fd9a8/esy-001476475.jpg",
                                                        ),
                                                        width: 50,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      )
                                                    : Container(
                                                        width: 150,
                                                        height: 250,
                                                        child: Image(
                                                          // height: 250,
                                                          fit: BoxFit.fitHeight,
                                                          image: NetworkImage(
                                                            hospitalvalues[i]
                                                                .image[0],
                                                          ),
                                                          // width: 150,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                        ),
                                                      )),
                                            Container(
                                              height: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Container(
                                          width: 220,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(),
                                                  Row(
                                                    children: [
                                                      hospitalvalues[i]
                                                                  .isNabh ==
                                                              "true"
                                                          ? Image(
                                                              height: 25,
                                                              image: AssetImage(
                                                                  "assets/images/NABH LOGO.png"),
                                                              width: 25,
                                                            )
                                                          : Container(),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      hospitalvalues[i].is24 ==
                                                              "true"
                                                          ? Text(
                                                              '24/7',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13),
                                                            )
                                                          : Container(),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      hospitalvalues[i]
                                                                  .isCovid ==
                                                              "true"
                                                          ? Container(
                                                              height: 30,
                                                              width: 60,
                                                              child: Card(
                                                                color: Colors
                                                                    .redAccent,
                                                                child: Center(
                                                                  child: Text(
                                                                    "COVID",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Lato',
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    hospitalvalues[i]
                                                        .hospitalName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 18,
                                                        fontFamily: 'Lato'),
                                                  ),
                                                  SizedBox(width: 40),
                                                ],
                                              ),
                                              Text(
                                                hospitalvalues[i]
                                                        .hospitalAddress +
                                                    "-" +
                                                    hospitalvalues[i].pincode,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    fontFamily: 'Lato'),
                                              ),
                                              getspeciality(hospitalvalues[i]
                                                  .specialities),
                                              // Container(
                                              //   width: 300,
                                              //   child: Column(
                                              //     crossAxisAlignment:
                                              //     CrossAxisAlignment.end,
                                              //     children: [
                                              //       Text(
                                              //         "Pincode: "+hospitalvalues[i].pincode,
                                              //         style: TextStyle(
                                              //             fontFamily: 'Lato',
                                              //             fontSize: 14,
                                              //             fontWeight:
                                              //             FontWeight.w900),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              Container(
                                                width: 300,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: 160,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Free Beds:",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Lato',
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            hospitalvalues[i]
                                                                .freebeds[0]
                                                                .noOfBeds,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Lato',
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 160,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Concessional Beds:",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Lato',
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            hospitalvalues[i]
                                                                .conbeds[0]
                                                                .noOfBeds,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Lato',
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    (hospitalvalues[i]
                                                                .covidbeds !=
                                                            null)
                                                        ? Container(
                                                            width: 160,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Covid Beds:",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Lato',
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                Text(
                                                                  (hospitalvalues[
                                                                          i]
                                                                      .covidbeds[
                                                                          0]
                                                                      .noOfBeds),
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Lato',
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container(),
                                                    Container(
                                                      width: 160,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Special Beds:",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Lato',
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            specialBeds(i)
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Lato',
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              isLoading?Container():Container(
                                                width: 300,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      getMin(hospitalvalues[i].beds)[0]['Bed'].toString() +
                                                          "- Rs." +
                                                           getMin(hospitalvalues[i].beds)[0]['Charges'].toString()+
                                                          "/-per day per bed ",
                                                      style: TextStyle(
                                                          fontFamily: 'Lato',
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w900),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: FlatButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Bookdetailed(
                                                                  hospitalvalues[
                                                                      i],
                                                                  key1[i],
                                                                  widget
                                                                      .mobile),
                                                        ),
                                                      );
                                                      // ApiService().bookhospital(hospitalvalues[i].bookingPhNo, widget.mobile,"Booked","");
                                                      // AuthService().toast("Waiting for Confirmation");
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25.0),
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .redAccent)),
                                                    padding: EdgeInsets.all(10),
                                                    color: Colors.redAccent,
                                                    child: hospitalvalues[i]
                                                                .status ==
                                                            "Confirm"
                                                        ? Text(
                                                            "Confirm",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    "Lato",
                                                                fontSize: 14),
                                                          )
                                                        : Text(
                                                            "Book Now",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    "Lato",
                                                                fontSize: 14),
                                                          )),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == ConstantsH.MyBooking) {
      //todo:hospital settings to be done
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyBookingSettings(widget.id, widget.mobile),
        ),
      );
    } else if (choice == ConstantsH.Settings) {
      //todo:hospital settings to be done
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HospitalSettings(widget.id, widget.mobile),
        ),
      );
    }
  }

  Future<Hospital> getHospitals() async {
    print("FirbaseMessaging!!");
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final FirebaseUser user = await _auth.currentUser();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((token) => print("FM" + token));
    var db = await fb.reference().child("Hospitals");
    print(db);
    try {
      if (db != null) {
        db.once().then((DataSnapshot snapshot) {
          print("Hospitals");
          // print(snapshot.value);
          print(snapshot.value);
          // print(snapshot.value["Special Bed Details"]);
          // print(snapshot.value);
          Map<dynamic, dynamic> values = snapshot.value??"";
          values.forEach((key, value) {
            print("VAlues:: $value");
            // print(value["hospitalName"]);
            var refreshToken = Hospital.fromJson(value)??"";
            hospitalvalues.add(refreshToken);
            filteredhospital.add(refreshToken);
            key1.add(key);
            print("Hops::::${hospitalvalues.toString()}");
            setState(() {
              isLoading = false;
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

  List key1 = [];
  Widget getspeciality(List speciality) {
    List<Widget> list = new List<Widget>();
    for (var name in speciality) {
      list.add(Container(
        width: 65,
        child: Row(
          children: [
            Icon(
              Icons.done,
              size: 13,
            ),
            new Text(
              name,
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 14.0,
                fontFamily: 'Lato',
                //fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ));
    }
    return new Wrap(spacing: 5.0, runSpacing: 3.0, children: list);
  }

  specialBeds(int index) {
    int totalSpecialbeds = 0;
    int toint;
    hospitalvalues[index].beds.forEach((element) {
      var count = element.noOfBeds;
      print("jhv" + count);
      toint = int.parse(count);
      print("hdkwh::" + (int.parse(count)).toString());
      totalSpecialbeds = totalSpecialbeds + int.parse(count);
      print(totalSpecialbeds.toString());
    });
    return totalSpecialbeds;
  }

  var minValues;
  var minbed;
  List minbedtype=[];
  specialBedscharge(int index) {
    var values = hospitalvalues[index].beds;
    minValues = int.parse(values[0].charges);
    for (int i = 0; i < values.length; i++) {
      if (int.parse(values[i].charges) < minValues) {
        setState(() {
          minValues = int.parse(values[i].charges);
        });
      }
    }
    for (int i = 0; i < values.length; i++) {
      if (minValues == int.parse(values[i].charges)) {
        setState(() {
          minbed = values[i].roomType;
        });
      }
      break;
    }
    // return minValues;
  }

  yearsofexperience(String date) {
    print(date);
    int now;
    int year;
    year = int.parse(date.split('/')[2]);
    now = DateTime.now().year - year;
    return now;
  }

  List getMin(List<OtherBeds> inputArray) {
    print(inputArray);
    if (inputArray.isNotEmpty) {
      minbedtype.clear();
      print("Harun");
      int minValue = int.parse(inputArray[0].charges)??0;
      if (inputArray.length == 1) {
        minbedtype.add({
          "Bed" : inputArray[0].roomType,
          "Charges" : int.parse(inputArray[0].charges)
        });
      }else if(inputArray.length > 1){
      for (int i = 0; i < inputArray.length; i++) {
        print(int.parse(inputArray[i].charges));
        print(inputArray[i].roomType);
        if (int.parse(inputArray[i].charges) <= minValue) {
          print("Inside if");
            minbedtype.add({
              "Bed" : inputArray[i].roomType,
              "Charges" : int.parse(inputArray[i].charges)
          });
          print(minbedtype);
          // minValue = int.parse(inputArray[i].charges);
          // minbed = inputArray[i].roomType;
        }
      }
      }
    } else{
        minbedtype.add({
          "Bed" : "",
          "Charges" : 0
        });
      }

    return minbedtype;
  }

  checkspeciality(List splity, String text) {
    bool status;
    splity.forEach((element) {
      if (element.toLowerCase().contains(text.toLowerCase())) {
        status = true;
      } else {
        status = false;
      }
    });
    return status;
  }
}

