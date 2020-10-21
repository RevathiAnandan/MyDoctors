import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/pages/newdoctor.dart';
import 'package:myarogya_mydoctor/pages/patient/ListDetails.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
class NavDrawer extends StatefulWidget {

  final String mobile;
  final String name;

  NavDrawer(this.mobile,this.name);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          padding: EdgeInsets.only(left:20.0,right: 20.0,top: 10.0,bottom: 10.0),
          color: Colors.redAccent,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: ()=>Navigator.pop(context),
                          child: Image.asset('assets/images/cancel.png')),
//                  Image.asset('assets/images/user_profile.png')
                    ],
                  ),
                ],
              ),
              Center(
                child: Container(
                  height: 200,
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          //todo: getimage fucntion should be added
                        },
                        child: new CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/user_profile.png'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text((widget.name== null)? "Hi" :"Hi"+widget.name, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold,fontFamily: "Lacto"),),
                      SizedBox(height: 10,),
                      Text(widget.mobile, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal,fontFamily: "Lacto"),),
                    ],
                  ),
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
                width: 200,
                child: FlatButton(
                  child: Text("QR CODE",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14,fontWeight:FontWeight.bold)),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: new Color(0xffFF8976))
                  ),
                  padding: EdgeInsets.all(16),
                  onPressed: ()async {
                    String codeScanner = await BarcodeScanner.scan();    //barcode scanner
                    //setState(() {
                    //TODO: To display the Doctors profile after scanning barcode
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>NewDoctorScreen(codeScanner, widget.mobile),
                    //   ),);
                    //});

                    // try{
                    //   BarcodeScanner.scan()    this method is used to scan the QR code
                    // }catch (e){
                    //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
                    //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
                    // }
                  },
                  color: new Color(0xffFF8976),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
