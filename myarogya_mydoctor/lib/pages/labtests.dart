import 'package:flutter/material.dart';



class Labtests extends StatefulWidget {
  String labtext;
  Labtests(this.labtext);
  @override
  _LabtestsState createState() => _LabtestsState();
}

class _LabtestsState extends State<Labtests> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        child:Column(
          children: [
            Text("${widget.labtext}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),
          ],
        )

    );;
  }
}
