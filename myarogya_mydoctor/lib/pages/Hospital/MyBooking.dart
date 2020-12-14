import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Booking.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
class MyBooking extends StatefulWidget {
  String id;
  String mobile;
  MyBooking(this.id,this.mobile);
  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  var text1 = "Confirm";
  bool something = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooking();
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     body:
     NestedScrollView(
       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
         return <Widget>[
           SliverAppBar(
             backgroundColor: Colors.white,
             expandedHeight: 250.0,
             floating: false,
             pinned: true,
             leading: Container(),
             flexibleSpace: FlexibleSpaceBar(
               centerTitle: true,
               title: Align(
                 alignment: Alignment.bottomLeft,
                 child: Text(
                   "    MyBooking",
                   style: TextStyle(
                     color: Colors.redAccent,
                     fontSize: 25.0,
                     fontFamily: 'Lato',
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
               background: Image.network(
                 "https://www.connect5000.com/wp-content/uploads/2016/07/blog-pic-117-1.jpeg",
                 fit: BoxFit.cover,
               ),
             ),

           ),
           // new SliverPadding(padding: EdgeInsets.all(50)),
         ];
       },
       body: Container(
         height: 100,
         width: 400,
         child: Card(
      child: ListView.builder(
          itemCount: dummyData.length,
          itemBuilder:(context,index){
            print(dummyData[index].bookdetails.toString());
            return ListTile(
              leading: Text((index+1).toString()),
              title: Text(dummyData[index].userNumber),
              subtitle:(dummyData[index].bookdetails[0].packName !=null ) ?Text("Package Name:"+dummyData[index].bookdetails[0].packName
                  +"Charges:"+dummyData[index].bookdetails[0].charges ):(Text("RoomType:"+dummyData[index].bookdetails[0].roomType
                  +"  "+"Charges:"+dummyData[index].bookdetails[0].charges )),
              trailing: FlatButton(
                child: Text(dummyData[index].status,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Lato",
                        fontSize: 14)),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(25.0),
                    side: BorderSide(
                        color: Colors.redAccent)),
                padding: EdgeInsets.all(10),
                color: Colors.redAccent,
                onPressed: () {
                  if(dummyData[index].status == "Booking Confirmed"){
                    var db = fb.reference().child("HospitalBookings").child( keys1[index].toString());
                    db.update({
                      'Status':"Discharge",
                      "DischargeDate": formatDate( DateTime.now() , [dd, ' ', MM, ' ', yyyy,'/', HH , ':', nn]).toString(),
                    });
                    // ApiService().bookhospital(dummyData[index].bookingNumber, dummyData[index].userNumber,"Discharge",dummyData[index].bookdetails , keys1[index].toString(),dummyData[index].BookingDate,DateTime.now().toString());
                  }else if(dummyData[index].status ==  "Pending Confirmation"){
                    AuthService().toast("Booking Confirmed");
                    var db = fb.reference().child("HospitalBookings").child( keys1[index].toString());
                    db.update({
                      'Status':"Booking Confirmed",
                      "BookingDate": formatDate( DateTime.now() , [dd, ' ', MM, ' ', yyyy]).toString(),
                    });
                    // ApiService().bookhospital(dummyData[index].bookingNumber, dummyData[index].userNumber,"Booking Confirmed",dummyData[index].bookdetails , keys1[index].toString(),DateTime.now().toString(),"");
                  }else if(dummyData[index].status ==  "Discharge"){
                    if(dummyData[index].DischargeDate != null){
                      AuthService().toast("Discharged At"+" "+ dummyData[index].DischargeDate.split(".")[0]);
                    }
                  }
                  },
              ),
            );
          },

      ),
         ),
       ),
       // ),
     ),
   );
  }
  FirebaseDatabase fb = FirebaseDatabase.instance;
  List<Booking> dummyData = [];
  List dummyData1 = [];
  List refresh = [];
  List keys1 = [];
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
            if (refreshToken.bookingNumber == widget.mobile&& refreshToken.status!="Cancel") {
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
