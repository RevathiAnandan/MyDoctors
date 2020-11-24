import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/improvement/addhospitals.dart';
import 'package:myarogya_mydoctor/improvement/hospitaldetailed.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/services/datasearch.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';

class Hospitals extends StatefulWidget {
  String mobile;

  Hospitals(this.mobile);

  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  List<Hospital> hospitalvalues = [];
  FirebaseDatabase fb = FirebaseDatabase.instance;
  bool isLoading = true;
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
                backgroundColor: Colors.white,
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "  Hospitals",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 25.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  background: Image.network(
                    "https://www.healthcareitnews.com/sites/hitn/files/pexels-pixabay-236380.jpg",
                    fit: BoxFit.cover,
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
                        MaterialPageRoute(builder: (context) => AddHospital()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.redAccent,
                      size: 35,
                    ),
                    onPressed: () {
                      showSearch(context: context, delegate: DataSearch());
                    },
                  ),
                  PopupMenuButton<String>(
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
          body: (hospitalvalues==null)
              ? Center(
                  child: Container(
                  child: Text("Yet to be Updated"),
                ))
              : isLoading
                  ? Container(
                      height: 50,
                      width: 100,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.redAccent,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.green),
                      ))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: hospitalvalues.length == null
                          ? null
                          : hospitalvalues.length,
                      itemBuilder: (context, i) => new Column(
                        children: <Widget>[
                          Divider(
                            height: 10,
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 40 / 100,
                            width: MediaQuery.of(context).size.width * 94 / 100,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HospitalDetails(
                                        i, hospitalvalues[i].hospitalName)),
                              ),
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(yearsofexperience(hospitalvalues[i].dateofIncorporation).toString()+"Years of Experience"),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: Hero(
                                              tag: 'tagImage$i',
                                              child: (hospitalvalues[i].image[0] ==
                                                      null)
                                                  ? Image(
                                                      image: NetworkImage(
                                                        "https://previews.agefotostock.com/previewimage/medibigoff/f755e0d1e3ecce9569f57604ac0fd9a8/esy-001476475.jpg",
                                                      ),
                                                      width: 150,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                    )
                                                  : Image(
                                                      height: 250,
                                                      image: NetworkImage(
                                                        hospitalvalues[i].image[0],
                                                      ),
                                                      width: 150,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                    )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 220,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 25,
                                                    width: 30,
                                                    child: Card(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                              topRight:
                                                              Radius.circular(
                                                                  10),
                                                              topLeft:
                                                              Radius.circular(
                                                                  10))),
                                                      color: Colors.red,
                                                      child: Center(
                                                        child: Text(
                                                          '8.0',
                                                          style: TextStyle(
                                                              color: Colors.white,fontSize: 10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Very Good",
                                                    style: TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                hospitalvalues[i].hospitalName,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18,
                                                    fontFamily: 'Lato'),
                                              ),
                                              SizedBox(width:40),
                                            ],
                                          ),
                                          Text(
                                            hospitalvalues[i].hospitalAddress,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                fontFamily: 'Lato'),
                                          ),
                                          Text(
                                            "Rs." + hospitalvalues[i].pricerange,
                                            style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          getspeciality(hospitalvalues[i].specialities),
                                          Row(
                                            children: [
                                              Text(
                                                "Free Beds:" +
                                                    hospitalvalues[i]
                                                        .freebeds[0]
                                                        .noOfBeds,
                                                style: TextStyle(
                                                    fontFamily: 'Lato',
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Con Beds:" +
                                                    hospitalvalues[i]
                                                        .conbeds[0]
                                                        .noOfBeds,
                                                style: TextStyle(
                                                    fontFamily: 'Lato',
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Special Beds:" +
                                                    specialBeds(i).toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Lato',
                                                    fontSize: 15),
                                              ),

                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: FlatButton(
                                              onPressed: (){
                                                ApiService().bookhospital(hospitalvalues[i].bookingPhNo, widget.mobile,"Booked","");
                                                AuthService().toast("Waiting for Confirmation");
                                              },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        25.0),
                                                    side: BorderSide(
                                                        color:
                                                        Colors.redAccent)),
                                                padding: EdgeInsets.all(10),
                                                color: Colors.redAccent,
                                                child:hospitalvalues[i].status=="Confirm"?Text(
                                                  "Confirm",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Lato",
                                                      fontSize: 14),
                                                ): Text(
                                                  "Book Now",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Lato",
                                                      fontSize: 14),
                                                )),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == ConstantsH.SignOut) {
      AuthService().signOut(context);
    } else if (choice == ConstantsH.Settings) {
      //todo:hospital settings to be done
    }
  }

  Future<Hospital> getHospitals() async {
    var db = await fb.reference().child("Hospitals");
    print(db);
    try {
      if (db != null) {
        db.once().then((DataSnapshot snapshot) {
          print("Hospitals");
          // print(snapshot.value);
          print(snapshot.value);
          print(snapshot.value["Special Bed Details"]);
          // print(snapshot.value);
          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key, value) {
            print("VAlues:: $value");
            print(value["hospitalName"]);
            var refreshToken = Hospital.fromJson(value);
            hospitalvalues.add(refreshToken);
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
  Widget getspeciality(List speciality){
    List<Widget> list = new List<Widget>();
    for(var name in speciality){
      list.add(Container(
        width: 65,
        child: Row(
          children: [
            Icon(Icons.done,size: 13,),
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
      )
      );
    }
    return new  Wrap(
        spacing: 5.0,
        runSpacing: 3.0,
        children: list);

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
  yearsofexperience(String date){
    int now;
    int year;
    year = int.parse(date.split('/')[2]);
    now = DateTime.now().year - year;
    return now;
  }
}
