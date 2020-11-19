import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/improvement/addhospitals.dart';
import 'package:myarogya_mydoctor/improvement/hospitaldetailed.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/services/datasearch.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';

class Hospitals extends StatefulWidget {
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
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
                      icon: Icon(Icons.add, color: Colors.redAccent,size: 35,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddHospital()),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.redAccent,size: 35,),
                      onPressed: () {
                        showSearch(context: context, delegate: DataSearch());
                      },
                    ),
                    PopupMenuButton<String>(
                      onSelected: choiceAction,
                      itemBuilder: (BuildContext context){
                        return ConstantsH.choices.map((String choice){
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
            body: (hospitalvalues.isEmpty)?Center(child: Container(child: Text("Yet to be Updated"),)):isLoading?Container(
              height: 50,
            width: 100,
            child: LinearProgressIndicator(backgroundColor: Colors.redAccent,valueColor:new AlwaysStoppedAnimation<Color>(Colors.green),)):ListView.builder(
              shrinkWrap: true,
              itemCount: hospitalvalues.length==null?null:hospitalvalues.length,
              itemBuilder: (context,i)=> new Column(
                children:<Widget> [
                  Divider(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 35 / 100,
                    width: MediaQuery.of(context).size.width * 91 / 100,
                    child:
                    InkWell(
                      onTap: ()=>Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HospitalDetails(i,hospitalvalues[i].hospitalName)),
                      ),
                      child: Card(
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Hero(
                                  tag: 'tagImage$i',
                                  child: (hospitalvalues[i].image[0]==null)?Image(
                                    image: NetworkImage(
                                      "https://previews.agefotostock.com/previewimage/medibigoff/f755e0d1e3ecce9569f57604ac0fd9a8/esy-001476475.jpg",
                                    ),
                                    width: 150,
                                    alignment: Alignment.centerLeft,
                                  ):Image(
                                    height: 300,
                                  image: NetworkImage(
                                    hospitalvalues[i].image[0],
                                ),
                        width: 150,
                        alignment: Alignment.centerLeft,
                      )
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    hospitalvalues[i].hospitalName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        fontFamily: 'Lato'),
                                  ),
                                  Text(
                                    hospitalvalues[i].hospitalAddress,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        fontFamily: 'Lato'),
                                  ),
                                  Image.network(
                                    "https://lh3.googleusercontent.com/proxy/lqTL9l33KeXONHOAlq1uejJcCRrLC7QR2aQn4AhmRfnmzX383QpKkTUips-4y7cq-JWmAmdPj7vHvXUFNYr0IFUWUhxas_-HO47kVQkMT_UkIN0f1MTsJy8wqZoshDaM",
                                    width: 100,
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 40,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                  Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  topLeft:
                                                  Radius.circular(10))),
                                          color: Colors.red,
                                          child: Center(
                                            child: Text('8.0',style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Very Good",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.local_hospital,),
                                      Text(
                                        "Hospital",
                                        style: TextStyle(
                                            fontFamily: 'Lato', fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Rs."+hospitalvalues[i].pricerange,
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 18,fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    " No Prepayment needed",
                                    style: TextStyle(
                                        fontFamily: 'Lato', fontSize: 15),
                                  )
                                ],
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
  void choiceAction(String choice){
    if(choice == ConstantsH.SignOut){
      AuthService().signOut(context);
    }else if(choice == ConstantsH.Settings){
      //todo:hospital settings to be done
    }
  }
  Future<Hospital> getHospitals() async{
    var db = await fb.reference().child("Hospitals");
    print(db);
    try {
      if( db != null ) {
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


      }else{
        print('Something is Null');
      }
    } catch (e) {
      print(e);
    }
  }
}
