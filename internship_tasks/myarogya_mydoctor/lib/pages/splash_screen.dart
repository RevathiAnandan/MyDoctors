import 'dart:async';

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
//      home: Container(
//          decoration: BoxDecoration(
//              image: DecorationImage(
//                  image: AssetImage("assets/images/Home.png"), fit: BoxFit.cover)),
      home: Scaffold(
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
        // image: DecorationImage(
        // image: AssetImage("assets/images/vector_bg.png"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('MY Arogya My Doctor',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900, fontFamily: 'Lato'),),
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
//      child: Image.asset('assets/images/logo.png',height: 300,width: 300),
          ),
        ),
      )
    );
  }
}
