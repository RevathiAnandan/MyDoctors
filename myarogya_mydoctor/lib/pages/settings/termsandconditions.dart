import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Termsandconditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text("Terms and conditions:",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  SizedBox(
                    height:10,
                  ),
                  Text("""
About
My Arogya and My Doctor (MAMD) gives technological platform to connect a user with doctors, hospital, labs, medical stores, insurance companies and each other through supporters or leaders.
The terms given here supports people to connect with one of the essential services in need with the help of this app.

My Doctor - Patient:
About:
Anyone can add phone number of Doctor and doctor need to confirm your booking, after confirmation only user data will be shared to Doctor. Doctor can write prescription, and which can be seen by Patient on his app. Prescription is not modifiable and stored on server. Patient can share his prescription to medical stores, hospital or lab, etc. Patient can also share your prescription to your dietician to improve upon the daily routine habit of the eating and its effect. 
Even if because of app software glitch, you missed accepting the terms and condition, it is understood that if you add doctor number and take prescription from the doctor, you have read and accepted the terms and conditions of the usage of the app.
Charges:
Rs.1 per prescription will be the charge to the patient, but payable on voluntary basis, to cover the cost of maintenance of the app. 
Database:
We will not be selling any personal data such as phone numbers, name, age, gender, etc under user profile.
We provide space to add your preferred doctor and prescription. This is where you can use the electronic medium to store and retrieve information in case the need arose. The medium is useful when you are away from your home location and need consultation from doctor. 
User can then share the data to any other and the app will not be able to trace the trail.
My Hospital:
About:
Anyone can book hospital services by clicking on book button. Hospital will be intimated about your booking and after confirmations only your booking is confirmed.  
Here, this app is just providing facility to book hospital service, which is just a service to book and do not take responsibility of the medical services provided by the hospital.  The hospital management is responsible to provide their medical services. 
App will mention the ratings as per hospital facilities and not as per services.
The service ratings will be provided by the user of the services. 
You can able to see available beds, pathology services and medical checkup packages, where you can able to book the services and beds at any given point of time.
You can also able to book OPD in the hospital.
There are concession beds and 100% free beds services enforced by the different state governments in the private hospitals, we tried to put that facilities here in the app with available number of beds.
The responsibility to provide the correct number of free beds lies with the hospital management.
Charges:
There will be per bed booking charge to the hospital by the app as a lead generation and not for the services or for the facilities of the hospital.

Database:
We will not be selling any personal data such as phone numbers, name, age, gender, etc under user profile.
We provide space to add hospital on this app platform. This is where you can use the electronic medium to store and retrieve information in case the need arose. 
User can then share the data to any other and the app will not be able to trace the trail.
Data is being saved on the central server and app is not using it for any purpose unless and until it is being shared by the user only.
There can be delay in display in data load due to network connectivity and facility used by the app currently.
Even if because of app software glitch, you missed accepting the terms and condition, it is understood that if you add doctor number and take prescription from the doctor, you have read and accepted the terms and conditions of the usage of the app.

Intellectual Property rights:
This apps IP rights belong to Mr. Ranjan Gupta as of now and not shareable to anyone. Copying and distribution of the app codes and features will be dealt as per IP rights laws."""),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
