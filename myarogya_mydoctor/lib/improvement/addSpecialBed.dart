import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddSpecialBed extends StatefulWidget {
  String roomType,beds,charges;

  AddSpecialBed(this.roomType,this.beds,this.charges);
  @override
  _AddSpecialBedState createState() => _AddSpecialBedState();
}

class _AddSpecialBedState extends State<AddSpecialBed> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 18,right: 18),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Room: ${widget.roomType}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),

            Text("No of beds: ${widget.beds}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),

            Text("Charges per day: ${widget.charges}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),
          ],
        )

    );
  }
}
