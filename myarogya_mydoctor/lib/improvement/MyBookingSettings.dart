import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Booking.dart';
class MyBookingSettings extends StatefulWidget {
  String id;
  String mobile;
  MyBookingSettings(this.id,this.mobile);
  @override
  _MyBookingSettingsState createState() => _MyBookingSettingsState();
}

class _MyBookingSettingsState extends State<MyBookingSettings> {
  FirebaseDatabase fb = FirebaseDatabase.instance;
  List<Booking> dummyData = [];
  List dummyData1 = [];
  List refresh = [];
  List keys1 = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooking();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.redAccent,
          onPressed: ()=>Navigator.pop(context),
        ),
       backgroundColor: Colors.white,
        title: Text("My Bookings",
            style: TextStyle(
                color: Colors.redAccent,
                fontFamily: "Lato",
                fontSize: 20)),
      ),
      body: Container(
        child: Card(
          child:dummyData.length >0?
          ListView.builder(
            itemCount: dummyData.length,
            itemBuilder:(context,index){
              print(dummyData[index].bookdetails.toString());
              return ListTile(
                // title: Text(dummyData[index].userNumber),
                title:(dummyData[index].bookdetails[0].packName !=null ) ?Text("Package Name:"+dummyData[index].bookdetails[0].packName+"RoomType:"+dummyData[index].bookdetails[0].roomType
                    +"Charges:"+dummyData[index].bookdetails[0].charges ):(Text(dummyData[index].bookdetails[0].roomType
                    +"  "+"Charges:"+dummyData[index].bookdetails[0].charges,style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Lato",
                    fontSize: 18),)),
                trailing: FlatButton(
                  child: Text(dummyData[index].status,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Lato",
                          fontSize: 14)),
                  textColor: Colors.white,
                  onPressed: (){

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(25.0),
                      side: BorderSide(
                          color: Colors.redAccent)),
                  padding: EdgeInsets.all(10),
                  color: Colors.redAccent,
                ),
              );
            },
          ):Center(child: Text("No Data Found!!")),
        ),
      ),
    );
  }
  Future<Booking> getBooking() async {
    try {
      var db = await fb.reference().child("HospitalBookings");
      db.once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        Map<dynamic, dynamic> values = snapshot.value;
        //print(values.keys);
        values.forEach((key, values) {
          var refreshToken = Booking.fromJson(values);
          print(refreshToken);
          setState(() {
            if (refreshToken.userNumber == widget.mobile) {
              dummyData.add(refreshToken);
              keys1.add(key);
              print(dummyData[0].status);
            }
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
