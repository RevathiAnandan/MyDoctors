import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Privacy:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                SizedBox(
                  height:10,
                ),
                Text("""
Collection of information:
This app collects information such as phone numbers, name, age, gender, etc under user profile, which can be used for analysis purpose 

Sharing of information:
Collected information shared for the purpose of improving better supply chain and support to the prospective users benefit. Sharing of information is done for various types of choices and preference of the doctor or hospital. Diagnosis, medication, tests, health packages and type of hospital.
This information will be shared only for the purpose of improving the benefits and better health care services and not otherwise.

User data will be available forever since these are important and basic information’s. 

To prevent breach of privacy we are not inserting any advertisements in the user database. Ads, if any will be displayed in separate tab called “My ads”."""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
