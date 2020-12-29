import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myarogya_mydoctor/model/Booking.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctorsettings.dart';
import 'package:myarogya_mydoctor/pages/Doctor/update_profile_screen.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
             actions: [
               PopupMenuButton<String>(
                 icon: Icon(Icons.settings,color: Colors.redAccent,size: 35,),
                 onSelected: choiceAction,
                 itemBuilder: (BuildContext context){
                   return ConstantsD.choices.map((String choice){
                     return PopupMenuItem<String>(
                       value: choice,
                       child: Text(choice),
                     );
                   }).toList();
                 },
               )
             ],
             backgroundColor: Colors.white,
             expandedHeight: 280.0,
             floating: false,
             pinned: true,
             leading: Container(),
             flexibleSpace: FlexibleSpaceBar(
               centerTitle: true,
               title: Align(
                 alignment: Alignment.bottomLeft,
                 child: Text(
                   "    My Bookings",
                   style: TextStyle(
                     color: Colors.redAccent,
                     fontSize: 25.0,
                     fontFamily: 'Lato',
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
               //"https://www.connect5000.com/wp-content/uploads/2016/07/blog-pic-117-1.jpeg",
               background: Column(
                 children: <Widget>[
                   Stack(
                     children: [
                       Image.network(
                         "https://www.connect5000.com/wp-content/uploads/2016/07/blog-pic-117-1.jpeg",
                         fit: BoxFit.cover,
                         // color: Colors.blue,
                         colorBlendMode: BlendMode.hue,
                       ),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(16.0, 11.0,100.0, 0.0),
                         child: Container(
                           height: 36.0,
                           width: double.infinity,
                           child: CupertinoTextField(
                             onChanged: (text){
                               setState(() {
                                 // dummyData = filterdata
                                 //     .where((u) => (u.doctorName
                                 //     .toLowerCase()
                                 //     .contains(text.toLowerCase()) ||
                                 //     u.patientMobile
                                 //         .toLowerCase().contains(text.toLowerCase())))
                                 //     .toList();
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
                               padding:
                               const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
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
            return Column(
              children: [
                ListTile(
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
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                )
              ],
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
  void choiceAction(String choice){
    if(choice == ConstantsD.Profile){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProfileScreen(widget.id,widget.mobile),
        ),
      );
    }else if(choice == ConstantsD.Settings){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DoctorSettings(widget.id,widget.mobile),
        ),
      );
    }
  }
}
