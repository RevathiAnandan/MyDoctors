import 'dart:async';

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
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/vector_bg.png"), fit: BoxFit.cover)),
        child: new Center(
            child: Image.asset('assets/images/logo.png',height: 300,width: 300)
        ),
//      child: Image.asset('assets/images/logo.png',height: 300,width: 300),
          ),
        ),
      )
    );
  }
}
