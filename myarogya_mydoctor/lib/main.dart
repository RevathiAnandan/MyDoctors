import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/improvement/addhospitals.dart';
import 'package:myarogya_mydoctor/improvement/bookdetailed.dart';
import 'package:myarogya_mydoctor/pages/Doctor/createPrecription.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_dashboard.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_new_dashboard.dart';
import 'package:myarogya_mydoctor/pages/Doctor/edit_profile_doctor.dart';
import 'package:myarogya_mydoctor/pages/Doctor/update_profile_screen.dart';
import 'package:myarogya_mydoctor/pages/Hospital/HospitalDashboard.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_dashboard.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_new_dashboard.dart';
import 'package:myarogya_mydoctor/pages/patient/showPrecription.dart';
import 'package:myarogya_mydoctor/pages/selection_screen.dart';
import 'package:myarogya_mydoctor/pages/settings/myincome.dart';
import 'package:myarogya_mydoctor/pages/splash_screen.dart';
import 'package:myarogya_mydoctor/test.dart';

import 'improvement/new.dart';

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
          pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
        ),
        debugShowCheckedModeBanner: false,
        // home: MyIncomePage("Income Settings","+919444773937"),
      // home: Bookdetailed("Revathi"),
      //   home: SplashScreen()
//        home: AddHospital(),
//      home: PatientNewDashboard("0BPnrwIHQDR0ABiYiaIFc1IaSX83","+917810081326")
         home: DoctorNewDashboard("2T2HZP3UWJTfMjzr4TbT7hhE9qz1","+919444773937")
//      home: HospitalDashboard("2T2HZP3UWJTfMjzr4TbT7hhE9qz1","+919444773937")
    );
  }
}

