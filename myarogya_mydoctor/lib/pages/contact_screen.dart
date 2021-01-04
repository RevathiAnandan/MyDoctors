
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:myarogya_mydoctor/services/ApiService.dart';
import 'package:myarogya_mydoctor/services/authService.dart';
import 'package:myarogya_mydoctor/utils/const.dart';

class ContactsPage extends StatefulWidget {
  final String  mobile;
  final String  category;
  ContactsPage(this.mobile,this.category);
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool duplicate = false;
  Iterable<Contact> _contacts;
  FirebaseDatabase fb = FirebaseDatabase.instance;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: (Text('Contacts')),
//      ),
      body: _contacts != null
      //Build a list view of all contacts, displaying their avatar and
      // display name
          ? ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = _contacts?.elementAt(index);
          return ListTile(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
            leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                ? CircleAvatar(
              backgroundImage: MemoryImage(contact.avatar),
            )
                : CircleAvatar(
              child: Text(contact.initials()),
              backgroundColor: Theme.of(context).accentColor,
            ),
            title: Text(contact.displayName ?? ''),
            subtitle: Text(contact.phones.elementAt(0).value),
            onTap: () async{
              print("${contact.displayName}""${contact.phones.elementAt(0).value}");
              showAlertDialog(context,contact.displayName,contact.phones.elementAt(0).value);
            },
            //This can be further expanded to showing contacts detail
            // onPressed().
          );
        },
      )
          : Center(child: const CircularProgressIndicator()),
    );
  }

  showAlertDialog(BuildContext context,String name,String mobile) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Add"),
      onPressed:  () async{
//        if(widget.category == "MY PATIENT") {
//          ApiService().addPatientToDoctor(mobile, widget.mobile, name);
//          ApiService().addDoctorToPatient(mobile, widget.mobile, name);
//          Navigator.of(context).pop();
//        }else{
//          ApiService().addPatientToDoctor(widget.mobile, mobile, name);
//          ApiService().addDoctorToPatient(widget.mobile,mobile, name);
//          Navigator.of(context).pop();
//        }
        checkDuplication(mobile,name);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add Contact"),
      content: Text("Would you like to Add the Contact?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  checkDuplication(String phone,String name){
    if(widget.category == "MY PATIENT") {
      var db = fb.reference().child("User").child(widget.mobile).child(
          "myPatient");
      db.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        print(snapshot.value);
        if (values == null) {
          duplicate = false;
        } else {
          values.forEach((key, values) {
            var refreshToken = values["phone"].toString();
            if (refreshToken == phone) {
              duplicate = true;
            }
            print("Values!!!" + values["phone"].toString());
            print(refreshToken);
            print(duplicate);
          });
        }
        checkDuplicate(phone, name);
      }
      );
    }else {
      var db = fb.reference().child("User").child(widget.mobile).child(
          "myDoctor");
      db.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        print(snapshot.value);
        if (values == null) {
          duplicate = false;
        } else {
          values.forEach((key, values) {
            var refreshToken = values["phone"].toString();
            if (refreshToken == phone) {
              duplicate = true;
            }
            print("Values!!!" + values["phone"].toString());
            print(refreshToken);
            print(duplicate);
          });
        }
        checkDuplicate(phone, name);
      }
      );
    }
  }
  checkDuplicate(String mobile,String name){
    if(duplicate == false){
      if(widget.category == "MY PATIENT") {
        ApiService().addPatientToDoctor(mobile, widget.mobile, name);
        ApiService().addDoctorToPatient(mobile, widget.mobile, name);
        Navigator.of(context).pop();
        AuthService().toast("Added Successfully");
      }else{
        ApiService().addPatientToDoctor(widget.mobile, mobile, name);
        ApiService().addDoctorToPatient(widget.mobile,mobile, name);
        Navigator.of(context).pop();
        AuthService().toast("Added Successfully");
      }
      print("not"+ duplicate.toString());
    }else if(duplicate == true){
      Navigator.pop(context);
      AuthService().toast("The Number Already Exist");
      duplicate = false;
      print("exist"+ duplicate.toString());
    }
  }
}