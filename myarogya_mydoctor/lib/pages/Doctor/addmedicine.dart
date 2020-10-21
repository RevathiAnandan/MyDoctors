import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddMedicine extends StatefulWidget {
  String medicine,dos1,dos2,dos3,totaldays,taken;

  AddMedicine(this.medicine,this.dos1,this.dos2,this.dos3,this.totaldays,this.taken);
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.only(left: 18,right: 18),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.medicine}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),
              Text("${widget.dos1}-${widget.dos2}-${widget.dos3}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),
              Text("${widget.totaldays}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),
              Text("${widget.taken}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),
              ],
          )

    );
  }
}
