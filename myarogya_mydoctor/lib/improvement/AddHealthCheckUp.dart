import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddHealthCheckUp extends StatefulWidget {
  String packageName,Amt;

  AddHealthCheckUp(this.packageName,this.Amt);
  @override
  _AddHealthCheckUpState createState() => _AddHealthCheckUpState();
}

class _AddHealthCheckUpState extends State<AddHealthCheckUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 18,right: 18),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(" ${widget.packageName}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),

            Text("${widget.Amt}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),

          ],
        )

    );
  }
}
