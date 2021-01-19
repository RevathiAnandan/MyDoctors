import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myarogya_mydoctor/model/patientUser.dart';
import 'dart:io';

import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';
class PatientProfile extends StatefulWidget {
  String id;
  String mobile;

  PatientProfile(this.id,this.mobile);
  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  File _image;
  String imagelink;
  bool isLoading = false;
  PatientUser refreshToken;
  String chosenvalue2 = "Male";
  TextEditingController _pName = new TextEditingController();
  TextEditingController _age = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _phone = new TextEditingController() ;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.redAccent,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        title: Text('Profile',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.redAccent,
              ),
              onPressed: () {
                updatePatientProfile(_image,_pName.text,_email.text,_age.text,chosenvalue2);
              })
        ],
      ),
      body: new Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                // Container(
                //   height: 120,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     color: Colors.redAccent,
                //     borderRadius: BorderRadius.only(
                //         bottomLeft:Radius.circular(15) ,
                //         bottomRight: Radius.circular(15)
                //     ),
                //   ),
                //   child:Column(
                //     children: [
                //       Row(
                //         children: [
                //           IconButton(
                //             icon:Icon(Icons.arrow_back_ios,color: Colors.white,
                //             ),
                //             onPressed: () {
                //               Navigator.of(context).pop() ;
                //             },
                //           ),                          Expanded(
                //             child: new Column(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               mainAxisSize: MainAxisSize.max,
                //               children: [
                //                 SizedBox(height: 30 ),
                //                 Container(
                //                     child: Text('Hello Patient!', style: TextStyle(color:Colors.white, fontSize: 26, fontWeight: FontWeight.w500,fontFamily: "Lato"))
                //                 ),
                //                 SizedBox(height: 10 ),
                //                 Container(
                //                     child: Text('please fill out the following details to create your profile', style: TextStyle(color: new Color(0xffCBD2D9), fontSize: 14 , fontWeight: FontWeight.w500,fontFamily: "Lato"))
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                //
                // ),
                Container(
                  height: MediaQuery.of(context).size.height * 20/100,
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top:5.0),
                        child: new Stack(fit: StackFit.loose, children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                child: new Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: (_image != null)
                                            ? FileImage(File(_image.path))
                                            :(imagelink != null?
                                        NetworkImage(imagelink)
                                            : new ExactAssetImage(
                                            'assets/images/user_profile.png')),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                onTap: () => getImage(),
                              ),
                            ],
                          ),
                          // Padding(
                          //     padding: EdgeInsets.only(top: 70.0, left: 80.0),
                          //     child: new Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: <Widget>[
                          //         new CircleAvatar(
                          //           backgroundColor: Colors.redAccent,
                          //           radius: 20.0,
                          //           child: new IconButton(
                          //             icon:Icon(Icons.camera_alt),
                          //             color: Colors.white,
                          //             onPressed: (){
                          //               getImage();
                          //             },
                          //           ),
                          //         )
                          //       ],
                          //     )),
                        ]),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: new Container(
                      height: MediaQuery.of(context).size.height * 60/100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Personal Details",style: new TextStyle(fontWeight: FontWeight.bold,fontFamily: "Lato",color: Colors.redAccent)),
                          SizedBox(height: 5,),
                          Text("Name",style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: "Lato")),
                          SizedBox(height: 5,),
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                                prefixIcon: new Icon(Icons.person,color: new Color(0xffACCCF8)),
                                // enabledBorder: OutlineInputBorder(
                                //     borderRadius: BorderRadius.all(Radius.circular(8)),
                                //     borderSide: BorderSide(color: Colors.redAccent)
                                // ),
                                // focusedBorder: OutlineInputBorder(
                                //     borderRadius: BorderRadius.all(Radius.circular(8)),
                                //     borderSide: BorderSide(color: Colors.redAccent)
                                // ),
                                // filled: true, fillColor: Colors.grey[100],
                                // hintText: ""
                            ),
                            controller: _pName,
                          ),
                          SizedBox(height: 5,),
                          Text("Mobile Number",style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: "Lato")),
                          SizedBox(height: 5,),
                          TextFormField(
                            decoration: InputDecoration(

                                prefixIcon: new Icon(Icons.phone_android,color: new Color(0xffACCCF8)),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                                // enabledBorder: OutlineInputBorder(
                                //     borderRadius: BorderRadius.all(Radius.circular(8)),
                                //     borderSide: BorderSide(color: Colors.redAccent)
                                // ),
                                // focusedBorder: OutlineInputBorder(
                                //     borderRadius: BorderRadius.all(Radius.circular(8)),
                                //     borderSide: BorderSide(color: Colors.redAccent)
                                // ),
                                // filled: true, fillColor: Colors.grey[100],
                                // hintText: "",

                            ),
                            autofocus: false,
                            initialValue:widget.mobile ,
                          ),
                          SizedBox(height: 5,),
                          Text("Age",style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: "Lato")),
                          SizedBox(height: 5,),
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                                prefixIcon: new Icon(Icons.email,color: new Color(0xffACCCF8)),
                                // enabledBorder: OutlineInputBorder(
                                //     borderRadius: BorderRadius.all(Radius.circular(8)),
                                //     borderSide: BorderSide(color: Colors.redAccent)
                                // ),
                                // focusedBorder: OutlineInputBorder(
                                //     borderRadius: BorderRadius.all(Radius.circular(8)),
                                //     borderSide: BorderSide(color: Colors.redAccent)
                                // ),
                                // filled: true, fillColor: Colors.grey[100],
                                // hintText: ""
                            ),
                            controller: _age,
                          ),
                          Text("Email",style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: "Lato")),
                          SizedBox(height: 5,),
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                                prefixIcon: new Icon(Icons.email,color: new Color(0xffACCCF8)),
                                // enabledBorder: OutlineInputBorder(
                                //     borderRadius: BorderRadius.all(Radius.circular(8)),
                                //     borderSide: BorderSide(color: Colors.redAccent)
                                // ),
                                // focusedBorder: OutlineInputBorder(
                                //     borderRadius: BorderRadius.all(Radius.circular(8)),
                                //     borderSide: BorderSide(color: Colors.redAccent)
                                // ),
                                // filled: true, fillColor: Colors.grey[100],
                                // hintText: ""

                            ),
                            controller: _email,
                          ),
                          SizedBox(height: 25,),
                          Text("Gender"),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 150,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 42,
                              value: chosenvalue2,
                              underline: SizedBox(),
                              items: <String>['Male', 'Female','Transgender']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String value) {
                                setState(() {
                                  chosenvalue2 = value;
                                });
                              },
                            ),
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   child: FlatButton(
                          //     child: Text("CREATE",style: TextStyle(color: Colors.white,fontFamily: "Lato",fontSize: 14,fontWeight:FontWeight.bold )),
                          //     textColor: Colors.white,
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(25.0),
                          //         side: BorderSide(color: Colors.redAccent)
                          //     ),
                          //     padding: EdgeInsets.all(16),
                          //     onPressed: (){
                          //
                          //     },
                          //     color: new Color(0xff2F80ED),
                          //   ),
                          // ),
                          // SizedBox(height: 25,),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),

    );
  }
  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  Future<void> updatePatientProfile(File image, String dName, String email,String Age,String gender) async {
    isLoading = true;
    if (image != null) {
      String fileName ="image"+widget.id;
      StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = reference.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      if (taskSnapshot.error == null) {
            if (widget.id != null && widget.mobile != null) {

              final String downloadUrl =
              await taskSnapshot.ref.getDownloadURL();

              ApiService().updatePatientProfile(widget.id, widget.mobile, ConstantUtils().Patient, downloadUrl, dName, email,Age,gender);
              AuthService().toast("Profile Updated Successfully!!");
             Navigator.of(context).pop() ;

      //        await Firestore.instance
      //                  .collection("Users/Doctor")
      //                  .add({"id":userId,"image": downloadUrl,"doctorId": doctorId,"hospitalName": hospitalName,"specialist": specialist,"degree": degree,"doctorName": dName,"phoneNumber": phone,"emailId": email});
            } else {
              ApiService().updatePatientProfile(widget.id, widget.mobile, ConstantUtils().Patient, imagelink, dName, email,Age,gender);
              Navigator.of(context).pop() ;
            }
          }
    } else {

    }
  }
  FirebaseDatabase fb = FirebaseDatabase.instance;
  Future <PatientUser> getProfileDetails()async{
    try {
      var db = await fb.reference().child("User").child(widget.mobile);
      if (db != null) {
        db.once().then((DataSnapshot snapshot) {
          print(snapshot.value);
          if (snapshot.value == null) {
          } else {
            Map<dynamic, dynamic> values = snapshot.value;
            refreshToken = PatientUser.fromJson(values);
            _pName.text = refreshToken.Name;
            _age.text = refreshToken.Age;
            _phone.text = refreshToken.mobile;
            _email.text = refreshToken.emailId;
            chosenvalue2 = refreshToken.Gender;
            setState(() {
              imagelink = refreshToken.image;
            });
            print(imagelink);
          }
        });
      } else {

      }
    } catch (e) {
      print(e);
    }
  }
}
