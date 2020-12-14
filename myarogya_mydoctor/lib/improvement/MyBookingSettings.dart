import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Booking.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:date_format/date_format.dart';
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
  int token;
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
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                // title: Text(dummyData[index].userNumber),
                title:(dummyData[index].bookdetails[0].packName !=null ) ?Text(dummyData[index].bookdetails[0].packName
                    +" "+"Charges:"+dummyData[index].bookdetails[0].charges,style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Lato",
                    fontSize: 18), ):(Text(dummyData[index].bookdetails[0].roomType
                    +"  "+"Charges:"+dummyData[index].bookdetails[0].charges,style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Lato",
                    fontSize: 18),)),
                trailing: Container(
                  width: 200  ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        child: Text(dummyData[index].status,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Lato",
                                fontSize: 14)),
                        textColor: Colors.white,
                        onPressed: (){
                            if(dummyData[index].status=="Confirm"){

                            }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(25.0),
                            side: BorderSide(
                                color: Colors.redAccent)),
                        padding: EdgeInsets.all(10),
                        color: Colors.redAccent,
                      ),
                      PopupMenuButton<String>(
                        padding: EdgeInsets.all(5),
                        icon: new Icon(
                          Icons.more_vert_rounded,
                          color: Colors.redAccent,

                        ),
                        onSelected: choiceAction,
                        itemBuilder: (BuildContext context) {
                          return ConstantUtils.choices.map((String choice) {
                            token = index;
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      )
                    ],
                  ),
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
            if (refreshToken.userNumber == widget.mobile&&refreshToken.status!="Cancel") {
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
  void choiceAction(String choice) {
    if (choice == ConstantUtils.Cancel) {
      // ApiService().bookhospital(dummyData[token].bookingNumber,dummyData[token].hospitalName , widget.mobile, "Cancel", dummyData[token].bookdetails , "","","",DateTime.now().toString());
      var db = fb.reference().child("HospitalBookings").child( keys1[token].toString());
      db.update({
        'Status':"Cancel",
        "CancelDate": formatDate( DateTime.now() , [dd, ' ', MM, ' ', yyyy,'/', HH , ':', nn]).toString(),
      });
    }
  }
}
