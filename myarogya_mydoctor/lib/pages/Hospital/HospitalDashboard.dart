import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/Hospitals.dart';
import 'package:myarogya_mydoctor/pages/Ads/home_page.dart';
import 'package:myarogya_mydoctor/pages/complains/DisplayComplains.dart';

import 'MyBooking.dart';
class HospitalDashboard extends StatefulWidget {
  String id;
  String mobile;
  HospitalDashboard(this.id,this.mobile);
  @override
  _HospitalDashboardState createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  int selectedIndex = 0;
  List<Hospital> hospitalvalues = [];
  FirebaseDatabase fb = FirebaseDatabase.instance;
  bool isLoading = true;
  List<Widget> _widgetOptions() => [
    MyBooking(widget.id,widget.mobile,hospitalvalues),
    HomeScreen(widget.id,widget.mobile),
    DisplayComplains(widget.id,widget.mobile)
  ];
  final widgetName = [
    Text('My Booking'),
    Text('My Ads'),
    Text('My Complains'),
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gethospital();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: isLoading?Center(child: CircularProgressIndicator()):Center(
            child: _widgetOptions()[selectedIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedIconTheme: IconThemeData(
                  color: Colors.red,
                  size: 30
              ),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.local_hospital,color: Colors.redAccent,), title: Text('My Bookings')),

BottomNavigationBarItem(
                    icon: Icon(Icons.list,color: Colors.redAccent,), title: Text('My Ads')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list,color: Colors.redAccent,), title: Text('My Complains')),
              ],
              currentIndex: selectedIndex,
              fixedColor: Colors.redAccent,
              onTap: onItemTapped
          ),
        ),
      ),
    );
  }
  Future<Hospital> gethospital() async {
    var db = await fb.reference().child("Hospitals");
    print(db);
    try {
      if (db != null) {
        db.once().then((DataSnapshot snapshot) {
          print("Hospitals");
          print(snapshot.value);
          Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key, value) {
            print("Values:: $value");
            var refreshToken = Hospital.fromJson(value);
            if(widget.mobile==refreshToken.bookingPhNo)
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
}
