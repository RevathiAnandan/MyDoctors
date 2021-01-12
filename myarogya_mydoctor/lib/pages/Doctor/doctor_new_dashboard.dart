import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:myarogya_mydoctor/improvement/hospitals.dart';
import 'package:myarogya_mydoctor/pages/Ads/home_page.dart';
import 'package:myarogya_mydoctor/pages/Doctor/Appointments.dart';
import 'package:myarogya_mydoctor/pages/complains/DisplayComplains.dart';
import 'package:myarogya_mydoctor/pages/dashboard_screen.dart';

import 'package:myarogya_mydoctor/pages/patient/NavDrawer.dart';

import 'package:myarogya_mydoctor/pages/Doctor/update_profile_screen.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/services/datasearch.dart';
class DoctorNewDashboard extends StatefulWidget {
  final String id;
  final String mobile;
  final String category;
  DoctorNewDashboard(this.id,this.mobile,this.category);
  @override
  _DoctorNewDashboardState createState() => _DoctorNewDashboardState();
}

class _DoctorNewDashboardState extends State<DoctorNewDashboard> {
  int selectedIndex = 0;


  List<Widget> _widgetOptions() => [
    Appointments(widget.mobile,widget.id),
    Hospitals(widget.mobile,widget.id,widget.category),
    HomeScreen(widget.id,widget.mobile),
    DisplayComplains(widget.id,widget.mobile)
  ];
 final widgetName = [
   Text('My Appointments'),
   Text('My Hospitals'),
   Text('My Ads'),
  Text('My Complains'),
 ];

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
              type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(
              color: Colors.red,
              size: 30
            ),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.local_hospital,color: Colors.redAccent,), title: Text('Appointment')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.hotel,color: Colors.redAccent,), title: Text('My Hospital')),
//              BottomNavigationBarItem(icon: Icon(Icons.local_pharmacy,color: Colors.redAccent,), title: Text('My Labs')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list,color: Colors.redAccent,), title: Text('My Ads')),
             BottomNavigationBarItem(
                 icon: Icon(Icons.add_comment,color: Colors.redAccent,size: 25,), title: Text('My Complains'))
            ],
            currentIndex: selectedIndex,
            fixedColor: Colors.redAccent,
            onTap: onItemTapped
          ),
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

}
