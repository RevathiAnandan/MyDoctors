import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/selection_screen.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class OtpScreen extends StatefulWidget {
  final AuthCredential creds;
  final String mobile;
  final String verId;

  OtpScreen(this.creds,this.mobile,this.verId);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String text = '';
  bool validate = false;
  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                         Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Welcome', style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w500,fontFamily: "Lato"))
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Enter 6 digits verification code sent to your number', style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: "Lato"))
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
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Didn’t receive the code? Resend', style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: "Lato"))
                        ),
                      ],
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
                            side: BorderSide(color: Colors.redAccent)
                        ),
                        padding: EdgeInsets.all(16),
                        onPressed: (){
                        if (validate == true) {
                          AuthService().signInWithOTP(context,text,widget.verId);
                        } else {
                          AuthService().toast("Please Enter the OTP!!");
                        }
                        },
                        color: Colors.redAccent,
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
      if (position == 5) {
        setState(() {
          validate = true;
        });
      }else{
        setState(() {
          validate = false;
        });
      }
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.redAccent, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(text[position], style: TextStyle(color: Colors.redAccent),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.redAccent, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
  }
}

