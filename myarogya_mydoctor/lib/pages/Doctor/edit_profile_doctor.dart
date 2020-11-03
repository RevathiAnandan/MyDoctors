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


class EditProfileDoctor extends StatelessWidget {
  String userId;
  String mobile;
  FirebaseDatabase fb = FirebaseDatabase.instance;
  var refresh;

  EditProfileDoctor(this.userId, this.mobile);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController dgreeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hosController = TextEditingController();
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

  applyChanges() {
    fb.reference().child('User').child(mobile)
        .update({
      "Name": nameController.text,
      "mobile": bioController.text,
      "degree": dgreeController.text,
      "emailId": emailController.text,
      "hospitalName": hosController.text,
      "Hospital Address": addressController.text,
      "specialist": specialController.text,
      "registerId": idController.text,
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
          future: fb.reference().child('User').child(mobile).once(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator());

            Map<dynamic, dynamic> values = snapshot.data.value;
            values.forEach((key, values) {
            print(values);
            refresh = values;

            });
            nameController.text = values['Name'];
            bioController.text = values['mobile'];
            dgreeController.text = values['degree'];
            emailController.text = values['emailId'];
            hosController.text = values['hospitalName'];
            addressController.text = values['Hospital Address'];
            specialController.text = values['specialist'];
            idController.text = values['registerId'];



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
                    children: <Widget>[
                      buildTextField(name: "Name", controller: nameController),
                      buildTextField(name: "Mobile", controller: bioController),
                      buildTextField(name: "Degree", controller: dgreeController),
                      buildTextField(name: "Email", controller: emailController),
                      buildTextField(name: "Hospital Name", controller: hosController),
                      buildTextField(name: "Hospital Address", controller: addressController),
                      buildTextField(name: "Specialist", controller: specialController),
                      buildTextField(name: "Register Id", controller: idController),
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

//    return Scaffold(
//      body: ,
//      child: FutureBuilder(
//          future: fb.reference().child('User').child(mobile).once(),
//          builder: (context, snapshot) {
//            if (!snapshot.hasData)
//              return Container(
//                  alignment: FractionalOffset.center,
//                  child: CircularProgressIndicator());
//
//            Map<dynamic, dynamic> values = snapshot.data.value;
//            values.forEach((key, values) {
//            print(values);
//            });
//
////          nameController.text = user.displayName;
////          bioController.text = user.bio;
//
//            return Column(
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
//                  child: CircleAvatar(
////                  backgroundImage: NetworkImage(currentUserModel.photoUrl),
//                    radius: 50.0,
//                  ),
//                ),
//                FlatButton(
//                    onPressed: () {
//                      changeProfilePhoto(context);
//                    },
//                    child: Text(
//                      "Change Photo",
//                      style: const TextStyle(
//                          color: Colors.blue,
//                          fontSize: 20.0,
//                          fontWeight: FontWeight.bold),
//                    )),
//                Padding(
//                  padding: const EdgeInsets.all(16.0),
//                  child: Column(
//                    children: <Widget>[
//                      buildTextField(name: "Name", controller: nameController),
//                      buildTextField(name: "Bio", controller: bioController),
//                    ],
//                  ),
//                ),
//                Padding(
//                    padding: const EdgeInsets.all(16.0),
//                    child: MaterialButton(
//                        onPressed: () => {},
//                        child: Text("Logout")
//
//                    )
//                )
//              ],
//            );
//          }),
//    );
//  }

  }
}