import 'package:flutter/material.dart';

class ProfessionalDetails extends StatefulWidget {
  @override
  _ProfessionalDetailsState createState() => _ProfessionalDetailsState();
}

class _ProfessionalDetailsState extends State<ProfessionalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left:20.0,right: 20.0,top: 10.0,bottom: 10.0),
        children: <Widget>[
          Text("Doctor Register Id",style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: "Lato")),
          SizedBox(height: 5,),
          TextFormField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                prefixIcon: new Icon(Icons.person,color: Colors.redAccent,),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.redAccent)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.redAccent)
                ),
                filled: true, fillColor: Colors.grey[100],
                hintText: ""
            ),
//            controller: _phoneController,
          ),
          SizedBox(height: 5,),
          Text("Hospital name",style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: "Lato")),
          SizedBox(height: 5,),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: new Icon(Icons.business,color: Colors.redAccent,),
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.redAccent)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.redAccent)
                ),
                filled: true, fillColor: Colors.grey[100],
                hintText: ""
            ),
//            controller: _phoneController,
          ),
          SizedBox(height: 5,),
          Text("Specialist",style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: "Lato")),
          SizedBox(height: 5,),
          TextFormField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                prefixIcon: new Icon(Icons.business_center,color: Colors.redAccent,),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.redAccent)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.redAccent)
                ),
                filled: true, fillColor: Colors.grey[100],
                hintText: ""
            ),
//            controller: _phoneController,
          ),
          SizedBox(height: 5,),
          Text("Year of Passing",style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: "Lato")),
          SizedBox(height: 5,),
          TextFormField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                prefixIcon: new Icon(Icons.calendar_today,color: Colors.redAccent,),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.redAccent)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.redAccent)
                ),
                filled: true, fillColor: Colors.grey[100],
                hintText: ""
            ),
//            controller: _phoneController,
          ),
        ],
      ),
    );
  }
}
