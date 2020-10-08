import 'package:flutter/material.dart';

class PersonalDetails extends StatefulWidget {
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left:20.0,right: 20.0,top: 10.0,bottom: 10.0),
        children: <Widget>[
          Text("Name",style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: "Lato")),
          SizedBox(height: 5,),
          TextFormField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                prefixIcon: new Icon(Icons.person,color: new Color(0xffACCCF8)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.blueAccent)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.blueAccent)
                ),
                filled: true, fillColor: Colors.grey[100],
                hintText: ""
            ),
//            controller: _phoneController,
          ),
          SizedBox(height: 5,),
          Text("Mobile Number",style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: "Lato")),
          SizedBox(height: 5,),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: new Icon(Icons.phone_android,color: new Color(0xffACCCF8)),
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.blueAccent)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.blueAccent)
                ),
                filled: true, fillColor: Colors.grey[100],
                hintText: ""
            ),
//            controller: _phoneController,
          ),
          SizedBox(height: 5,),
          Text("Email",style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: "Lato")),
          SizedBox(height: 5,),
          TextFormField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                prefixIcon: new Icon(Icons.email,color: new Color(0xffACCCF8)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.blueAccent)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.blueAccent)
                ),
                filled: true, fillColor: Colors.grey[100],
                hintText: ""
            ),
//            controller: _phoneController,
          ),
          SizedBox(height: 25,),
          Container(
            width: double.infinity,
            child: FlatButton(
              child: Text("CREATE",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14,fontWeight:FontWeight.bold )),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: Colors.blueAccent)
              ),
              padding: EdgeInsets.all(16),
              onPressed: (){
              },
              color: new Color(0xff2F80ED),
            ),
          )
        ],
      ),
    );
  }
}
