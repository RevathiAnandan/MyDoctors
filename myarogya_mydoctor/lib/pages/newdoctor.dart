import 'package:barcode_scan/barcode_scan.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/DoctorUser.dart';
import 'package:myarogya_mydoctor/pages/patient/patient_dashboard.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:permission_handler/permission_handler.dart';


// ignore: must_be_immutable
class NewDoctorScreen extends StatefulWidget {
   final  scancode;
   String  mobile;
  NewDoctorScreen(this.scancode,this.mobile);
  @override
  _NewDoctorScreenState createState() => _NewDoctorScreenState();
}

class _NewDoctorScreenState extends State<NewDoctorScreen> with SingleTickerProviderStateMixin{

  // TextEditingController _doctorId = new TextEditingController();
  // TextEditingController _hospitalName = new TextEditingController();
  // TextEditingController _specialist = new TextEditingController();
  // TextEditingController _degree = new TextEditingController();
  // TextEditingController _dName = new TextEditingController();
  // TextEditingController _email = new TextEditingController();

  FirebaseDatabase fb = FirebaseDatabase.instance;
  final _formKey = GlobalKey<FormState>();
  DoctorUser duser;
  bool validate(value){
    if(value.isEmpty){
      return false;
    }else{
      return true;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  duser = ApiService().getUserDetails(widget.scancode);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Doctor Details',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            new Container(
              child: Text(widget.scancode),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      height: MediaQuery.of(context).size.height * 70 / 100,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Text("Professional Details",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Lato",
                                  color: Colors.redAccent)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Doctor Register Id",
                              style: new TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Lato")),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 5.0),
                                prefixIcon: new Icon(Icons.person,
                                    color: Colors.redAccent,),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: ""),
                            //controller: _doctorId,
                            //initialValue: duser.registerId,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Hospital name",
                              style: new TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Lato")),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: new Icon(Icons.business,
                                    color: new Color(0xffACCCF8)),
                                contentPadding: EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 5.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: ""),
                            // controller: _hospitalName,
                            //initialValue: duser.hospitalName,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Specialist",
                              style: new TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Lato")),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 5.0),
                                prefixIcon: new Icon(
                                    Icons.business_center,
                                    color: Colors.redAccent,),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: ""),
                            //controller: _specialist,
                            //initialValue: duser.specialist,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Degree",
                              style: new TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Lato")),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 5.0),
                                prefixIcon: new Icon(
                                    Icons.library_books,
                                    color: Colors.redAccent,),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: ""),
                            //controller: _degree,
                            //initialValue: duser.degree,
                          ),
                          Text("Personal Details",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Lato",
                                  color: Colors.redAccent)),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Name",
                              style: new TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Lato")),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 5.0),
                                prefixIcon: new Icon(Icons.person,
                                    color: Colors.redAccent,),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: "Dr."),
                            //controller: _dName,
                            //initialValue: duser.Name.isNotEmpty ? duser.Name : "No data",
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Mobile Number",
                              style: new TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Lato")),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  prefixIcon: new Icon(
                                      Icons.phone_android,
                                      color: Colors.redAccent,),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 5.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.redAccent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.redAccent)),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  hintText: ""),
                              autofocus: false,
                              initialValue: widget.mobile
                            ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Email",
                              style: new TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Lato")),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                    20.0, 5.0, 20.0, 5.0),
                                prefixIcon: new Icon(Icons.email,
                                    color: Colors.redAccent,),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.redAccent)),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: ""),
                            //controller: _email,

                            //initialValue: duser.emailId,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: FlatButton(
                child: Text("CREATE",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Lato",
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(25.0),
                    side: BorderSide(
                        color: Colors.redAccent)),
                padding: EdgeInsets.all(16),
                onPressed: () {
                addDoctor(duser.Name, widget.scancode);
                },
                color: new Color(0xff2F80ED),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addDoctor(String name , String phone)async {
    final PermissionStatus permission = await Permission.contacts.status;
    if(permission == PermissionStatus.granted){
      Contact newContact = new Contact();
      newContact.givenName = name;
      newContact.phones = [
        Item(label: "mobile", value:phone)
      ];
      await ContactsService.addContact(newContact);
      checkmobile(name,phone);
      Navigator.of(context).pop();

    }
  }
  // Future<String> createAlertDialog(BuildContext context){
  //   return showDialog(context: context,
  //       builder: (context){
  //         return AlertDialog(
  //           content: Stack(
  //             overflow: Overflow.visible,
  //             children: <Widget>[
  //               Positioned(
  //                 right: -40.0,
  //                 top: -40.0,
  //                 child: InkResponse(
  //                   onTap: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: CircleAvatar(
  //                     child: Icon(Icons.close),
  //                     backgroundColor: Colors.red,
  //                   ),
  //                 ),
  //               ),
  //               Form(
  //                 key: _formKey,
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     Padding(
  //                       padding: EdgeInsets.all(8.0),
  //                       child: TextFormField(),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.all(8.0),
  //                       child: TextFormField(),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: RaisedButton(
  //                         child: Text("Add Contact"),
  //                         onPressed: () {
  //                           if (_formKey.currentState.validate()) {
  //                             _formKey.currentState.save();
  //                           }
  //                         },
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  checkmobile(String pname,String phone){
    var db = fb.reference().child("User");
    db.once().then((DataSnapshot snapshot){
//      print("snapshot${snapshot.value}");
//       ApiService().addPatientToDoctor(widget.mobile,phone,dname);
      ApiService().addDoctorToPatient(widget.mobile,phone,pname);
      Map<dynamic, dynamic > values = snapshot.value;
      values.forEach((key,values) {
//        print(values);
//        if(key == pname) {
        var refreshToken = values;
        print(refreshToken);

//        }else{
//          //Sent an Invite to  this number to install the app.
//
//        }
      });
    });
  }
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

}
