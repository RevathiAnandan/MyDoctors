import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myarogya_mydoctor/model/DoctorUser.dart';

class EditProfileDoctor extends StatefulWidget {
  String userId;
  String mobile;

  EditProfileDoctor(this.userId, this.mobile);


  @override
  _EditProfileDoctorState createState() => _EditProfileDoctorState();
}

class _EditProfileDoctorState extends State<EditProfileDoctor> {
  FirebaseDatabase fb = FirebaseDatabase.instance;
  var refresh;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController dgreeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hosController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController specialController = TextEditingController();
  final TextEditingController idController = TextEditingController();
//  final TextEditingController starttym = TextEditingController();
  TextEditingController _interval = new TextEditingController();
  String starttym;
  String m_starttym;
  String e_starttym;
  String s_starttym;
  String endtym;
  String m_endtym;
  String e_endtym;
  String s_endtym;
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
    fb.reference().child('User').child(widget.mobile).update({
      "Name": nameController.text,
      "mobile": bioController.text,
      "degree": dgreeController.text,
      "emailId": emailController.text,
      "hospitalName": hosController.text,
      "Hospital Address": addressController.text,
      "specialist": specialController.text,
      "registerId": idController.text,
//      'End Time': endtym,
//      'Start Time': starttym,
//      'Consulting Interval': _interval.text,
//      "Morning Start Time":m_starttym,
//      "Morning End Time":m_endtym,
//      "Evening Start Time":e_starttym,
//      "Evening End Time":e_endtym,
//      "Sunday Start Time":s_starttym,
//      "Sunday End Time":s_endtym
    });
    print(starttym);
    print("Assigned");
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


  Widget TimePicker({String name, TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        Padding(
//          padding: const EdgeInsets.only(top: 12.0),
//          child: Text(
//            name,
//            style: TextStyle(color: Colors.grey),
//          ),
//        ),
//        TextField(
//          controller: controller,
//          decoration: InputDecoration(
//            hintText: name,
//          ),
//        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 40,
              width: 170,
              child: DateTimeField(
                readOnly: true,
                //inputType: InputType.time,
                format: DateFormat("HH:mm"),
                //editable: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    labelText: 'Start Time',
                    floatingLabelBehavior: FloatingLabelBehavior.never
                ),
                onShowPicker: (context, dt) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
                    builder: (context, child) => MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child),
                  );
                  return DateTimeField.convert(time);
                },
                onChanged: (dt) {
                  setState(() => m_starttym = dt.toString());
                  print('Selected date: $m_starttym');
                },
              ),
            ),
            Container(
              height: 40,
              width: 170,
              child: DateTimeField(
                readOnly: true,
                //inputType: InputType.time,
                format: DateFormat("HH:mm"),
                //editable: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    labelText: 'End Time',
                    floatingLabelBehavior: FloatingLabelBehavior.never
                ),
                onShowPicker: (context, dt) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
                    builder: (context, child) => MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child),
                  );
                  return DateTimeField.convert(time);
                },
                onChanged: (dt) {
                  setState(() =>{
                    m_endtym = dt.toString()
                  });
                  print('Selected date: $m_endtym');
                },
              ),
            ),
          ],
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
                icon: Icon(
                  Icons.close,
                  color: Colors.redAccent,
                ),
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
                        if (values == null) {
                          nameController.text = "";
                          bioController.text = "";
                          dgreeController.text = "";
                          emailController.text = "";
                          hosController.text = "";
                          addressController.text = "";
                          specialController.text = "";
                          idController.text = "";
                        } else {
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
                          endtym= values['End Time'];
                          starttym= values['Start Time'];
                         _interval.text= values['Consulting Interval'];
                          m_starttym= values["Morning Start Time"];
                          m_endtym= values["Morning End Time"];
                          e_starttym= values["Evening Start Time"];
                          e_endtym= values["Evening End Time"];
                          s_starttym= values["Sunday Start Time"];
                          s_endtym= values["Sunday End Time"];
                        }
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, bottom: 8.0),
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
                                  buildTextField(
                                      name: "Name", controller: nameController),
                                  buildTextField(
                                      name: "Mobile",
                                      controller: bioController),
                                  buildTextField(
                                      name: "Degree",
                                      controller: dgreeController),
                                  buildTextField(
                                      name: "Email",
                                      controller: emailController),
                                  buildTextField(
                                      name: "Hospital Name",
                                      controller: hosController),
                                  buildTextField(
                                      name: "Hospital Address",
                                      controller: addressController),
                                  buildTextField(
                                      name: "Specialist",
                                      controller: specialController),
                                  buildTextField(
                                      name: "Register Id",
                                      controller: idController),
//                                  SizedBox(
//                                    height: 15,
//                                  ),
//                                  Text("Available Time",
//                                      style: new TextStyle(
//                                          fontWeight: FontWeight.normal,
//                                          fontFamily: "Lato")),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  Row(
//                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                    children: [
//                                      Container(
//                                        height: 40,
//                                        width: 170,
//                                        child: DateTimeField(
//                                          readOnly: false,
//                                          //inputType: InputType.time,
//                                          format: DateFormat("HH:mm"),
//                                          //enabled: false,
//                                          decoration: InputDecoration(
//                                              border: OutlineInputBorder(),
//                                              labelStyle: TextStyle(
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 20
//                                              ),
//                                              labelText: (starttym != null)?starttym.split(" ")[1].split(".")[0] :'Start Time',
//                                              floatingLabelBehavior: FloatingLabelBehavior.never
//                                          ),
////                                          controller: starttym,
//                                          onShowPicker: (context, dt) async {
//                                            final time = await showTimePicker(
//                                              context: context,
//                                              initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
//                                              builder: (context, child) => MediaQuery(
//                                                  data: MediaQuery.of(context)
//                                                      .copyWith(alwaysUse24HourFormat: true),
//                                                  child: child),
//                                            );
//                                            return DateTimeField.convert(time);
//                                          },
//                                          onChanged: (dt) {
//                                            setState(() =>{
//                                              starttym = dt.toString()
//                                            }
//                                            );
//                                            print('Selected date: $starttym');
//                                            print(dt);
//                                          },
//                                        ),
//                                      ),
//                                      Container(
//                                        height: 40,
//                                        width: 170,
//                                        child: DateTimeField(
//                                          readOnly: true,
//                                          //inputType: InputType.time,
//                                          format: DateFormat("HH:mm"),
//                                          //editable: false,
//                                          decoration: InputDecoration(
//                                              border: OutlineInputBorder(),
//                                              labelStyle: TextStyle(
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 20
//                                              ),
//                                              labelText: 'End Time',
//                                              floatingLabelBehavior: FloatingLabelBehavior.never
//                                          ),
//                                          onShowPicker: (context, dt) async {
//                                            final time = await showTimePicker(
//                                              context: context,
//                                              initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
//                                              builder: (context, child) => MediaQuery(
//                                                  data: MediaQuery.of(context)
//                                                      .copyWith(alwaysUse24HourFormat: true),
//                                                  child: child),
//                                            );
//                                            return DateTimeField.convert(time);
//                                          },
//                                          onChanged: (dt) {
//                                            setState(() => endtym = dt.toString());
//                                            print('Selected date: $endtym');
//                                          },
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                  Text("Consulting Hours",
//                                      style: new TextStyle(
//                                          fontSize: 20,
//                                          //fontWeight: FontWeight.bold,
//                                          fontFamily: "Lato",
//                                          color: Colors.black)),
//                                  SizedBox(
//                                    height: 15,
//                                  ),
//                                  Text("Morning",
//                                      style: new TextStyle(
//                                          fontWeight: FontWeight.normal,
//                                          fontFamily: "Lato")),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  Row(
//                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                    children: [
//                                      Container(
//                                        height: 40,
//                                        width: 170,
//                                        child: DateTimeField(
//                                          readOnly: true,
//                                          //inputType: InputType.time,
//                                          format: DateFormat("HH:mm"),
//                                          //editable: false,
//                                          decoration: InputDecoration(
//                                              border: OutlineInputBorder(),
//                                              labelStyle: TextStyle(
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 20
//                                              ),
//                                              labelText: 'Start Time',
//                                              floatingLabelBehavior: FloatingLabelBehavior.never
//                                          ),
//                                          onShowPicker: (context, dt) async {
//                                            final time = await showTimePicker(
//                                              context: context,
//                                              initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
//                                              builder: (context, child) => MediaQuery(
//                                                  data: MediaQuery.of(context)
//                                                      .copyWith(alwaysUse24HourFormat: true),
//                                                  child: child),
//                                            );
//                                            return DateTimeField.convert(time);
//                                          },
//                                          onChanged: (dt) {
//                                            setState(() => m_starttym = dt.toString());
//                                            print('Selected date: $m_starttym');
//                                          },
//                                        ),
//                                      ),
//                                      Container(
//                                        height: 40,
//                                        width: 170,
//                                        child: DateTimeField(
//                                          readOnly: true,
//                                          //inputType: InputType.time,
//                                          format: DateFormat("HH:mm"),
//                                          //editable: false,
//                                          decoration: InputDecoration(
//                                              border: OutlineInputBorder(),
//                                              labelStyle: TextStyle(
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 20
//                                              ),
//                                              labelText: 'End Time',
//                                              floatingLabelBehavior: FloatingLabelBehavior.never
//                                          ),
//                                          onShowPicker: (context, dt) async {
//                                            final time = await showTimePicker(
//                                              context: context,
//                                              initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
//                                              builder: (context, child) => MediaQuery(
//                                                  data: MediaQuery.of(context)
//                                                      .copyWith(alwaysUse24HourFormat: true),
//                                                  child: child),
//                                            );
//                                            return DateTimeField.convert(time);
//                                          },
//                                          onChanged: (dt) {
//                                            setState(() =>{
//                                              m_endtym = dt.toString()
//                                            });
//                                            print('Selected date: $m_endtym');
//                                          },
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  Text("Evening",
//                                      style: new TextStyle(
//                                          fontWeight: FontWeight.normal,
//                                          fontFamily: "Lato")),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  Row(
//                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                    children: [
//                                      Container(
//                                        height: 40,
//                                        width: 170,
//                                        child: DateTimeField(
//                                          readOnly: true,
//                                          //inputType: InputType.time,
//                                          format: DateFormat("HH:mm"),
//                                          //editable: false,
//                                          decoration: InputDecoration(
//                                              border: OutlineInputBorder(),
//                                              labelStyle: TextStyle(
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 20
//                                              ),
//                                              labelText: 'Start Time',
//                                              floatingLabelBehavior: FloatingLabelBehavior.never
//                                          ),
//                                          onShowPicker: (context, dt) async {
//                                            final time = await showTimePicker(
//                                              context: context,
//                                              initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
//                                              builder: (context, child) => MediaQuery(
//                                                  data: MediaQuery.of(context)
//                                                      .copyWith(alwaysUse24HourFormat: true),
//                                                  child: child),
//                                            );
//                                            return DateTimeField.convert(time);
//
//                                          },
//                                          onChanged: (dt) {
//                                            setState(() => e_starttym = dt.toString());
//                                            print('Selected date: $starttym');
//                                          },
//                                        ),
//                                      ),
//                                      Container(
//                                        height: 40,
//                                        width: 170,
//                                        child: DateTimeField(
//                                          readOnly: true,
//                                          //inputType: InputType.time,
//                                          format: DateFormat("HH:mm"),
//                                          //editable: false,
//                                          decoration: InputDecoration(
//                                              border: OutlineInputBorder(),
//                                              labelStyle: TextStyle(
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 20
//                                              ),
//                                              labelText: 'End Time',
//                                              floatingLabelBehavior: FloatingLabelBehavior.never
//                                          ),
//                                          onShowPicker: (context, dt) async {
//                                            final time = await showTimePicker(
//                                              context: context,
//                                              initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
//                                              builder: (context, child) => MediaQuery(
//                                                  data: MediaQuery.of(context)
//                                                      .copyWith(alwaysUse24HourFormat: true),
//                                                  child: child),
//                                            );
//                                            return DateTimeField.convert(time);
//                                          },
//                                          onChanged: (dt) {
//                                            setState(() => e_endtym = dt.toString());
//                                            print('Selected date: $e_endtym');
//                                          },
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  Text("Sunday",
//                                      style: new TextStyle(
//                                          fontWeight: FontWeight.normal,
//                                          fontFamily: "Lato")),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  Row(
//                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                    children: [
//                                      Container(
//                                        height: 40,
//                                        width: 170,
//                                        child: DateTimeField(
//                                          readOnly: true,
//                                          //inputType: InputType.time,
//                                          format: DateFormat("HH:mm"),
//                                          //editable: false,
//                                          decoration: InputDecoration(
//                                              border: OutlineInputBorder(),
//                                              labelStyle: TextStyle(
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 20
//                                              ),
//                                              labelText: 'Start Time',
//                                              floatingLabelBehavior: FloatingLabelBehavior.never
//                                          ),
//                                          onShowPicker: (context, dt) async {
//                                            final time = await showTimePicker(
//                                              context: context,
//                                              initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
//                                              builder: (context, child) => MediaQuery(
//                                                  data: MediaQuery.of(context)
//                                                      .copyWith(alwaysUse24HourFormat: true),
//                                                  child: child),
//                                            );
//                                            return DateTimeField.convert(time);
//                                          },
//                                          onChanged: (dt) {
//                                            setState(() => s_starttym = dt.toString());
//                                            print('Selected date: $s_starttym');
//                                          },
//                                        ),
//                                      ),
//                                      Container(
//                                        height: 40,
//                                        width: 170,
//                                        child: DateTimeField(
//                                          readOnly: true,
//                                          //inputType: InputType.time,
//                                          format: DateFormat("HH:mm"),
//                                          //editable: false,
//                                          decoration: InputDecoration(
//                                              border: OutlineInputBorder(),
//                                              labelStyle: TextStyle(
//                                                  fontWeight: FontWeight.bold,
//                                                  fontSize: 20
//                                              ),
//                                              labelText: 'End Time',
//                                              floatingLabelBehavior: FloatingLabelBehavior.never
//                                          ),
//                                          onShowPicker: (context, dt) async {
//                                            final time = await showTimePicker(
//                                              context: context,
//                                              initialTime: TimeOfDay.fromDateTime(dt ?? DateTime.now()),
//                                              builder: (context, child) => MediaQuery(
//                                                  data: MediaQuery.of(context)
//                                                      .copyWith(alwaysUse24HourFormat: true),
//                                                  child: child),
//                                            );
//                                            return DateTimeField.convert(time);
//                                          },
//                                          onChanged: (dt) {
//                                            setState(() => s_endtym = dt.toString());
//                                            print('Selected date: $s_endtym');
//                                          },
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  Text("Consulting Interval",
//                                      style: new TextStyle(
//                                          fontWeight: FontWeight.normal,
//                                          fontFamily: "Lato")),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
//                                  TextFormField(
//                                    decoration: InputDecoration(
//                                        contentPadding: EdgeInsets.fromLTRB(
//                                            20.0, 5.0, 20.0, 5.0),
//                                        prefixIcon: new Icon(
//                                            Icons.timer,
//                                            color: Colors.redAccent),
//                                        enabledBorder: OutlineInputBorder(
//                                            borderRadius: BorderRadius.all(
//                                                Radius.circular(8)),
//                                            borderSide: BorderSide(
//                                                color: Colors.redAccent)),
//                                        focusedBorder: OutlineInputBorder(
//                                            borderRadius: BorderRadius.all(
//                                                Radius.circular(8)),
//                                            borderSide: BorderSide(
//                                                color: Colors.redAccent)),
//                                        filled: true,
//                                        fillColor: Colors.grey[100],
//                                        hintText: ""),
//                                    controller: _interval,
//                                  ),
//                                  SizedBox(
//                                    height: 5,
//                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            )));
  }
}
