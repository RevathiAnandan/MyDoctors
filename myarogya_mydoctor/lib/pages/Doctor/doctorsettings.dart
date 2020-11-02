import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/services/authService.dart';

class DoctorSettings extends StatefulWidget {
  @override
  _DoctorSettingsState createState() => _DoctorSettingsState();
}

class _DoctorSettingsState extends State<DoctorSettings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.person,size: 30,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.monetization_on_outlined,size: 30,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "My Income",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.pan_tool,size: 30,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "My Holdings",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.privacy_tip_outlined,size: 30,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Privacy",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.note_rounded,size: 30,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.local_offer,size: 30,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Disclaimer",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: (){
                    AuthService().signOut(context);
                  },
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.logout,size: 30,),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Log Out",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
