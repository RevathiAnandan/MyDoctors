import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:myarogya_mydoctor/improvement/hospitals.dart';
import 'package:myarogya_mydoctor/pages/Doctor/Appointments.dart';
import 'package:myarogya_mydoctor/pages/dashboard_screen.dart';

import 'package:myarogya_mydoctor/pages/patient/NavDrawer.dart';

import 'package:myarogya_mydoctor/pages/Doctor/update_profile_screen.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/services/datasearch.dart';
class DoctorNewDashboard extends StatefulWidget {
  String id;
  String mobile;
  DoctorNewDashboard(this.id,this.mobile);
  @override
  _DoctorNewDashboardState createState() => _DoctorNewDashboardState();
}

class _DoctorNewDashboardState extends State<DoctorNewDashboard> {
  int selectedIndex = 0;


  List<Widget> _widgetOptions() => [
    Appointments(widget.mobile,widget.id),
    Hospitals(),
//    Text('My Labs'),
    Text('My Ads'),
    GestureDetector(
      onTap:() {
        AuthService().signOut(context);
        },
        child:Text('Setting'),
    ),
  ];
 final widgetName = [
   Text('My Appointments'),
   Text('My Hospitals'),
//   Text('My Labs'),
   Text('My Ads'),
   Text('Settings'),
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
            selectedIconTheme: IconThemeData(
              color: Colors.red,
              size: 30
            ),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.local_hospital,color: Colors.redAccent,), title: Text('MyAppointment')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.hotel,color: Colors.redAccent,), title: Text('My Hospital')),
//              BottomNavigationBarItem(icon: Icon(Icons.local_pharmacy,color: Colors.redAccent,), title: Text('My Labs')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list,color: Colors.redAccent,), title: Text('My Ads')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings,color: Colors.redAccent,size: 25,), title: Text('Settings'))
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
