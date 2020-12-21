import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/services/authService.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                AuthService().handleAuth()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
          child: Scaffold(
            backgroundColor: new Color(0xff1264D1),
            body: Center(
              child:  Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color.fromRGBO(254, 183, 171,1), Color.fromRGBO(172, 204, 248,1)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0,0.5]
                    )
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('My Arogya My Doctor',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900, fontFamily: 'Lato'),),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: 250,
                          child: Text('Schedule your appointment with your doctor or patient in a better way.',style: TextStyle(fontSize: 15, fontFamily: 'Lato'),textAlign: TextAlign.center,)),
                      new Center(
                          child: Image.asset('assets/images/logo123.png',height: 300,width: 300)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
