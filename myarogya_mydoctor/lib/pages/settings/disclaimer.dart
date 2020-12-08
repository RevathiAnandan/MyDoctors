import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Disclaimers:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                SizedBox(
                  height:10,
                ),
                Text("""Anyone can add phone number of Doctor and doctor need to confirm your booking, after confirmation only user data will be shared to Doctor. Doctor can write prescription, and which can be seen by Patient on his app.
                  Even if because of app software glitch, you missed accepting the terms and condition, it is understood that if you add doctor number and take prescription from the doctor, you have read and accepted the terms and conditions of the usage of the app.
                  User can then share the data to any other and the app will not be able to trace the trail.
                  Here, this app is just providing facility to book hospital service, which is just a service to book and do not take responsibility of the medical services provided by the hospital.  The hospital management is responsible to provide their medical services.
                  App will mention the ratings as per hospital facilities and not as per services.
                  The service ratings will be provided by the user of the services.
                  The responsibility to provide the correct number of free beds lies with the hospital management.
                  Data is being saved on the central server and app is not using it for any purpose unless and until it is being shared by the user only.
                  There can be delay in display in data load due to network connectivity and facility used by the app currently."""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
