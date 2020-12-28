import 'package:flutter/material.dart';
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
  List<Widget> _widgetOptions() => [
    MyBooking(widget.id,widget.mobile),
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: _widgetOptions()[selectedIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedIconTheme: IconThemeData(
                  color: Colors.red,
                  size: 30
              ),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.local_hospital,color: Colors.redAccent,), title: Text('MyBooking')),

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
}
