import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/patient/ListDetails.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
    child: Container(
      padding: EdgeInsets.only(left:20.0,right: 20.0,top: 10.0,bottom: 10.0),
      color: new Color(0xff1264D1),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/cancel.png'),
//                  Image.asset('assets/images/user_profile.png')
                ],
              ),
            ],
          ),
          Center(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/user_profile.png',height: 100,width: 100),
                Text(" Mr. syed ", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.normal,fontFamily: "Lacto"),),
                SizedBox(height: 10,),
                Text("+91 9876543210", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal,fontFamily: "Lacto"),),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text("My Doctors", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,fontFamily: "Lacto"),),
                  leading:  Image.asset('assets/images/mydoctor.png'),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListDetails("MyDoctors"),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text("My Hospitals", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,fontFamily: "Lacto"),),
                  leading:  Image.asset('assets/images/myhospital.png'),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListDetails("MyHospital"),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text("My Labs", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,fontFamily: "Lacto"),),
                  leading:  Image.asset('assets/images/mylabs.png'),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListDetails("MyLabs"),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text("My History", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,fontFamily: "Lacto"),),
                  leading:  Image.asset('assets/images/myhistory.png'),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListDetails("MyHistory"),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text("Logout", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,fontFamily: "Lacto"),),
                  leading:  Image.asset('assets/images/logout.png'),
                  onTap: (){
                    AuthService().signOut(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: FlatButton(
              child: Text("EMERGENCY",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14,fontWeight:FontWeight.bold)),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: new Color(0xffFF8976))
              ),
              padding: EdgeInsets.all(16),
              onPressed: (){
              },
              color: new Color(0xffFF8976),
            ),
          )
        ],
      ),
    ),
    );
  }
}
