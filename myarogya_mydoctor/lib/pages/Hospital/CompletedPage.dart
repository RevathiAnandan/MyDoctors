import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';
import 'package:myarogya_mydoctor/pages/Hospital/EditAddHospital.dart';

class CompletedPage extends StatefulWidget {
  final String id;
  final String mobile;
  final String category;

  CompletedPage(this.id,this.mobile,this.category);

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  List<Hospital> dummyData = [];
  List<String> Key1 = [];
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
    return Scaffold(
            appBar: AppBar(
              title: Text(
                "My Hospitals",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.redAccent),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
            ),
            body: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text(
                              dummyData[i].hospitalName != null
                                  ? dummyData[i].hospitalName
                                  : "",
                              style: new TextStyle(fontWeight: FontWeight.bold),
                            ),
                            new Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: new Text(
                                dummyData[i].bookingPhNo != null
                                    ? dummyData[i].bookingPhNo
                                    : "",
                                style: new TextStyle(
                                    color: Colors.grey, fontSize: 15.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditAddHospital(dummyData[i], Key1[i],widget.id,widget.mobile,widget.category),
                          ));
                    },
                  )
                ],
              ),
            ),
          );
  }

  Future<Hospital> getHospitals() async {
    isLoading = true;
    try {
      var db = await fb.reference().child("Hospitals");
      db.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach(
          (key, values) {
            Key1.add(key);
            var refreshToken = Hospital.fromJson(values);
            print(refreshToken);
            if (refreshToken.status == "Completed" &&
                refreshToken.userno == widget.mobile) {
              dummyData.add(refreshToken);
              print(dummyData.length);
              setState(() {
                isLoading = false;
              });
            }
          },
        );
      });
    } catch (e) {
      print(e);
    }
  }
}
