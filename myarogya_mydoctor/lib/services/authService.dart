import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_dashboard.dart';
import 'package:myarogya_mydoctor/pages/Doctor/doctor_new_dashboard.dart';
import 'package:myarogya_mydoctor/pages/Doctor/update_profile_screen.dart';
import 'package:myarogya_mydoctor/pages/dashboard_screen.dart';
import 'package:myarogya_mydoctor/pages/login_screen.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_dashboard.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_new_dashboard.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:myarogya_mydoctor/utils/sharedPrefUtil.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'push_notification_service1.dart';

class AuthService{
  // final PushNotificationService _pns = PushNotificationService();
  AuthCredential creds;

  //Handle Auth
  Widget handleAuth() {
    print("HArun");
    // await _pns.initialise();
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context,snapshot){
        print(snapshot.data);
        if(snapshot.hasError){
          return Scaffold(body: Center(child: Text("Something went wrong"),),);
        }else if(snapshot.connectionState==ConnectionState.waiting) {
          return Scaffold(body: Center(child:CircularProgressIndicator()),);
        }else if(snapshot.hasData){
          return checkLogin(context);
        }else{
          return LoginScreen();
        }
      },
    );
  }

  getcategory() async{
    final User user = await _auth.currentUser;
    final uid = user.uid.toString();
    final usermobile = user.phoneNumber.toString();
    if( SharedPrefUtil().readPrefStr(ConstantUtils().Category) == ConstantUtils().Doctor){
      return DoctorNewDashboard(uid,usermobile);
    }else{
      return PatientNewDashboard(uid,usermobile);
    }
  }

  //Signout
  signOut(context) {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LoginScreen(),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  getCurrentUser() async {
    final User user = await _auth.currentUser;
    final uid = user.uid.toString();
    final usermobile = user.phoneNumber.toString();
    SharedPrefUtil().storeString(ConstantUtils().UserID, uid);
    SharedPrefUtil().storeString(ConstantUtils().Usermobile, usermobile);
    // Similarly we can get email as well
    //final uemail = user.email;
    print(uid+""+usermobile);
    return uid;
    //print(uemail);
  }

  //SignIn
  signIn(AuthCredential authCreds){
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(context,String smscode,String verId){
    AuthCredential authCredential = PhoneAuthProvider.getCredential(verificationId: verId, smsCode: smscode);
    signIn(authCredential);
  }

  checkLogin(BuildContext context) async{
    FirebaseDatabase fb = FirebaseDatabase.instance;
    final User user = await _auth.currentUser;
    final uid = user.uid.toString();
    final mobile = user.phoneNumber.toString();
    if(uid != null){
      var db = fb.reference().child("User").child(mobile).child("category");
      db.once().then((DataSnapshot snapshot){
        print ("snapshot"+snapshot.value);
//      print (db);
        if((snapshot.value) == "Doctor"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DoctorNewDashboard(uid,mobile)),
          );
        }
        else if((snapshot.value) == "Patient"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PatientNewDashboard(uid,mobile)),
          );
        }
      });
    }
  }


  toast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  alertDialog(BuildContext context,String id,String mobile){
    Alert(
        context: context,
        title: "Alert",
        content: Column(
            children: <Widget>[
              Text("Please Update Your Profile for Proceed Further!!")
            ]
        ),
        buttons: [
          DialogButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfileScreen(id,mobile),
                ),
              );
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }


}