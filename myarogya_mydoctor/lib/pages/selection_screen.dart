import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_new_dashboard.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:myarogya_mydoctor/utils/sharedPrefUtil.dart';

import 'Doctor/doctor_new_dashboard.dart';
import 'Hospital/HospitalDashboard.dart';

class SelectionScreen extends StatefulWidget {
  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String uid;
  String fcmToken;
  @override
  initState()  {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
      child: MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child:  Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/vector_bg(1).png"), fit: BoxFit.cover)),
                child: new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 100),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Select Who You Are?', style: TextStyle(color:new Color(0xff323F4B), fontSize: 32, fontWeight: FontWeight.w700,fontFamily: "Lato"))
                      ),
                      SizedBox(height: 100),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        constraints: const BoxConstraints(
                            maxWidth: 500
                        ),
                        child:Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text("DOCTOR",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14)),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.redAccent)
                            ),
                            padding: EdgeInsets.all(16),
                            onPressed: () async{
                              SharedPrefUtil().storeString(ConstantUtils().Category, ConstantUtils().Doctor);
                              final FirebaseUser user = await _auth.currentUser();
                              final uid = user.uid.toString();
                              final usermobile = user.phoneNumber.toString();
                              final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
                              _firebaseMessaging.getToken().then((token) =>fcmToken = token);
                              ApiService().createUser(uid,usermobile,ConstantUtils().Doctor,fcmToken);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DoctorNewDashboard(uid,usermobile)),
                              );
                            },
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        constraints: const BoxConstraints(
                            maxWidth: 500
                        ),
                        child:Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text("PATIENT",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14)),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.redAccent)
                            ),
                            padding: EdgeInsets.all(16),
                            onPressed: () async{
                              SharedPrefUtil().storeString(ConstantUtils().Category, ConstantUtils().Patient);
                              final FirebaseUser user = await _auth.currentUser();
                              final uid = user.uid.toString();
                              final usermobile = user.phoneNumber.toString();
                              final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
                              _firebaseMessaging.getToken().then((token) =>fcmToken = token);
                              ApiService().createUser(uid,usermobile,ConstantUtils().Patient,fcmToken);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PatientNewDashboard(uid,usermobile)),
                              );
                            },
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        constraints: const BoxConstraints(
                            maxWidth: 500
                        ),
                        child:Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text("MY HOSPITALS",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14)),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.redAccent)
                            ),
                            padding: EdgeInsets.all(16),
                            onPressed: () async{
                              SharedPrefUtil().storeString(ConstantUtils().Category, ConstantUtils().Hospital);
                              final FirebaseUser user = await _auth.currentUser();
                              final uid = user.uid.toString();
                              final usermobile = user.phoneNumber.toString();
//                        final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//                        _firebaseMessaging.getToken().then((token) =>fcmToken = token);
                              final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
                              _firebaseMessaging.getToken().then((token) =>fcmToken = token);
                              ApiService().createUser(uid,usermobile,ConstantUtils().Hospital,fcmToken);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HospitalDashboard(uid,usermobile)),
                              );
                            },
                            color: Colors.redAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }

}
