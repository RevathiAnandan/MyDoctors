import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/dashboard_screen.dart';
import 'package:myarogya_mydoctor/pages/selection_screen.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
import 'package:myarogya_mydoctor/utils/sharedPrefUtil.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class OtpScreen extends StatefulWidget {
  final AuthCredential creds;
  String mobile;

  OtpScreen(this.creds,this.mobile);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String text = '';
  bool _isButtonDisabled= false;
  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }
  // ignore: missing_return
  bool _buttonDisable(){
    setState ( () {
      _isButtonDisabled = true;
      return _isButtonDisabled;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        body:Container(
//          child: new Column(
//            children: [
//              new Text("Welcome",style: TextStyle(color: Colors.black,fontFamily: "Lato",fontSize: 32),),
//              new Text("Enter the 4-digit code which is just sent to your Registered Mobile Number",style: TextStyle(color: Colors.grey,fontSize:14 ),),
//              Container(
//                constraints: const BoxConstraints(
//                    maxWidth: 500
//                ),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    otpNumberWidget(0),
//                    otpNumberWidget(1),
//                    otpNumberWidget(2),
//                    otpNumberWidget(3),
//                    otpNumberWidget(4),
//                    otpNumberWidget(5),
//                  ],
//                ),
//
//              ),
//              Container(
//                width: double.infinity,
//                child: FlatButton(
//                  child: Text("Continue",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14)),
//                  textColor: Colors.white,
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(25.0),
//                      side: BorderSide(color: Colors.blueAccent)
//                  ),
//                  padding: EdgeInsets.all(16),
//                  onPressed: (){
//                  },
//                  color: Colors.blue,
//                ),
//              ),
//              NumericKeyboard(
//                onKeyboardTap: _onKeyboardTap,
//                textColor: Colors.white,
//                rightIcon: Icon(
//                  Icons.backspace,
//                  color: Colors.white,
//                ),
//                rightButtonFn: () {
//                  setState(() {
//                    text = text.substring(0, text.length - 1);
//                  });
//                },
//              )
//            ],
//          ),
//        )
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: 400,
                      height: 500,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                          ),
                           Align(
                             alignment: Alignment.centerLeft,
                             child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text('Welcome', style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.w900,fontFamily: "Lato"))
                          ),
                           ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Text(
                                        'Enter 6 digits verification code sent to your            ',
                                        style: TextStyle(color: Colors.grey, fontSize: 18, fontFamily: "Lato")),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.mobile,
                                          style: TextStyle(color: Colors.grey, fontSize: 18, fontFamily: "Lato")
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            constraints: const BoxConstraints(
                                maxWidth: 500
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                otpNumberWidget(0),
                                otpNumberWidget(1),
                                otpNumberWidget(2),
                                otpNumberWidget(3),
                                otpNumberWidget(4),
                                otpNumberWidget(5),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Didn’t receive the code?', style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: "Lato")),
                              InkWell(
                                onTap: (){
                                  AuthService().signIn(widget.creds);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SelectionScreen()),
                                  );
                                },
                                  child: Text('  Resend!', style: TextStyle(color: Colors.blueAccent, fontSize: 14,fontWeight: FontWeight.w400, fontFamily: "Lato"))),
                            ],
                          ),
                        ],
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
                        child: Text("Verify",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14)),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.blueAccent)
                        ),
                        padding: EdgeInsets.all(16),
                        //todo: Check again here
                        onPressed: _isButtonDisabled ? null : (){
                          AuthService().signIn(widget.creds);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SelectionScreen()),
                          );
                          _buttonDisable();
                        },
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    textColor: Colors.black,
                    rightIcon: Icon(
                      Icons.backspace,
                      color:Colors.black,
                    ),
                    rightButtonFn: () {
                      setState(() {
                        text = text.substring(0, text.length - 1);
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
            border: Border.all(color: Colors.blueAccent, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(text[position], style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500),)),
      );
    } catch (e) {
      return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            border: Border.all(color: Colors.blueAccent, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
      );
    }
  }
}

