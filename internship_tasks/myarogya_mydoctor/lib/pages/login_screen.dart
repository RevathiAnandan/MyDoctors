
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left:30.0,right: 30.0,top: 10.0,bottom: 10.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/logo123.png',height: 200,width: 370),
                    SizedBox(height: 50,),
                    Text("Enter Mobile Number", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal,fontFamily: "Lacto"),),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                          //prefixText: "+91",
                          prefixIcon: new Icon(Icons.phone_android,color: Colors.blueAccent),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.blueAccent)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.blueAccent)
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "+91XXXXXXXXXX"
                      ),
                      controller: _phoneController,
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
            Container(
              width: 330,
              height: 60,
              child: FlatButton(
                child: Text("Continue",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 25,)),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    side: BorderSide(color: Colors.blueAccent)
                ),
                padding: EdgeInsets.all(16),
                onPressed: (){
                  registerUser(_phoneController.text, context);
                },
                color: Colors.blue,
              ),
            )
          ],
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


