import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddDiagnosisCharged extends StatefulWidget {
  String testDescription,OPD;

  AddDiagnosisCharged(this.testDescription,this.OPD);
  @override
  _AddDiagnosisChargedState createState() => _AddDiagnosisChargedState();
}

class _AddDiagnosisChargedState extends State<AddDiagnosisCharged> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 18,right: 18),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(" ${widget.testDescription}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),

            Text("${widget.OPD}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),

            ],
        )

    );
  }
}



class AddInsurance extends StatefulWidget {
  String insuranceName;

  AddInsurance(this.insuranceName);
  @override
  _AddInsuranceState createState() => _AddInsuranceState();
}

class _AddInsuranceState extends State<AddInsurance> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 18,right: 18),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Insurance Name:  ${widget.insuranceName}",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",fontSize: 14)),

          ],
        )

    );
  }
}

