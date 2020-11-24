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
  FirebaseDatabase fb = FirebaseDatabase.instance;
  List<Hospital> hospitalvalues = [];
  bool isLoading=true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Column(
              children: [
                Text("Choose room type"),
                Text(widget.hospitalname,style: TextStyle(fontSize: 15),),
              ],
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: hospitalvalues.length == null
              ? null
              : hospitalvalues.length,
          itemBuilder: (context,i){
            return Container(
              height:
              MediaQuery.of(context).size.height * 40 / 100,
              width: MediaQuery.of(context).size.width * 94 / 100,
              child: Card(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      child: Text(hospitalvalues[i].freebeds[0].roomType),
                    )
                  ],
                ),

              ),
            );
          },
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
}
