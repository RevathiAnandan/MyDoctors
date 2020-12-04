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
              title: Text(dummyData[index].userNumber),
              subtitle: Text("RoomType:"+dummyData[index].bookdetails[0].roomType +"Charges:"+dummyData[index].bookdetails[0].charges ),
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
                  AuthService().toast("Booking Confirmed");
                  if(dummyData[index].status == "Booking Confirm"){
                    ApiService().bookhospital(dummyData[index].bookingNumber, dummyData[index].userNumber,"discharge",dummyData[index].bookdetails , keys1[index].toString(),dummyData[index].BookingDate,DateTime.now().toString());
                  }else{
                    ApiService().bookhospital(dummyData[index].bookingNumber, dummyData[index].userNumber,"Booking Confirm",dummyData[index].bookdetails , keys1[index].toString(),DateTime.now().toString(),"");
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
            if (refreshToken.bookingNumber == widget.mobile) {
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
