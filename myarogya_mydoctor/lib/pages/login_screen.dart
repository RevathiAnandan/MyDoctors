
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/otp_screen.dart';
import 'package:myarogya_mydoctor/services/authService.dart';

import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  String verficationId;
  FirebaseUser user;
  bool codeSent = false;
  bool receiveCode = false;
  //Place A
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.only(left:30.0,right: 30.0,top: 10.0,bottom: 10.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo123.png',height: 180,width: 350),
                SizedBox(height: 10,),
                Text("Enter Mobile Number", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal,fontFamily: "Lacto"),),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: new Icon(Icons.phone_android,color: Colors.redAccent),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.redAccent)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.redAccent)
                      ),
                      filled: true,

                      fillColor: Colors.grey[100],
                      hintText: "+91 xxxxxxxxx"
                  ),
                  controller: _phoneController,
                ),
                SizedBox(height: 16,),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text("Continue",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14)),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.redAccent)
                    ),
                    padding: EdgeInsets.all(16),
                    onPressed: (){
                      registerUser(_phoneController.text, context);
                    },
                    color: Colors.redAccent,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Future registerUser(String mobile, BuildContext context) async{

    FirebaseAuth _auth = FirebaseAuth.instance;

    final PhoneVerificationCompleted verified = (AuthCredential authResult){

      setState(() {
        receiveCode = true;
      });
//      AuthService().signIn(authResult).then((AuthResult value){
              print('${authResult.toString()}');
//      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpScreen(authResult,mobile)),
      );

    };
    final PhoneVerificationFailed verificationfailed = (AuthException authException){
      print('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]){
      this.verficationId = verId;
      setState((){
        codeSent = true;
      });
      print('${verId.toString()}');
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout =(String verId){
      this.verficationId = verId;
    };

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: null
    );
//    if( receiveCode == true) {
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => OtpScreen()),
//      );
//    }
  }

}


