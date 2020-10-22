import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/Doctor/createPrecription.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_dashboard.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_new_dashboard.dart';
import 'package:myarogya_mydoctor/pages/Doctor/update_profile_screen.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_dashboard.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_new_dashboard.dart';
import 'package:myarogya_mydoctor/pages/patient/showPrecription.dart';
import 'package:myarogya_mydoctor/pages/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "My Arogya My Doctor",
        theme: new ThemeData(
          primaryColor: Colors.redAccent,
          accentColor: Colors.redAccent,
        ),
        debugShowCheckedModeBanner: false,
        //home: SplashScreen()
//      home: CreatePrescription()
       //home: PatientNewDashboard("2T2HZP3UWJTfMjzr4TbT7hhE9qz1","+919444773937")
        home: DoctorNewDashboard("n0ArBCBcZDO64cjnqenp9f39zvr2","+918610905528")
//       home: ProfileScreen("n0ArBCBcZDO64cjnqenp9f39zvr2","+918610905528")
    );
  }
}

