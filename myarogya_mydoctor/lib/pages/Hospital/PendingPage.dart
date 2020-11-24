import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';
class PendingPage extends StatefulWidget {
  @override
  _PendingPageState createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  List<Hospital>dummyData=[];
  bool isLoading = false;
  FirebaseDatabase fb = FirebaseDatabase.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHospitals();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : (dummyData.isEmpty
        ? Center(child: Text("No Data Found!!"))
        : new ListView.builder(
      itemCount: dummyData.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 10.0,
          ),
          new ListTile(
            title: new Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.redAccent,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    new Text(
                      dummyData[i].hospitalName != null ? dummyData[i].hospitalName : "",
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        dummyData[i].bookingPhNo != null ? dummyData[i].bookingPhNo : "",
                        style:
                        new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {

            },
          )
        ],
      ),
    ));
  }
  Future<Hospital> getHospitals() async {
    isLoading = true;
    try {
      var db = await fb
          .reference()
          .child("Hospitals");
      db.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var refreshToken = Hospital.fromJson(values);
          print(refreshToken);
          if(refreshToken.status == "Pending"){
            dummyData.add(refreshToken);
            print(dummyData.length);
          }

        }

        );
      });
    } catch (e) {
      print(e);
    }
  }
}
