import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:myarogya_mydoctor/pages/Doctor/Appointments.dart';
import 'package:myarogya_mydoctor/pages/dashboard_screen.dart';

import 'package:myarogya_mydoctor/pages/patient/NavDrawer.dart';

import 'package:myarogya_mydoctor/pages/Doctor/update_profile_screen.dart';
import 'package:myarogya_mydoctor/pages/patient/patientprofile.dart';

import '../chat_screen.dart';
class PatientNewDashboard extends StatefulWidget {
  String id;
  String mobile;
  PatientNewDashboard(this.id,this.mobile);
  @override
  _PatientNewDashboardState createState() => _PatientNewDashboardState();
}

class _PatientNewDashboardState extends State<PatientNewDashboard> {
  int selectedIndex = 0;

  List<Widget> _widgetOptions() => [
    MyScreen(widget.mobile,"MY DOCTOR"),
    Text('My Hospitals'),
    Text('My Labs'),
    Text('My Ads'),
    Text('Setting'),
  ];
  final widgetName = [
    Text('My Doctors'),
    Text('My Hospitals'),
    Text('My Labs'),
    Text('My Ads'),
    Text('Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(

        appBar: GradientAppBar(
          title: widgetName.elementAt(selectedIndex),
          backgroundColorStart: Colors.redAccent,
          backgroundColorEnd: Colors.redAccent,
          actions: [
            IconButton(icon: Icon(Icons.account_circle,color: Colors.white),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatientProfile(widget.id,widget.mobile)),
              );
            },)
          ],
        ),
        body: Center(
          child: _widgetOptions()[selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.people,color: Colors.grey), title: Text('MyDoctor')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.hotel,color: Colors.grey), title: Text('My Hospital')),
              BottomNavigationBarItem(icon: Icon(Icons.local_pharmacy,color: Colors.grey), title: Text('My Labs')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list,color: Colors.grey), title: Text('My Ads')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings,color: Colors.grey), title: Text('Settings'))
            ],
            currentIndex: selectedIndex,
            fixedColor: Colors.grey,
            onTap: onItemTapped
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
