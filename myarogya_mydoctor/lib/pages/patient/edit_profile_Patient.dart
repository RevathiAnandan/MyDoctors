import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myarogya_mydoctor/model/DoctorUser.dart';
//class EditProfileDoctor extends StatefulWidget {
//  String userId;
//  String mobile;
//  EditProfileDoctor(this.userId, this.mobile);
//  @override
//  _EditProfileDoctorState createState() => _EditProfileDoctorState();
//}
//
//class _EditProfileDoctorState extends State<EditProfileDoctor> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//
//    );
//  }
//}


class EditProfilePatient extends StatefulWidget {
  String userId;
  String mobile;

  EditProfilePatient(this.userId, this.mobile);

  @override
  _EditProfilePatientState createState() => _EditProfilePatientState();
}

class _EditProfilePatientState extends State<EditProfilePatient> {
  FirebaseDatabase fb = FirebaseDatabase.instance;

  var refresh;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController bioController = TextEditingController();

  final TextEditingController dgreeController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController specialController = TextEditingController();

  final TextEditingController idController = TextEditingController();

  changeProfilePhoto(BuildContext parentContext) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Photo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Changing your profile photo has not been implemented yet'),
              ],
            ),
          ),
        );
      },
    );
  }
  String chosenvalue2 = "Male";

  applyChanges() {
    fb.reference().child('User').child(widget.mobile)
        .update({
      "Name": nameController.text,
      "mobile": bioController.text,
      //"degree": dgreeController.text,
      "emailId": emailController.text,
      "Age": ageController.text,
      "Gender": chosenvalue2,
      //"Hospital Address": addressController.text,
      //"specialist": specialController.text,
      //"registerId": idController.text,
    });
  }

  Widget buildTextField({String name, TextEditingController controller}) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            name,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: name,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.close,color: Colors.redAccent,),
                onPressed: () {
                  Navigator.maybePop(context);
                },
              ),
              title: Text('Edit Profile',
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
                      applyChanges();
                      Navigator.maybePop(context);
                    })
              ],
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  child: FutureBuilder(
                      future: fb.reference().child('User').child(widget.mobile).once(),
                      builder: (context, snapshot) {

                        if (!snapshot.hasData)
                          return Container(
                              alignment: FractionalOffset.center,
                              child: CircularProgressIndicator());

                        Map<dynamic, dynamic> values = snapshot.data.value;
                        if(values == null){
                          nameController.text = " ";
                          bioController.text =" ";
                          emailController.text = "";
                          ageController.text = "";
                        }else{
                          values.forEach((key, values) {
                            print(values);
                            refresh = values;
                          });
                          nameController.text = values['Name'];
                          bioController.text = values['mobile'];
                          emailController.text = values['emailId'];
                          ageController.text = values['Age'];
                        }
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                              child: CircleAvatar(
//                  backgroundImage: NetworkImage(currentUserModel.photoUrl),
                                radius: 50.0,
                              ),
                            ),
                            FlatButton(
                                onPressed: () {
                                  changeProfilePhoto(context);
                                },
                                child: Text(
                                  "Change Photo",
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  buildTextField(name: "Name", controller: nameController),
                                  buildTextField(name: "Mobile", controller: bioController),
                                  buildTextField(name: "Email", controller: emailController),
                                  buildTextField(name: "Age", controller: ageController),
                                  SizedBox(
                                    height: 5,
                                  ),
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
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            )
        )
    );



  }
}